## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, message = FALSE)

## ---- eval = TRUE--------------------------------------------------------
library(wildlifeR)
library(dplyr)
library(ggplot2)
library(ggpubr)

## ---- eval = TRUE--------------------------------------------------------
## AOU species codes
data(AOU_species_codes)

## BBS data for PA
data(BBS_PA)

## ------------------------------------------------------------------------
head(BBS_PA)


## ------------------------------------------------------------------------
dim(BBS_PA)

## ------------------------------------------------------------------------
dim(AOU_species_codes)

## ------------------------------------------------------------------------
head(AOU_species_codes)

## ------------------------------------------------------------------------
EUST.row.number <- which(AOU_species_codes$alpha.code == "EUST")

## ------------------------------------------------------------------------
EUST.row.number

## ------------------------------------------------------------------------
AOU_species_codes[EUST.row.number, ]

## ------------------------------------------------------------------------
AOU_species_codes[643, ]

## ------------------------------------------------------------------------
EUST.numeric.code <- 4940

## ------------------------------------------------------------------------
AOU_species_codes %>% filter(alpha.code == "EUST")

## ------------------------------------------------------------------------
grep("European starling", 
     AOU_species_codes$name,
     ignore.case = TRUE)

## ------------------------------------------------------------------------
grep("starling", 
     AOU_species_codes$name,
     ignore.case = TRUE)

## ------------------------------------------------------------------------
i.starling <- grep("starling", 
     AOU_species_codes$name,
     ignore.case = TRUE)

## ------------------------------------------------------------------------
AOU_species_codes[i.starling, ]

## ------------------------------------------------------------------------
#store the row numbers
i.European <- grep("European", 
     AOU_species_codes$name,
     ignore.case = TRUE)

#see what they match
AOU_species_codes[i.European, ]

## ------------------------------------------------------------------------
#store the row numbers
i.Euro <- grep("Euro", 
     AOU_species_codes$name,
     ignore.case = TRUE)

#see what they match
AOU_species_codes[i.Euro, ]

## ------------------------------------------------------------------------
#load dplyr
 #library(dplyr)

#filter just the Euro starling
BBS_PA_EUST <- BBS_PA %>% filter(Aou == 4940)


## ------------------------------------------------------------------------
#object with the code
EUST.numeric.code


## ------------------------------------------------------------------------
BBS_PA_EUST <- BBS_PA %>% filter(Aou == EUST.numeric.code)


## ------------------------------------------------------------------------
dim(BBS_PA)
dim(BBS_PA_EUST)


## ------------------------------------------------------------------------
summary(BBS_PA_EUST)


