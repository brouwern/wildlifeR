#' Egg data combined with data on nests
#'
#'
#' @format A data frame
#' \describe{
#'   \item{family}{...}
#'   \item{order}{....}
#'   \item{spp}{...}
#'   \item{asymmetry}{...}
#'   \item{ellipticity}{...
#'   \item{ave.length.com}{...}
#'   \item{nest}{nest type}
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

