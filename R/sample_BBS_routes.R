#' Select random subset of Breeding Bird Survey (BBS) routes
#'
#' This function randomly samples routes from within a stage.
#'
#' @param dat Dataframe containing BBS data.  Must contain columns for Year, Aou species code and Route
#' @param years Years for for which you want to generate data for
#' @param aou.code American Ornithological Union (AOU) numeric species code
#' @param max.sample Maximum number routes per year.
#'
#' @examples
#'
#' ## Setting up dataframe to examine change over time
#' ## Focal species: European starling (Aou code = 4940)
#' ### Start with the raw BBS_PA dataframe
#' ### The function sample_BBS_routes()
#' ### randomly samples routes for years your specify.
#' ### It selects routes from the entire state.
#' ### Note: sample_BBS_routes() requires the Hmisc package to work
#'
#' ## Subset European starling data
#' ### See help file for AOU_species_codes for further details
#' ### on subsetting data based on a species numeric code
#' \dontrun{
#' BBS_PA_EUST <- BBS_PA %>% filter(Aou == 4940)
#'
#' ## select the years 1990, 2000, and 2010
#' library(Hmisc)
#' BBS_PA_EUST_2 <-  sample_BBS_routes(dat = BBS_PA_EUST,
#'                                     years = c(1990,2000,2010),
#'                                     aou.code = 4940)
#'
#' ## Look at data subset that has been created
#' head(BBS_PA_EUST_2)
#' summary(BBS_PA_EUST_2)
#'
#' ##Plot the results with a boxplot
#' ggboxplot(data = BBS_PA_EUST_2,
#'      y = "SpeciesTotal",
#'    x = "Year")
#'
#' ## Save output
#' ### data can be saved with write.csv(), eg:
#' write.csv(BBS_PA_EUST_2, file = "starling_change_over_time.csv")
#' }
#'
#' @export

sample_BBS_routes <- function(dat = BBS_PA,
         years = c(1990,2000,2005),
         aou.code = 7610,
         max.sample = 50){

  #IDs of unique routes in dataset
  unique.routes <- unique(dat$Route)

  #Number of unique routes
  n.unique.routes <- length(unique.routes)

  #number of years
  n.years <- length(years)


  #number of routes per year, rounding down
  n.routes.per.year <- trunc(n.unique.routes/n.years)

  #set total number of routes
  ##can be less that all possible if allowed by user
  n.routes.per.year <- ifelse(n.routes.per.year > max.sample,
                              max.sample,
                              n.routes.per.year)


  #cat(n.unique.routes," unique routes in dataset. \n ")

  #cat(n.routes.per.year," routes per year will be randomly sampled, without replacement \n")

  #total number of routes actually sampled
  n.routes.tot <- n.routes.per.year*n.years


  #sample routes#
  ##sample w/o replacement n.routes.total from vector of
  ##all unique routes
  ##This creates a new vector of route numbers
  ##that i)is a sample of all possible routes, and
  ##    ii)is in a random order (not sequential)
  sampled.routes <- sample(x = unique.routes,
                           size = n.routes.tot,
                           replace = F)

  #assign a numeric index to each sampled and re-ordered route order
  route.index <- 1:n.routes.tot

  #create dataframe of sampled routes
  route.df <- data.frame(Aou = aou.code,
                         route.index,
                         Route = sampled.routes)

  #load Hmisc
  requireNamespace("Hmisc")

  #use cut2() to divide route index number into even number of groups
  route.df$cuts <- cut2(route.df$route.index,
                        m = n.routes.per.year)

  #set as factor
  route.df$Year <- factor(route.df$cuts,
                          labels = years)

  cat(summary(route.df$Year))
  route.df$Year <- as.numeric(as.character(route.df$Year))

  any(duplicated(route.df) == TRUE)

  # merge sampled routes with original BBS data to generate new dataframe
  df.out2 <- merge(route.df, dat, all = TRUE)

  df.out2$SpeciesTotal[is.na(df.out2$SpeciesTotal)] <- 0

  df.out3 <- df.out2[which(df.out2$Year %in% years),]

  df.out4 <- df.out3[-which(is.na(df.out3$cuts) == TRUE),]

  # cat("Original BBS dataframe was", dim(dat), "\n")
  # cat("New resampled dataframe is", dim(df.out2),"\n")
  #

  return(df.out4)

}

