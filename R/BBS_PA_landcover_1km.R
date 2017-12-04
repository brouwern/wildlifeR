#' Land cover buffers from the 1 km surrounding Breeding Bird Survey Routes (BBS) in Pennsylvania
#'
#' Landcover within a 1km buffer of Pennsylvania BBS routes.  Original data
#' from the National Land Cover Database (NLCD)
#' https://catalog.data.gov/dataset/national-land-cover-database-nlcd-land-cover-collection
#' The data were taken from the 2006 NLCD dataset.
#'
#' @format A data frame...
#' \describe{
#'   \item{Route}{BBS route number}
#'   \item{BCR}{Bird conservation region}
#'   \item{State}{State}
#'   \item{RT..NAME}{Route name}
#'   \item{RT..LENG.}{length of route}
#'   \item{NLCD.0}{amount of habitat in category 0 of the National Land Cover Database}
#'   \item{NLCD.11}{Open water}
#'   \item{NLCD.12}{NLCD.12}
#'   \item{NLCD.21}{Developed Open Space; town and city parks, recreational fields, large-lot neighborhoods}
#'   \item{NLCD.22}{Developed Low Intensity; 1 of 4 developed cover classes}
#'   \item{NLCD.23}{Developed Medium Intensity; 1 of 4 developed cover classes}
#'   \item{NLCD.24}{Developed High Intensity; 1 of 4 developed cover classes}
#'   \item{NLCD.31}{Barren land}
#'   \item{NLCD.41}{Deciduous Forest; 1 of 3  forest landcover classes}
#'   \item{NLCD.42}{Evergreen Forest; 1 of 3 forest landcover classes}
#'   \item{NLCD.43}{Mixed Forest; 1 of 3forest landcover classes}
#'   \item{NLCD.52}{Shrub or scrub}
#'   \item{NLCD.71}{Grassland or Herbaceous}
#'   \item{NLCD.81}{Pasture or Hay}
#'   \item{NLCD.82}{Cultivated Crops}
#'   \item{NLCD.90}{Woody wetland}
#'   \item{NLCD.95}{Herbaceous wetland}
#'   \item{SUM}{total landcover accross all variables}
#'  }
#'
#' @source \url{https://figshare.com/articles/Data_Paper_Data_Paper/3554424}
#'
#'
#' @references Small et al. 2016.  Data Paper: Local landscape composition and configuration around North American Breeding Bird Survey routes.
#' See also: http://esapubs.org/archive/ecol/E093/215/
#'
#' Veech et al. 2012.  Representativeness f land cover composition along routes of the
#' North American Breeding Bird Survey.  Aug 129:259-267.

"BBS_PA_landcover_1km"

