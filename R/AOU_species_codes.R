#' American Ornithological Union (AOU) species codes for North-American birds
#'
#' A dataframe containing the common names (eg "Scarlet Tanager"),
#' AOU alphabetic code (eg "SCTA") and AOU numeric code (eg. 6080)
#' The common name and alphabetic codes are eay to locate for a given species online.
#' The AOU numeric code is needed because the actual BBS dataframe does not
#' contain species names, just the numeric codes.
#'
#' Some records from offical list have been removed because they don't have stable names, eg., they are a defined species.
#' Note that the row number (aka line number) DOES NOT equal the AOU code.  When
#' access these data be sure to be clear whether you are using the line number
#' or using the actual code.  See below for examples.
#'
#' @format A data frame...
#' \describe{
#'   \item{spp.num}{AOU species codes}
#'   \item{alpha.code}{Bird Conservation Region}
#'   \item{name}{Common name of species.}
#'   \item{spp}{Latin binomial genus and species}
#'   \item{order}{code for taxonomic order}
#'  }
#'
#' @examples
#'
#' ## Example 1: Accessing basic information
#'
#' ## Determine row number by species common name
#' ### The Scarlet Tanager is in row 897 and has the AOU specied
#' ### number (aka spp code) of 6080
#' row.number.i <- which(AOU_species_codes$name == "Scarlet Tanager")
#'
#' ## Determine row number by Aou alphabetic code
#' row.number.i <- which(AOU_species_codes$alpha.code == "SCTA")
#'
#' ## Access code by row / line number
#' ### These are equivalent:
#' AOU_species_codes[row.number.i,]
#' AOU_species_codes[812,]
#' #Load data on AOU species codes
#'
#' ## Example 2: Seting up data for analysis of
#' ### the relationship between abundance and landcover
#' ### Focal species: European starling "EUST"
#'
#' ### Which ROW NUMBER in the list of species codes
#' #### does the European startling occur in?
#' EUST.row.number <- which(AOU_species_codes$alpha.code == "EUST")
#'
#' ### Look at just the EUST row of the
#' #### AOU_species_codes dataframe
#' AOU_species_codes[EUST.row.number,]
#'
#' #### The numeric code for EUST is 494)
#' #### save it to an object
#' EUST.numeric.code <- 4940
#'
#' ### look at names of the columns in the BBS_PA data set with
#' ### the data on bird abundance
#' names(BBS_PA)
#'
#' #### The column with the Aou species codes is called "Aou"
#'
#' #### load dplyr package
#' library(dplyr)
#'
#' #### Subset just the rows of data for the European startling
#' #### That is, the rows where the Aou code = 4940
#' BBS_PA_EUST <- BBS_PA %>% filter(Aou == 4940)
#'
#' #### See how the dataframe has change
#' dim(BBS_PA)
#' dim(BBS_PA_EUST)
#' summary(BBS_PA_EUST)
#'
#'
#' ## Save output
#' ### data can be saved with write.csv(), eg:
#' ### write.csv(BBS_PA_EUST, file = "starling_abundance.csv")
#'
#' #### If you are studying how the abundance of a species changes
#' #### as landcover changes you can now merge this subset of the data
#' #### with the GIS landcover data.




"AOU_species_codes"
