#' Combine multiple landcover classes into a single combined group
#'
#' @param dat dataframe of NLCD landcover values
#' @param numeric_cover_codes numeric codes for landcover classes
#'
#' @export

combine_NLCD_classes <- function(dat,
                               numeric_cover_codes){
  if(is.numeric(numeric_cover_codes) == FALSE){
    print("combine_landcovers() only accepts the
          numeric value of the cover class")

  }

  char_cover_codes <- paste("NLCD.",numeric_cover_codes,sep = "")

  j.cols <- which(names(dat) %in% char_cover_codes)
  cov_combined <- apply(dat[,j.cols],1,sum)
  return(cov_combined)
}
