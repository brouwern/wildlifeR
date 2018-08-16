## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, message = FALSE)

## ------------------------------------------------------------------------
#make a vector of species names.
species <- c("OVEN","WEWA","NOWA",
             "BWWA","HOWA","AMRE",
             "CMWA","NOPA","PRWA")

#Number of birds of each species captured in 1991 
N.1991 <- c(29, 6, 4, 60, 8, 19, 9, 7, 4)
N.2005 <- c(24, 5, 0, 16, 3, 9, 2, 5, 8)

#make dataframe
dat <- data.frame(species,
                  N.1991,
                  N.2005)


## ------------------------------------------------------------------------
head(dat)

## ------------------------------------------------------------------------

t.test(dat$N.1991,    #column 1, then a comma
       dat$N.2005,    #column 2; 
       paired = TRUE)


## ------------------------------------------------------------------------
#make new column with the differencce between 1991 an 2005
dat$difference <- dat$N.1991 - dat$N.2005

#t.test() on difference
t.test(dat$difference, 
       mu = 0)


