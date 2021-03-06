#' Impact of brook trout on survival of Chinook salmon in Idaho.
#'
#' A dataset ...
#'
#' @format A data frame with 12 rows and 3 columns
#' \describe{
#'   \item{brook.trout.PRES.ABS}{Whether brook trout are present or absent}
#'   \item{salmon.released}{Number of PIT-tagged salmon released}
#'   \item{salmon.surv}{Number of tagged salmon that survived and were detected downstream}
#' }
#'
#' @source \url{http://rspb.royalsocietypublishing.org/content/269/1501/1663.short}
#' @references Levin et al.  2002.  Non–indigenous brook trout and the demise of Pacific salmon:
#' a forgotten threat?  PRSB 269.  DOI: 10.1098/rspb.2002.2063
#'
#' Whitlock & Schulter.  2nd ed.  Analysis of Biological Data.
#'
#' @examples
#'
#' ## t-test on survival rate (ignores years)
#'
#' ### Calcualte survival
#' brook_trout_ABD$surv <- brook_trout_ABD$salmon.surv/brook_trout_ABD$salmon.released
#'
#' ### t-test
#' t.test(surv ~ brook.trout.PRES.ABS, data = brook_trout_ABD)

"brook_trout_ABD"



