#' Subst of Woodcock call survey data from Michigan, USA
#'
#' There are ~150 routes in Michigan from three years:
#' 2000, 2005 and 2010.  50 were randomly chosen from
#' 2000, a different 50 for 2005, and the remainder for
#' use for 2010.  Only routes where all 10 stops were acceptable
#' were used.
#'
#'
#' The official USGS blurb is:
#' "The American Woodcock (Scolopax minor) Singing-Ground Survey, conducted by the U.S. Fish and Wildlife Service, exploits the conspicuous courtship display of the male woodcock. The survey consists of numerous routes in the eastern half of the U.S. and Canada, which are surveyed in the spring. Counts of singing male woodcock along the routes provide an index to woodcock abundance, and are used to estimate woodcock population trends for states, provinces, management regions, and the continent. The survey is the major source of information considered in the annual setting of woodcock hunting seasons. These data can also be used to examine the effects of weather, landscape change, and other factors on woodcock population abundance."
#'
#' USGS population reports are available as of fall 2017 at http://www.ruffedgrousesociety.org/Woodcock-Facts#popu
#'
#' @format A data frame with 23 columns, including:
#' \describe{
#'   \item{year}{Year of survey; early years that don't meet current USGS standard have been removed}
#'   \item{state}{State}
#'   \item{route}{Route number within Michigan}
#'   \item{county}{County within Michigan}
#'   \item{route.status}{Status of route as "route run" (RR) or "constant zero" (CZ).  "statuscd" in original USGS data}
#'   \item{woodcocks}{Number of woodcocks seen on route; "accpwdck" for "acceptable woodcocks" in original USGS data}
#'   \item{stops}{Number of acceptable stops during survey that meet quality control critera. "accpstops" in original USGS data.  Only routes with all stops being acceptable used for this dataset}
#'   \item
#' }
#' @references Sauer, J. R., and J. B. Bortner. 1991. Population trends from the American Woodcock Singing-ground Survey, 1970-88. J. Wildl. Mange. 55:300-312.
#'
#' @source \url{https://migbirdapps.fws.gov/mbdc/databases/db_selection.html}

"woodcock_MI_3_years"
