% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sample_BBS_routes.R
\name{sample_BBS_routes}
\alias{sample_BBS_routes}
\title{Select random subset of Breeding Bird Survey (BBS) routes}
\usage{
sample_BBS_routes(dat = BBS_PA, years = c(1990, 2000, 2005),
  aou.code = 7610, max.sample = 50)
}
\arguments{
\item{dat}{Dataframe containing BBS data.  Must contain columns for Year, Aou species code and Route}

\item{years}{Years for for which you want to generate data for}

\item{aou.code}{American Ornithological Union (AOU) numeric species code}

\item{max.sample}{Maximum number routes per year.}
}
\description{
This function randomly samples routes from within a stage.
}
\examples{

## Setting up dataframe to examine change over time
## Focal species: European starling (Aou code = 4940)
### Start with the raw BBS_PA dataframe
### The function sample_BBS_routes()
### randomly samples routes for years your specify.
### It selects routes from the entire state.
### Note: sample_BBS_routes() requires the Hmisc package to work

## Subset European starling data
### See help file for AOU_species_codes for further details
### on subsetting data based on a species numeric code
\dontrun{
BBS_PA_EUST <- BBS_PA \%>\% filter(Aou == 4940)

## select the years 1990, 2000, and 2010
BBS_PA_EUST_2 <-  sample_BBS_routes(dat = BBS_PA_EUST,
                                    years = c(1990,2000,2010),
                                    aou.code = 4940)

## Look at data subset that has been created
head(BBS_PA_EUST_2)
summary(BBS_PA_EUST_2)

##Plot the results with a boxplot
ggboxplot(data = BBS_PA_EUST_2,
     y = "SpeciesTotal",
   x = "Year")

## Save output
### data can be saved with write.csv(), eg:
write.csv(BBS_PA_EUST_2, file = "starling_change_over_time.csv")
}

}
