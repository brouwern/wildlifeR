#' Subset of Woodcock call survey data from Michigan, USA
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
#'   \item{year}{Year of survey: 2000, 2005 or 2010}
#'   \item{state}{State.  Only MI is used.}
#'   \item{route}{Route number within Michigan}
#'   \item{county}{County within Michigan}
#'   \item{route.status}{Status of route as "route run" (RR) or "constant zero" (CZ).  "statuscd" in original USGS data}
#'   \item{woodcocks}{Number of woodcocks seen on route; "accpwdck" for "acceptable woodcocks" in original USGS data}
#'   \item{stops}{Number of acceptable stops during survey that meet quality control critera. "accpstops" in original USGS data.  Only routes with all stops being acceptable used for this dataset}
#' }
#'
#' @source \url{https://migbirdapps.fws.gov/mbdc/databases/db_selection.html}
#'
#' @references Sauer, J. R., and J. B. Bortner. 1991. Population trends from the American Woodcock Singing-ground Survey, 1970-88. J. Wildl. Mange. 55:300-312.
#'
#' @examples
#'
#' # Note: see help files for other datasets, egg ?pikas for examples of exploring
#' ##      data with boxplots and histograms.
#'
#' ## Make year a factor
#' woodcock_MI_3_years$year <- factor(woodcock_MI_3_years$year)
#'
#' ## Plot means with 95% confidence intervals
#'
#' library(ggplot2)
#' library(ggpubr)
#'
#' ggerrorplot(woodcock_MI_3_years,
#'   x = "year",
#'   y = "woodcocks",
#'   desc_stat = "mean_ci",
#'   add = "mean")
#'
#' ## 1-way ANOVA
#'
#' ## null model
#' model.null <- lm(woodcocks ~ 1, data = woodcock_MI_3_years)
#'
#' ## model of interest
#' model.alt <- lm(woodcocks ~ year, data = woodcock_MI_3_years)
#'
#' ## compare models
#' anova(model.null, model.alt)
#'
#' ## Pairwise comparisons
#' ### no corrections for multiple comparisons
#' pairwise.t.test(x = woodcock_MI_3_years$woodcocks,
#'                 g = woodcock_MI_3_years$year,
#'       p.adjust.method = "none")
#'
#' ### Bonferonni correction
#' pairwise.t.test(x = woodcock_MI_3_years$woodcocks,
#'                 g = woodcock_MI_3_years$year,
#'       p.adjust.method = "bonferroni")
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(woodcocks ~ year, data = woodcock_MI_3_years)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)
#'
#' ### Plot effect sizes
#' plotTukeysHSD(TukeyHSD(model.alt.aov))

"woodcock_MI_3_years"
