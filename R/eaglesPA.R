#' Eagles in Pennsylvania dataset
#'
#' A dataset containing the number of nesting pairs of eagles found in Pennsylvania, USA, from 1980 through 2015.  Data is not available for all years and is given as NA.
#'
#' @format A data frame with 2 columns:
#' \describe{
#'   \item{year}{Year of data collection, beginning in 1980}
#'   \item{eagles}{Number of breeding pairs of eagles (male plus female)}
#'
#' }
#' @references Pennsyulvania Game Commission.  ND.  Bald Eagle: Haliaeetus leucocephalus. http://www.pgc.pa.gov/Wildlife/EndangeredandThreatened/Pages/BaldEagle.aspx
#'
#'
#' @source \url{https://www.fws.gov/midwest/eagle/population/nos_state_tbl.html}
#' @source \url{http://www.media.pa.gov/pages/Game-Commission-Details.aspx?newsid=44}
#'
#' @examples
#'
#' ## Plot number of eagles over time
#' plot(eagles ~ year, data = eaglesPA)
#'

"eaglesPA"

