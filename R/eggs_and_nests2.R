#' Subset of eggs_and_nests data the contains only Dome, Cup, and ground surface nests
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
#' ggerrorplot(eggs_and_nests2,
#' x = "nest",
#' y = "ellipticity",
#' desc_stat = "mean_ci")
#'
#' ## 1-way ANOVA
#'
#' ### null model
#' model.null <- lm(ellipticity ~ 1, data = eggs_and_nests2)
#'
#' ### model of interest
#' model.alt <- lm(ellipticity ~ nest, data = eggs_and_nests2)
#'
#' ### compare models
#' anova(model.null, model.alt)
#'
#'
#' ## Tukey test
#'
#' ### re-fit model with aov()
#' model.alt.aov <- aov(ellipticity ~ nest, data = eggs_and_nests2)
#'
#' ### TukeyHSD() on model from aov()
#' TukeyHSD(model.alt.aov)
#'
#' ### Plot effect sizes
#' plotTukeysHSD(TukeyHSD(model.alt.aov))

"eggs_and_nests2"

