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

## ------------------------------------------------------------------------
head(BBS_PA)

## ---- eval= TRUE---------------------------------------------------------

dim(BBS_PA)
summary(BBS_PA)


## ------------------------------------------------------------------------
50*202*137

## ------------------------------------------------------------------------
summary(BBS_PA$StopTotal)

## ---- eval = TRUE--------------------------------------------------------
#load dplyr if you haven't already
#library(dplyr)

#look at the names of the full dataframe
names(BBS_PA)


#use select() to isolate focal columns
## and put into a new dataframe
##(Note that ths A in Aou is uppercase 
## while the rest of the letters are lowercase)

#BBS_PA2 <-  select(.data = BBS_PA,
#                   Year, Aou, Route, SpeciesTotal)

#dplyr was not working for me so I did this another way of doing
#this

BBS_PA2 <- BBS_PA[,c("Year", "Aou", "Route", "SpeciesTotal")]

#look at columns in new dataframe
names(BBS_PA2)


## ---- echo=FALSE---------------------------------------------------------

i.6080 <- which(BBS_PA2$Aou == 6080)[35:37]

temp <- BBS_PA2[c(i.6080-1,i.6080[1],i.6080-2,i.6080[2],i.6080+1,i.6080[3],i.6080+2),]

temp$" " <- ifelse(temp$Aou == 6080, "we want this row","")

print(temp)

## ---- echo = FALSE-------------------------------------------------------
temp %>% filter(Aou == 6080)

## ---- eval = TRUE--------------------------------------------------------
library(dplyr)

BBS_PA_SCTA <- BBS_PA2 %>% filter(Aou == 6080)


## ------------------------------------------------------------------------

library(ggplot2)
library(ggpubr)

ggscatter(data = BBS_PA_SCTA,
          y = "SpeciesTotal",
          x = "Year")

## ------------------------------------------------------------------------
summary(BBS_PA_SCTA)

## ---- warning=FALSE------------------------------------------------------
gghistogram(BBS_PA_SCTA,
            x = "SpeciesTotal")

## ----eval=FALSE----------------------------------------------------------
#  BBS_PA_SCTA_2 <- BBS_PA_SCTA %>% filter(Year == 2006)

## ----nclude=FALSE--------------------------------------------------------
BBS_PA_SCTA_2 <- BBS_PA_SCTA %>% dplyr::filter(Year == 2006)

## ------------------------------------------------------------------------
dim(BBS_PA)
dim(BBS_PA_SCTA)
dim(BBS_PA_SCTA_2)

## ---- warnings =FALSE----------------------------------------------------
gghistogram(data = BBS_PA_SCTA_2,
          x = "SpeciesTotal")

## ------------------------------------------------------------------------
names(BBS_PA_landcover_1km)

## ----eval=FALSE----------------------------------------------------------
#  BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km %>%
#    select(Route, NLCD.41, NLCD.42, NLCD.43, SUM)

## ----include=FALSE-------------------------------------------------------
BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km %>%
  dplyr::select(Route, NLCD.41, NLCD.42, NLCD.43, SUM)

## ------------------------------------------------------------------------
forest.total <- rowSums(BBS_PA_landcover_1km_2[c("NLCD.41",
                                 "NLCD.42",
                                  "NLCD.43")])

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2$forest.total <- forest.total

## ------------------------------------------------------------------------
head(BBS_PA_landcover_1km_2)

## ------------------------------------------------------------------------
forest.percent <- BBS_PA_landcover_1km_2$forest.total / BBS_PA_landcover_1km_2$SUM

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2$forest.percent <- forest.percent

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2$forest.percent <- BBS_PA_landcover_1km_2$forest.total / BBS_PA_landcover_1km_2$SUM

## ----eval=FALSE----------------------------------------------------------
#  BBS_PA_landcover_1km_3 <- BBS_PA_landcover_1km_2 %>%
#    select(Route, forest.total, SUM, forest.percent,
#           NLCD.41,NLCD.42,NLCD.43)

## ----include=FALSE-------------------------------------------------------
BBS_PA_landcover_1km_3 <- BBS_PA_landcover_1km_2 %>% 
  dplyr::select(Route, forest.total, SUM, forest.percent,
         NLCD.41,NLCD.42,NLCD.43)

## ---- eval = TRUE--------------------------------------------------------
BBS_PA_SCTA_3 <- full_join(BBS_PA_SCTA_2 ,
                       BBS_PA_landcover_1km_3, 
                       by = "Route")

## ------------------------------------------------------------------------
head(BBS_PA_SCTA_3)

## ------------------------------------------------------------------------
#the BBS data that were merged
dim(BBS_PA_SCTA_2)

#the landcover data that were merged
dim(BBS_PA_landcover_1km_3)

#the final merged dataframe
dim(BBS_PA_SCTA_3)

## ------------------------------------------------------------------------
summary(BBS_PA_SCTA_3)

## ------------------------------------------------------------------------
BBS_PA_SCTA_3$Year <- 2006
BBS_PA_SCTA_3$Aou <- 6080

## ------------------------------------------------------------------------
BBS_PA_SCTA_3$name <- "SCTA"

## ------------------------------------------------------------------------
BBS_PA_SCTA_3$name <- factor(BBS_PA_SCTA_3$name)

## ------------------------------------------------------------------------
summary(BBS_PA_SCTA_3)

## ------------------------------------------------------------------------
is.na(BBS_PA_SCTA_3$SpeciesTotal)

## ------------------------------------------------------------------------
BBS_PA_SCTA_4 <- NA_to_zero(dat = BBS_PA_SCTA_3,column = "SpeciesTotal")

## ------------------------------------------------------------------------
#with NAs
summary(BBS_PA_SCTA_3$SpeciesTotal)

#with NAs removed by NA_to_zero()
summary(BBS_PA_SCTA_4$SpeciesTotal)

## ------------------------------------------------------------------------
BBS_PA_SCTA_3 <- NA_to_zero(dat = BBS_PA_SCTA_3,
           column = "SpeciesTotal")

## ------------------------------------------------------------------------
ggscatter(data = BBS_PA_SCTA_3,
          y = "SpeciesTotal",
          x = "forest.percent")

## ----eval = F------------------------------------------------------------
#  BBS_PA_SCTA_4 <- BBS_PA_SCTA_3 %>% select(year = Year,
#                                aou = Aou,
#                                route = Route,
#                                name = name,
#                                spp.tot = SpeciesTotal,
#                                for.tot = forest.total,
#                                NLCD.sum = SUM,
#                                for.percent = forest.percent)

## ----eval = T------------------------------------------------------------
BBS_PA_SCTA_4 <- BBS_PA_SCTA_3 %>% dplyr::select(year = Year, 
                              aou = Aou, 
                              route = Route, 
                              name = name,
                              spp.tot = SpeciesTotal,
                              for.tot = forest.total,
                              NLCD.sum = SUM,
                              for.percent = forest.percent)

## ---- eval = FALSE-------------------------------------------------------
#  write.csv(BBS_PA_SCTA_4, file = "SCTA_vs_forest_cover.csv")

