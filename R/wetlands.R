#' Data on species richness in constructed wetlands at Pennsylvania Game Lands 297 in south western PA.
#'
#' Data are the number of species observed in a 0.25 m^2 plot.
#' The original data include the number of stems and percentage
#' cover of each species within the sampling plot.
#' Data collected by Gerry Koza (koz7133@calu.edu) in the summer 2017.
#'
#' @format A data frame with 78 rows and 5 variables:
#' \describe{
#'   \item{site}{Gameland}
#'   \item{wetland}{Wetland number.  Can be 1 2 or3}
#'   \item{Plot}{Transect an plot designations}
#'   \item{water.depth}{depth of water within sapling plot}
#'   \item{spp.richness}{The number of species observed within the sampling plot}
#' }
#'
#' @examples
#' ## Load packages
#'
#' library(ggplot2)
#' library(ggpubr)
#'
#' ## Set wetland as a factor
#' wetlands$wetland <- factor(wetlands$wetland)
#'
#' ## Explore data graphically
#'
#' ### Plot boxplots
#' ggboxplot(data = wetlands,
#'           y = "spp.richness",
#'           x = "wetland",
#'           fill = "wetland")
#'
#' ### Plot histograms
#' gghistogram(data = wetlands,
#'           x = "spp.richness",
#'           title = "All data")
#'
#'g ghistogram(data = wetlands,
#'           x = "spp.richness",
#'           facet.by = "wetland",
#'           fill = "wetland",
#'           title = "Faceted by wetland")
#'
#' ## Plot means with 95% confidence intervals
#' ggerrorplot(wetlands,
#'   x = "wetland",
#'   y = "spp.richness",
#'   desc_stat = "mean_ci",
#'   add = "mean")
#'
#' ## 1-way ANOVA
#'
#' ### null model
#' model.null <- lm(spp.richness ~ 1, data = wetlands)
#'
#' ### model of interest
#' model.alt <- lm(spp.richness ~ wetland, data = wetlands)
#'
#' ### compare models
#' anova(model.null, model.alt)
#'
#' ## Pairwise comparisons after 1-way ANOVA
#' ### no corrections for multiple comparisons
#' pairwise.t.test(x = wetlands$spp.richness, g = wetlands$wetland,
#'       p.adjust.method = "none")
#'
#' ### Bonferonni correction
#' pairwise.t.test(x = wetlands$spp.richness, g = wetlands$wetland,
#'       p.adjust.method = "bonferroni")
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(spp.richness ~ wetland, data = wetlands)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)
#'
#' ### Plot effect sizes
#' plotTukeysHSD(TukeyHSD(model.alt.aov))

"wetlands"


