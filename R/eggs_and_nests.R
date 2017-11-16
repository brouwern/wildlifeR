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
#'   \item{bird.mass}{mass of bird in grams}
#' }
#'
#' @references ....
#'
#' @examples
#' library(ggplot2)
#' library(ggpubr)
#'
#' ggboxplot(data = eggs_and_nests,
#' y = "ellipticity",
#' x = "nest")

"eggs_and_nests"

