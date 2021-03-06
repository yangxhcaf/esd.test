# Script to calculate the statistics of spell durations, e.g. dry and wet periods
# or duration of extremes.
#
# R.E. Benestad, met.no, Oslo, Norway 11.04.2013
# rasmus.benestad@met.no
#------------------------------------------------------------------------


spell <- function(x,threshold,...) UseMethod("spell")


spell.default <- function(x,threshold,upper=150,...) {
  x[!is.finite(x)] <- 0
  above <- coredata(x) > threshold
  n <- length(index(x))
  t <- 1:n
  cth <- cumsum(above)
  dt <- c(0,diff(above))
  #col <- c("blue","grey","red")
  #dev.new(); plot(cth,pch=".",col=col[ds+2])
  dt <- dt[is.finite(dt)]
  #print(summary(dt))
  start <- t[dt > 0]
  end <- t[dt < 0]
  #dev.new(); hist(diff(start),col="blue",breaks=0:60)
  #dev.new(); hist(diff(end),col="red",breaks=0:60)
  #print(c(length(start),length(end)))

  # Always start with a fresh spell
  if (start[1] > end[1]) {
    end <- end[-1]
  }
  if (length(start) > length(end)) {
    start <- start[-length(start)]
  }
  if (length(start) < length(end)) {
    end <- end[-length(end)]
  }
  chksum <- sum( (start - end) < 0)    
  #print(c(length(start),length(end)))
  #dev.new(); plot(start,end,pch="."); lines(c(0,100000),c(0,100000),col="grey")
  
  low <- t[start[-1]] - t[end[-length(end)]]
  high <- t[end] - t[start]
  #print(summary(high))  
  #print("low:"); print(summary(low))
  ignoreh <- high > upper 
  ignorel <- abs(low) > upper 
  high[ignoreh] <- NA
  low[ignorel] <- NA
  
  Above <- zoo(high,order.by=index(x)[start])
  #dev.new(); plot(Above)
  Below <- zoo(low,order.by=index(x)[end])
  #dev.new(); plot(Below)

  y <- merge(Above,Below,all=TRUE)

  if (attr(x,'variable')=='t2m') attr(y,'variable') <-  c("warm","cold") else
                                 attr(y,'variable') <-  c("wet","dry")
  attr(y,'unit') <- rep("days",2)
  attr(y,'threshold') <- rep(threshold,2)
  attr(y,'threshold.unit') <- rep(attr(x,'unit'),2)
  attr(y,'chksum') <- rep(chksum,2)
  attr(y,'uncredibly.high') <- rep(t[ignoreh],2)
  attr(y,'uncredibly.low') <- rep(t[ignorel],2)
  attr(y,'p.above') <- rep(sum(above)/length(above),2)

  class(y) <- c("spell",class(x))
  invisible(y)
}


spell.station <-  function(x,threshold,upper=150,...) {
  y <- spell.default(x,threshold=threshold,upper=upper,...)
  y <- attrcp(x,y,ignore=c("variable","unit"))
  natr <- names(attributes(y))
  for (i in 1:length(natr)) 
    if (length(attr(y,natr[i]))==1) attr(y,natr[i]) <- rep(attr(y,natr[i]),2)
  invisible(y)
}



count <- function(x,threshold=1,fraction=FALSE) {
  count <- sum(x > threshold,na.rm=TRUE)
  if (fraction) count <- count/sum(is.finite(x))
  return(count)
}

wetfreq <- function(x,threshold=1) {
  y <- exceedance.default(x,threshold=threshold,fun="freq")
  return(y)
}

nevents <- function(x,threshold=1) {
  y <- exceedance.default(x,threshold=threshold,fun="count")
  return(y)
}

wetmean <- function(x,threshold=1) {
   y <- exceedance.default(x,threshold=threshold,fun="mean")
   return(y)
}

# Exceedance is a function that 
exceedance <- function(x,threshold=1,fun='mean',...) UseMethod("exceedance")

