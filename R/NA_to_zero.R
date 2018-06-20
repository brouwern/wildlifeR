#' Change all NA values (missing vlaues) in a column to zero
#'
#' @param dat dataframe of USGS BBS data containing NAs that should be replaced with zeros
#' @param column column within dataframe containing NAs that should be converted to a dataframe
#' @param return "df" or "column"; whether to return the whole dataframe (deafault) or just the column
#'
#' @export


NA_to_zero <- function(dat, column, return = "df"){

  dat[is.na(dat[,column]), column] <- 0

  if(return == "df"){
    return(dat)
  }

  if(return == "column"){
    return(dat$column)
  }
}
