#' Select random subset of Breeding Bird Survey (BBS) routes
#'
#' This function randomly samples routes from within a stage.
#'
#' @param dat Dataframe containing BBS data.  Must contain columns for Year, Aou species code and Route
#' @param years Years for for which you want to generate data for
#' @param max.sample Maximum number routes per year.
#'
#' @examples
#'
#' ## create data
#' #dat <- sample_dove_routes(dat = doves_PA,
#'  #       years = c(2005,2007,2010))
#'
#' ## Make year a factor
#' #dat$Year <- factor(dat$Year)
#'
#' ## Plot means with 95% confidence intervals
#'
#' library(ggplot2)
#' library(ggpubr)
#'
#' #ggerrorplot(dat,
#'  # x = "Year",
#'   #y = "tot.seen",
#'   #desc_stat = "mean_ci",
#'   #add = "mean")
#'
#' @export

sample_dove_routes <- function(dat = doves_PA,
                              years = c(1990,2000,2005),
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
  route.df <- data.frame(route.index,
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

  # merge sampled routes with original  data to generate new dataframe
  df.out2 <- merge(route.df, dat, all = TRUE)

  df.out2$tot.seen[is.na(df.out2$tot.seen)] <- 0
  #df.out2$tot.heard[is.na(df.out2$tot.heard)] <- 0
  #df.out2$tot.seen.stop[is.na(df.out2$tot.seen.stop)] <- 0
  #df.out2$tot.seen.drive[is.na(df.out2$tot.seen.drive)] <- 0

  df.out3 <- df.out2[which(df.out2$Year %in% years),]

  df.out4 <- df.out3[-which(is.na(df.out3$cuts) == TRUE),]

  # cat("Original BBS dataframe was", dim(dat), "\n")
  # cat("New resampled dataframe is", dim(df.out2),"\n")
  #

  return(df.out4)

}

