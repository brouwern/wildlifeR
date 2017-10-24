## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, message = FALSE)

## ---- eval = TRUE--------------------------------------------------------
library(dplyr)
library(wildlifeR)

## ---- eval = TRUE--------------------------------------------------------
## BBS data for PA
data(BBS_PA)

##Landcover data for BBS routes in PA
data(BBS_PA_landcover_1km)

## ---- eval = TRUE--------------------------------------------------------
dim(BBS_PA)
names(BBS_PA)

## ---- eval = TRUE--------------------------------------------------------
#load dplyr if you haven't already
library(dplyr)

#look at the names of the full dataframe
names(BBS_PA)


#use select() to isolate focal columns
## and put into a new dataframe
BBS_PA2 <- BBS_PA %>% select(Year, Aou, Route, StopTotal)


#look at columns in new dataframe
names(BBS_PA2)

## ----echo=FALSE----------------------------------------------------------

i.6080 <- which(BBS_PA2$Aou == 6080)[35:37]

temp <- BBS_PA2[c(i.6080-1,i.6080[1],i.6080-2,i.6080[2],i.6080+1,i.6080[3],i.6080+2),]

temp$" " <- ifelse(temp$Aou == 6080, "we want this row","")

print(temp)

## ---- eval = TRUE--------------------------------------------------------
library(dplyr)

BBS_PA_SCTA <- BBS_PA2 %>% filter(Aou == 6080)


## ---- eval = TRUE--------------------------------------------------------
BBSdata_3 <- full_join(BBS_PA_SCTA,
                       BBS_PA_landcover_1km, 
                       by = "Route")

## ------------------------------------------------------------------------
head(BBSdata_3)

## ------------------------------------------------------------------------
dim(BBSdata_3)

dim(BBS_PA_landcover_1km)

