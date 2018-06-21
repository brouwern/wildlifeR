#' Human body temperature data and heartrate
#'
#' Physiology data originally from Mackowiak et al (1992).  Developed as a demonstration for
#' t-tests by Shoemaker (1996) and also used by Motulsky (2014).
#'
#' @format A data frame with 2 columns:
#' \describe{
#'   \item{temp}{body temperature in degrees F}
#'   \item{sex}{sex of individual}
#'   \item{heartrate}{heartrate in beats per minute}
#' }
#' @references Mackowiak et al.  1992.  A Critical Appraisal of 98.6°F, the Upper Limit of the Normal Body Temperature, and Other Legacies of Carl Reinhold August Wunderlich.  JAMA.  268:1578-1580.  https://jamanetwork.com/journals/jama/article-abstract/400116
#' @references Motulsky, H.  2014.  Intuitive biostatistics: a nonmathematical guide to statistical thinking.
#' @references Shoemaker, A.  1996.  What's Normal? -- Temperature, Gender, and Heart Rate.  Journal of Statistics Education v.4, n.2.  ww2.amstat.org/publications/jse/v4n2/datasets.shoemaker.html
#'
#'
#' @source \url{https://www.fws.gov/midwest/eagle/population/nos_state_tbl.html}
#' @source \url{http://www.media.pa.gov/pages/Game-Commission-Details.aspx?newsid=44}
#'
#'
#' @examples
#'
#' ## Histogram of body temperature
#' hist(human_bodytemp$temp)


"human_bodytemp"
