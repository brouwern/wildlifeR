% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/eaglesPA.R
\docType{data}
\name{eaglesPA}
\alias{eaglesPA}
\title{Eagles in Pennsylvania dataset}
\format{A data frame with 2 columns:
\describe{
  \item{year}{Year of data collection, beginning in 1980}
  \item{eagles}{Number of breeding pairs of eagles (male plus female)}

}}
\source{
\url{https://www.fws.gov/midwest/eagle/population/nos_state_tbl.html}

\url{http://www.media.pa.gov/pages/Game-Commission-Details.aspx?newsid=44}
}
\usage{
eaglesPA
}
\description{
A dataset containing the number of nesting pairs of eagles found in Pennsylvania, USA, from 1980 through 2015.  Data is not available for all years and is given as NA.
}
\examples{

## Plot number of eagles over time
plot(eagles ~ year, data = eaglesPA)

}
\references{
Pennsyulvania Game Commission.  ND.  Bald Eagle: Haliaeetus leucocephalus. http://www.pgc.pa.gov/Wildlife/EndangeredandThreatened/Pages/BaldEagle.aspx
}
\keyword{datasets}
