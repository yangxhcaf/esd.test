\name{map}
\alias{map}
\alias{map.default}
\alias{map.matrix}
\alias{map.station}
\alias{map.comb}
\alias{map.eof}
\alias{map.ds}
\alias{map.field}
\alias{map.corfield}
\alias{map.cca}
\alias{map.mvr}
\alias{map.pca}
\alias{map.trend}
\alias{lonlatprojection}
\alias{map.googleearth}
\alias{rotM}
\alias{gridbox}
\alias{map2sphere}

\title{Plot maps for esd objects}
\description{Make map of geophysical data. These plot functions are S3 methods for esd objects.
}
\usage{
map(x,it=NULL,is=NULL,new=TRUE,...)
map.default(x,it=NULL,is=NULL,new=TRUE,projection="lonlat",
            xlim=NULL,ylim=NULL,n=15,
            col=NULL,breaks=NULL,
            what=NULL,gridlines=FALSE,
            lonR=NULL,latR=-90,axiR=NULL,...)
map.matrix(x,new=TRUE,...)
map.comb(x,it=NULL,is=NULL,new=TRUE,xlim=NULL,ylim=NULL,
         pattern=1,n=15,
         projection="lonlat",col=NULL,breaks=NULL,
         lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
         gridlines=TRUE,...)
map.eof(x,it=NULL,is=NULL,new=TRUE,pattern=1,
        xlim=NULL,ylim=NULL,n=15,
        projection="lonlat",col=NULL,
        breaks=NULL,lonR=NULL,latR=NULL,axiR=0,
        what=c("fill","contour"),gridlines=TRUE,...)
map.ds(x,it=NULL,is=NULL,new=TRUE,xlim=xlim,ylim=ylim,
       what=c("fill","contour"),
       n=15,projection="lonlat",
       lonR=NULL,latR=NULL,axiR=0,gridlines=TRUE,
       col=NULL,breaks=NULL,...)
map.field(x,it=NULL,is=NULL,new=TRUE,xlim=NULL,ylim=NULL,
          what=c("fill","contour"),
          FUN='mean',n=15,projection="lonlat",
          lonR=NULL,latR=NULL,na.rm=TRUE,
          axiR=0,gridlines=FALSE,col=NULL,breaks=NULL,...)
map.corfield(x,new=TRUE,xlim=NULL,ylim=NULL,n=15,
             projection="lonlat",
             col=NULL,breaks=seq(-1,1,0.1),
             lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
             gridlines=TRUE,...)
map.trend(x,it=NULL,is=NULL,new=TRUE,xlim=NULL,ylim=NULL,n=15,
          projection="lonlat",
          col=NULL,breaks=NULL,
          lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
          gridlines=TRUE,...)
map.pca(x,new=TRUE,FUN='mean',pattern=1,...)
map.mvr(x,it=NULL,is=NULL,new=TRUE,xlim=NULL,ylim=NULL,
        n=15,projection="lonlat",
        col=NULL,breaks=NULL,
        lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
        gridlines=TRUE,...)
map.cca(x,it=NULL,is=NULL,new=TRUE,icca=1,xlim=NULL,ylim=NULL,
        what=c("fill","contour"),
        n=15,projection="lonlat",
        lonR=NULL,latR=NULL,
        axiR=0,gridlines=FALSE,col=NULL,breaks=NULL,...)
lonlatprojection(x,it=NULL,is=NULL,xlim=NULL,ylim=NULL,
                 n=15,col=NULL,breaks=NULL,geography=TRUE,
                 what=c("fill","contour"),gridlines=TRUE,
                 new=TRUE,...)
map.googleearth(x)
rotM(x=0,y=0,z=0)
gridbox(x,cols,density = NULL, angle = 45)
map2sphere(x,n=30,lonR=NULL,latR=NULL,axiR=0,new=TRUE,
           what=c("fill","contour"),gridlines=TRUE,cols=NULL)
}
\arguments{
  \item{x}{the object to be plotted}
  \item{pattern}{Which EOF pattern (mode) to plot}
  \item{cols}{Colour scales, either as an output from \code{\link{rbg}}
    or a single character string 'bwr' (blue-white-red) og 'rwb' (red-white-blue')}
 }
\value{A field object}

\seealso{
  \code{\link{plotstation}}
}

\author{R.E. Benestad}
\examples{
# Example: use aggregate to compute annual mean temperature for Svalbard:
data(Svalbard)
year <- as.numeric( format(index(Svalbard), '\%Y') ) 
y <- aggregate(Svalbard, by=year, mean, na.rm = FALSE) 
plot(y)
}
\keyword{hplot}


