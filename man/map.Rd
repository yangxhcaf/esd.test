\name{map}
\alias{map}
\alias{map.default}
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
map(x,...)
map.default(x,it=NULL,is=NULL,projection="lonlat",
           xlim=NULL,ylim=NULL,n=15,
           cols=NULL,breaks=NULL,
           what=NULL,gridlines=FALSE,
           lonR=NULL,latR=-90,axiR=NULL,...)
map.station(x = NULL, stid = NULL, ele = NULL, lon = NULL, lat = NULL, 
            alt = NULL, cntr = NULL, src = NULL, x.rng = NULL, y.rng = NULL, 
            col = "darkgrey",bg="grey",cex=0.5,cex.select=0.7,
            breaks = NULL, zexpr = "alt",select=NULL,col.select=NULL,
            showall=FALSE)
map.matrix(x,projection="lonlat",...)
map.comb(x,xlim=NULL,ylim=NULL,pattern=1,n=15,
         projection="lonlat",cols=NULL,breaks=NULL,
         lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
         gridlines=TRUE)
map.eof(x,pattern=1,xlim=NULL,ylim=NULL,n=15,
        projection="lonlat",cols=NULL,
        breaks=NULL,lonR=NULL,latR=NULL,axiR=0,
        what=c("fill","contour"),gridlines=TRUE)
map.ds(x,xlim=NULL,ylim=NULL,what=c("fill","contour"),
       n=15,projection="lonlat",
       lonR=NULL,latR=NULL,axiR=0,gridlines=TRUE,
       cols=NULL,breaks=NULL)
map.field(x,xlim=NULL,ylim=NULL,what=c("fill","contour"),
          FUN='mean',n=15,projection="lonlat",
          lonR=NULL,latR=NULL,
          axiR=0,gridlines=FALSE,cols=NULL,breaks=NULL)
map.corfield(x,xlim=xlim,ylim=ylim,n=15,projection="lonlat",
             cols=NULL,breaks=NULL,
             lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
             gridlines=TRUE)
map.cca(x,icca=1,xlim=NULL,ylim=NULL,what=c("fill","contour"),
        n=15,projection="lonlat",
        lonR=NULL,latR=NULL,
        axiR=0,gridlines=FALSE,cols=NULL,breaks=NULL)
map.mvr(x,xlim=NULL,ylim=NULL,
        n=15,projection="lonlat",
        cols=NULL,breaks=NULL,
        lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
        gridlines=TRUE)
map.pca(x,it=NULL,is=NULL,ipca=1,cex=1.5,
        xlim=NULL,ylim=NULL,
        n=15,projection="lonlat",
        cols=NULL,breaks=NULL,
        lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
        gridlines=TRUE
map.trend(x,xlim=NULL,ylim=NULL,n=15,projection="lonlat",
          cols=NULL,breaks=NULL,
          lonR=NULL,latR=NULL,axiR=0,what=c("fill","contour"),
          gridlines=TRUE)
lonlatprojection(x,xlim=NULL,ylim=NULL,n=15,cols=NULL,breaks=NULL,
                 what=c("fill","contour"),gridlines=TRUE)
map.googleearth(x)
rotM(x=0,y=0,z=0)
gridbox(x,cols,density = NULL, angle = 45)
map2sphere(x,lonR=NULL,latR=NULL,axiR=0,
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

