#' Egg data combined with data on nests
#'
#'
#' @format A data frame
#' \describe{
#'   \item{family}{Taxonomic family}
#'   \item{order}{Taxonomic order}
#'   \item{spp}{Genus and species}
#'   \item{asymmetry}{Index of how asymmetric an egg is}
#'   \item{ellipticity}{Index of how elliptical an egg is}
#'   \item{ave.length.com}{Mean length of egg}
#'   \item{nest}{nest type of species}
#'   \item{source}{author}
#'   \item{bird.ellipticity}{ellipticity of bird in grams}
#' }
#'
#' @references ....
#'
#' @examples
#' library(ggplot2)
#' library(ggpubr)
#'
#' ## Explore data graphically
#'
#' ### Plot boxplots
#' ggboxplot(data = eggs_and_nests,
#'           y = "ellipticity",
#'           x = "nest",
#'           fill = "nest")
#'
#' ### Plot histograms
#' gghistogram(data = eggs_and_nests,
#'           x = "ellipticity",
#'           title = "All data")
#'
#' gghistogram(data = eggs_and_nests,
#'           x = "ellipticity",
#'           facet.by = "nest",
#'           fill = "nest",
#'           title = "Faceted by nest")
#'
#'
#'
#' ## Plot means with 95% confidence intervals
#' ggerrorplot(eggs_and_nests,
#'   x = "nest",
#'   y = "ellipticity",
#'   desc_stat = "mean_ci",
#'   add = "mean")
#'
#' ## 1-way ANOVA
#'
#' ### null model
#' model.null <- lm(ellipticity ~ 1, data = eggs_and_nests)
#'
#' ### model of interest
#' model.alt <- lm(ellipticity ~ nest, data = eggs_and_nests)
#'
#' ### compare models
#' anova(model.null, model.alt)
#'
#' ## Pairwise comparisons after 1-way ANOVA
#' ### no corrections for multiple comparisons
#' pairwise.t.test(x = eggs_and_nests$ellipticity, g = eggs_and_nests$nest,
#'       p.adjust.method = "none")
#'
#' ### Bonferonni correction
#' pairwise.t.test(x = eggs_and_nests$ellipticity, g = eggs_and_nests$nest,
#'       p.adjust.method = "bonferroni")
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(ellipticity ~ nest, data = eggs_and_nests)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)
#'
#' ### Plot effect sizes
#' plotTukeysHSD(TukeyHSD(model.alt.aov))

"eggs_and_nests"

