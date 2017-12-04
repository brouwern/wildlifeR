#' Data on presence of pikas and marmots from Front Range Pika Project
#'
#' Original data had lat and long for most sites.  Elevations estimate
#' using the elevatr package
#' (https://cran.r-project.org/web/packages/elevatr/vignettes/introduction_to_elevatr.html)
#'
#'
#' @format A data frame
#' \describe{
#'   \item{lat}{latitude of survey site}
#'   \item{long}{longitude of survey site}
#'   \item{pika.pres}{Are pikas present or absent from the site}
#'   \item{marmot.pres}{Are marmots present or absent}
#'   \item{talus.area}{Description of area of talus at site}
#'   \item{elev.m}{Elevation of site}
#'   \item{group}{Designates whether no focal species seen, pikas only, marmots only, or both}
#' }
#'
#' @references Front Range Pika Project.  http://www.pikapartners.org/cwis438/websites/FRPP/Home.php?WebSiteID=18
#'
#' @examples
#'
#' ## Load packages
#'
#' library(ggplot2)
#' library(ggpubr)
#'
#' ## Explore data graphically
#'
#' ### Plot boxplots
#' ggboxplot(data = pikas,
#'           y = "elev.m",
#'           x = "group",
#'           fill = "group")
#'
#' ### Plot histograms
#' gghistogram(data = pikas,
#'           x = "elev.m",
#'           title = "All data")
#'
#'  gghistogram(data = pikas,
#'           x = "elev.m",
#'           facet.by = "group",
#'           fill = "group",
#'           title = "Faceted by group")
#'
#' ## Plot means with 95% confidence intervals
#' ggerrorplot(pikas,
#'   x = "group",
#'   y = "elev.m",
#'   desc_stat = "mean_ci",
#'   add = "mean")
#'
#' ## 1-way ANOVA
#'
#' ### null model
#' model.null <- lm(elev.m ~ 1, data = pikas)
#'
#' ### model of interest
#' model.alt <- lm(elev.m ~ group, data = pikas)
#'
#' ### compare models
#' anova(model.null, model.alt)
#'
#' ## Pairwise comparisons after 1-way ANOVA
#' ### no corrections for multiple comparisons
#' pairwise.t.test(x = pikas$elev.m, g = pikas$group,
#'       p.adjust.method = "none")
#'
#' ### Bonferonni correction
#' pairwise.t.test(x = pikas$elev.m, g = pikas$group,
#'       p.adjust.method = "bonferroni")
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(elev.m ~ group, data = pikas)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)

"pikas"

