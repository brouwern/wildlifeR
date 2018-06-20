#' Eagles in Ohio dataset
#'
#' A dataset containing the number of nesting pairs of eagles found in Ohio, USA, from 1980 through 2007  Data is not available for all years and is given as NA.
#'
#' @format A data frame with 2 columns:
#' \describe{
#'   \item{year}{Year of data collection, beginning in 1980}
#'   \item{eagles}{Number of breeding pairs of eagles (male plus female)}
#'
#' }
#'
#' @source \url{https://www.fws.gov/midwest/eagle/population/nos_state_tbl.html}
#'
#' @examples
#'
#' ## Plot number of eagles over time
#' plot(eagles ~ year, data = eaglesPA)
#'

"eaglesOH"

