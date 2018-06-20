#' Simulated data on the effects of diet on deer antlers
#'
#' Data simulated based on summary information in Asleson et al.
#' (1997).  Deer were fed three different diets that varied in the
#' timeing of high protein.  Data are suitable for analysis
#' with 1-way ANOVA.
#'
#' See the vignette "Intro to 1-way ANOVA: impacts of diet on deer antlers"
#' for a thorough exploration of these data.   The examples below demonstate
#' basic plotting and 1-way ANOVA.
#'
#' @format A data frame
#' \describe{
#'   \item{diet}{Experimental diet during both spring and summer.  Hi.Hi = High quality diet in both season.  Hi.Lo = high quality diet in spring but poor in summer.  }
#'   \item{mass}{Antler mass in grams}
#'   \item{circum}{basal circumference in mm}
#'   \item{beam}{Length of main beam of antler in mm}
#'   \item{spread}{spread between points in mm}
#'   \item{diet.name}{further details on diet treatment}
#' }
#'
#' @references Asleson et al. 1997.  Effects of seasonal protein restriction on antlerogenesis and body mass in adult male white-tailed deer.  Journal of Wildlife Management 61.
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
#' ggboxplot(data = antlers,
#'           y = "mass",
#'           x = "diet",
#'           fill = "diet")
#'
#' ### Plot histograms
#' gghistogram(data = antlers,
#'           x = "mass",
#'           title = "All data")
#'
#'  gghistogram(data = antlers,
#'           x = "mass",
#'           facet.by = "diet",
#'           fill = "diet",
#'           title = "Faceted by diet")
#'
#' ## Plot means with 95% confidence intervals
#' ggerrorplot(antlers,
#'   x = "diet",
#'   y = "mass",
#'   desc_stat = "mean_ci",
#'   add = "mean",
#'   ylim = c(400,900))
#'
#' ## 1-way ANOVA
#'
#' ### null model
#' model.null <- lm(mass ~ 1, data = antlers)
#'
#' ### model of interest
#' model.alt <- lm(mass ~ diet, data = antlers)
#'
#' ### compare models
#' anova(model.null, model.alt)
#'
#' ## Pairwise comparisons after 1-way ANOVA
#' ### no corrections for multiple comparisons
#' pairwise.t.test(x = antlers$mass, g = antlers$diet,
#'       p.adjust.method = "none")
#'
#' ### Bonferonni correction
#' pairwise.t.test(x = antlers$mass, g = antlers$diet,
#'       p.adjust.method = "bonferroni")
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(mass ~ diet, data = antlers)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)
#'
#' ### Plot effect sizes
#' plotTukeysHSD(TukeyHSD(model.alt.aov))

"antlers"

