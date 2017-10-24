#' Number of Scarlet tanagers (SCTA) observed on Pennsylvania BBS routes in 2006 and total forested landcover in 1km buffers around routes
#'
#' PA BBS data for SCTA for 2006
#'
#' Landcover is within a 1km buffer of Pennsylvania BBS routes.  Original cover
#' classes combined into overarching groups.  Original data
#' from the National Land Cover Database (NLCD)
#' https://catalog.data.gov/dataset/national-land-cover-database-nlcd-land-cover-collection
#' The data were taken from the 2006 NLCD dataset.
#'
#' @format A data frame...
#' \describe{
#'   \item{year}{year; all = 2006, the year landcover data obtained}
#'   \item{aou}{American Ornithological Union (AOU) 4 digit code; all 6080 for scarlet tanager}
#'   \item{route}{BBS route number within Pennsylvania}
#'   \item{name}{species name; all SCTA for scarlet tanager}
#'   \item{spp.tot}{total number of Scarlet tanagers seen on each route in 2006}
#'   \item{for.tot}{Total amount of forested landcover (NLCD.41,42,43) pixels around each route}
#'   \item{NLCD.sum}{Total number of landcover pixels}
#'   \item{for.percent}{percentage of landcover that is forested}
#'  }
#'
#' @source \url{https://figshare.com/articles/Data_Paper_Data_Paper/3554424}
#'
#' @references Small et al. 2016.  Data Paper: Local landscape composition and configuration around North American Breeding Bird Survey routes.
#' See also: http://esapubs.org/archive/ecol/E093/215/

"BBS_PA_SCTA"
