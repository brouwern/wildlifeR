#' Expand BBS data to include zeros when a species was not seen.
#'
#' BBS data is distributed by the USGS in a format that only includes data
#' on species of birds that were actually seen.  If a species was not seen on a route in given
#' year, it is simply not listed.  That is, instead of zeros to indicate
#' "that species of bird was not seen" there is nothing.
#' Also, if a route was not survyed in given year, instead of NA there
#' is simply no rows of data for that route for that year
#' This function adds back those empty rows so that zeros occur appropriately
#' in the data.  HOWEVER, the issue of routes not being done in certain
#' years has NOT been addressed yet.
#'
#'
#' @param BBSdata a dataframe of BBS bird counts
#'
#' @export



expand_BBS_routes <- function(BBSdata = BBS_PA){
  #min and max years that occur in the dataset are used
  #to create a vector with each year
  #first year is 1966
  year.vect <- c(min(BBSdata$Year):max(BBSdata$Year))

  #All combinations of year, route, and species are created
  #Note that this currently will create data for a route
  #even if it wasn't surveyed!
  all.routes <- expand.grid(Year = year.vect,
                            Route = unique(BBSdata$Route),
                            Aou = unique(BBSdata$Aou))

  cat("Your original dataframe contained",nrow(BBSdata),"rows of data")
  cat("Your expanded dataframe will contain",nrow(all.routes),"rows of data")
  cat("\n")
  #merge the datasets
  requireNamespace(dplyr)
  cat("Merging data - this may take a second...")
  cat("\n")
  #merge
  BBS.expand <- full_join(BBSdata, all.routes)

  warning("The current implementation of expand_BBS_routes() does not account for the fact that some routes were not surveyed every year!")

  return(BBS.expand)

}