exceedance.default <- function(x,threshold=1,fun='mean',na.rm=TRUE,...) {
  #print("HERE");  str(x)
  yrs <- year(x); d <- dim(x)
  X <- x; X[X <= threshold] <- NA
  # ns = number of stations
  if (is.null(d)) ns <- 1 else ns <- d[2]
  if ((fun!="count") & (fun!="freq")) {
    #print(fun)
    # eval(parse(text=paste("y <- ",fun,'(X,...)',sep='')))
    if ( (sum(is.element(names(formals(fun)),'na.rm')==1)) |
         (sum(is.element(fun,c('mean','min','max','sum','quantile')))>0 ) )
        y <- apply(matrix(X,length(X),ns),2,fun,na.rm=na.rm, ...) else
        y <- apply(matrix(X,length(X),ns),2,fun, ...)
    attr(y,'unit') <- attr(x,'unit')
  } else if (fun=="count")  {
    #print("Wet-day count")
    y <- sum(is.finite(X))
    attr(y,'unit') <- paste("counts | X >",threshold,attr(y,'unit'))
  } else if (fun=="freq") {
    #print(paste("Wet-day frequency",sum(is.finite(X)),sum(is.finite(x)),
    #            length(x),length(X),sum(is.finite(X))/sum(is.finite(x))))
    y <- sum(is.finite(X))/sum(is.finite(x))
    attr(y,'unit') <- paste("frequency | X >",threshold,attr(y,'unit'))
  }
  #str(y)
  #y <- attrcp(x,y)
  attr(y,'variable') <- paste(attr(x,'variable'),": exceedance above",threshold,
                              "-",fun)
  attr(y,'history') <- history.stamp(x)
  return(y)
}

exceedance.station <- function(x,threshold=1,fun='mean',...) {
  y <- exceedance.default(x,threshold=threshold,fun=fun,...)
  return(y)
}

exceedance.field <- function(x,threshold=1,fun='mean',...) {
  y <- exceedance.default(x,threshold=threshold,fun=fun,...)
  #dimensions...
  return(y)
}

hist.spell <- function(x, ...) {
  n <- seq(0,ceiling(max(c(abs(x)),na.rm=TRUE))+1,by=1)
  hh <- hist(x[,1],breaks=n,plot=FALSE)
  hl <- hist(abs(x[,2]),breaks=n,plot=FALSE)
#  dh <- dpois(n,lambda=mean(x[,1],na.rm=TRUE))
#  dl <- dpois(n,lambda=mean(abs(x[,2]),na.rm=TRUE))
  dh <- dgeom(n,attr(x,'p.above'))
  dl <- dgeom(n,1-attr(x,'p.above'))

  col <- c('red','blue')
  runs <- c('hot','cold')
  spelltype <- 'hot and cold'
  if (sum(is.element(attr(x,'variable'),c('wet','dry')))>0) {
    col <- c('darkblue','brown')
    runs <- c('wet','dry')
    spelltype <- 'wet and dry' 
  }

  main=paste(attr(x,'location'),spelltype,'spell duration')
  par(bty="n")
  plot(hh$mids,hh$density,type="s",col=col[1],lwd=3,
       xlab="",ylab="days",main=main,
       sub=paste("threshold=",attr(x,'threshold'),attr(x,'threshold.unit')))
  lines(hl$mids,hl$density,type="s",col=col[2],lwd=3)
  lines(n,dh,col=col[1],lty=2)
  lines(n,dl,col=col[2],lty=2)

  par(xaxt="n",yaxt="n",bty="n",fig=c(0.5,0.95,0.5,0.95),new=TRUE)
  plot(c(0,1),c(0,1),type="n",xlab="",ylab="")
  legend(0.1,0.9,runs,col=col,lty=1,lwd=3,bty="n")
  
}

# Heating degree day
HDD <- function(x,x0=18,na.rm=TRUE) {
  cold <- x < x0
  hdd <- sum(x0 - x[cold],na.rm=na.rm)
  return(hdd)
}

# Cooling degree day
CDD <- function(x,x0=22,na.rm=TRUE) {
  warm <- x > x0
  cdd <- sum(x[warm] - x0,na.rm=na.rm)
  return(cdd)
}

# Growing degree days
# http://en.wikipedia.org/wiki/Growing_degree-day
GDD <- function(x,x0=10,na.rm=TRUE) {
  gdd <- CDD(x,x0=x0)
  attr(gdd,'url') <- 'http://en.wikipedia.org/wiki/Growing_degree-day'
  return(gdd)
}
