#' Data on the size of Trillium from several sites in Crawford County, PA
#'
#' The size of Trillium has been hypothesized to be correlated with
#' the intensity of deer browse occuring on thee population.
#'
#' @format A data frame
#' \describe{
#'   \item{site}{site code for different forests and woodlots in NW Pennsylvania near the Pymatuning Laboratory of Ecology}
#'   \item{spp}{species. All are = T for Trillium}
#'   \item{length.stem.cm}{length from soil to leaf whorl}
#'   \item{length.leaf.cm}{length of longest leaf in cm}
#' }
#'
#' @references Author year.
#'
#' @examples
#'
#' library(ggplot2)
#' library(ggpubr)
#'
#' ## Explore data graphically
#'
#' ### Plot boxplots
#' ggboxplot(data = trillium,
#'           y = "length.stem.cm",
#'           x = "site",
#'           fill = "site")
#'
#' ### Plot histograms
#' gghistogram(data = trillium,
#'           x = "length.stem.cm",
#'           title = "All data")
#'
#'  gghistogram(data = trillium,
#'           x = "length.stem.cm",
#'           facet.by = "site",
#'           fill = "site",
#'           title = "Faceted by site")
#'
#' ## Plot means with 95% confidence intervals
#' ggerrorplot(trillium,
#'   x = "site",
#'   y = "length.stem.cm",
#'   desc_stat = "mean_ci",
#'   add = "mean")
#'
#' ## 1-way ANOVA to compare sites
#'
#' ### null model
#' model.null <- lm(length.stem.cm ~ 1, data = trillium)
#'
#' ### model of interest
#' model.alt <- lm(length.stem.cm ~ site, data = trillium)
#'
#' ### compare models
#' anova(model.null, model.alt)
#'
#' ## Pairwise comparisons after 1-way ANOVA
#' ### no corrections for multiple comparisons
#' pairwise.t.test(x = trillium$length.stem.cm, g = trillium$site,
#'       p.adjust.method = "none")
#'
#' ### Bonferonni correction
#' pairwise.t.test(x = trillium$length.stem.cm, g = trillium$site,
#'       p.adjust.method = "bonferroni")
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(length.stem.cm ~ site, data = trillium)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)
#'
#' ### Plot effect sizes
#' plotTukeysHSD(TukeyHSD(model.alt.aov))

"trillium"
