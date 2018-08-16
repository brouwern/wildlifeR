## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, message = FALSE,
                      #fig.width = 
                      fig.height = 3)

## ------------------------------------------------------------------------
#load devtools
library(devtools)

#download wildlifeR from github
install_github("brouwern/wildlifeR")

#load wildlifeR into your current R sessions
library(wildlifeR)

## ------------------------------------------------------------------------
data(AOU_species_codes)

## ------------------------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
AOU_species_codes %>% filter(alpha.code == "BHCO")

## ------------------------------------------------------------------------
BBS_PA_BHCO <- BBS_PA %>% filter(Aou == "4950")

## ----eval=TRUE-----------------------------------------------------------
BBS_PA_BHCO_2 <- BBS_PA_BHCO %>% filter(Year == 2006)

## ------------------------------------------------------------------------
data(BBS_PA_landcover_1km)

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km %>%
  select(Route, 
         NLCD.21, # Developed Open Space
         NLCD.22, # ... Low Intensity
         NLCD.23, # ... Medium Intensity
         NLCD.24, # ... High Intensity
         NLCD.41, # Deciduous forest
         NLCD.42, # Evergreen
         NLCD.43, # Mixed
         SUM)

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km_2 %>%
  mutate(total.urban =  NLCD.21+NLCD.22+NLCD.23+NLCD.24)

## ------------------------------------------------------------------------
head(BBS_PA_landcover_1km_2)

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km_2 %>%
  mutate(total.forest =  NLCD.41+NLCD.42+NLCD.43)

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2$urban.proportion <- BBS_PA_landcover_1km_2$total.urban/BBS_PA_landcover_1km_2$SUM

BBS_PA_landcover_1km_2$forest.proportion <- BBS_PA_landcover_1km_2$total.forest/BBS_PA_landcover_1km_2$SUM


## ------------------------------------------------------------------------
BBS_PA_BHCO_3 <- full_join(BBS_PA_BHCO_2 ,
                       BBS_PA_landcover_1km_2, 
                       by = "Route")

## ------------------------------------------------------------------------
BBS_PA_BHCO_3$Year <- 2006
BBS_PA_BHCO_3$Aou <- 4950
BBS_PA_BHCO_3$name <- "BHCO"

## ------------------------------------------------------------------------
BBS_PA_BHCO_4 <- NA_to_zero(dat = BBS_PA_BHCO_3,
           column = "SpeciesTotal")

## ----eval = FALSE--------------------------------------------------------
#  write.csv(BBS_PA_BHCO_4, file = "BHCO_vs_forest_cover.csv")

## ----fig.height=2 , fig.width=2------------------------------------------
library(ggpubr)

ggboxplot(data = BBS_PA_BHCO_4,
         y = "SpeciesTotal",
         ylab = "",
         xlab = "")

## ----fig.height=2 ,fig.width=2-------------------------------------------
gghistogram(data = BBS_PA_BHCO_4,
         x = "SpeciesTotal")

## ------------------------------------------------------------------------
which(BBS_PA_BHCO_4$SpeciesTotal > 75)

## ------------------------------------------------------------------------
outlier.index <- which(BBS_PA_BHCO_4$SpeciesTotal > 75)

BBS_PA_BHCO_4$SpeciesTotal[outlier.index] <- NA

## ------------------------------------------------------------------------
urban.plot <- ggscatter(data = BBS_PA_BHCO_4,
          y = "SpeciesTotal",
          x = "urban.proportion",
          add = "reg.line",
          conf.int = TRUE,
          xlab = "Proportion urban habitat",
          ylab = "Number of cowbirds")

forest.plot <- ggscatter(data = BBS_PA_BHCO_4,
          y = "SpeciesTotal",
          x = "forest.proportion",
          add = "reg.line",
          conf.int = TRUE,
          xlab = "Proportion forest habitat",
          ylab = "Number of cowbirds",
          shape = 23,
          fill = "green")


## ------------------------------------------------------------------------
library(cowplot)

plot_grid(urban.plot, 
          forest.plot,
          labels = c("A", "B"))

## ------------------------------------------------------------------------
m.null   <- lm(SpeciesTotal ~ 1, BBS_PA_BHCO_4)

m.urban  <- lm(SpeciesTotal ~ urban.proportion, BBS_PA_BHCO_4)

m.forest  <- lm(SpeciesTotal ~ forest.proportion, BBS_PA_BHCO_4)

## ------------------------------------------------------------------------
library(broom)

options(digits=3)

tidy(m.null)

tidy(m.urban)

tidy(m.forest)


## ------------------------------------------------------------------------

summary(m.null)


## ------------------------------------------------------------------------

summary(m.urban)


## ------------------------------------------------------------------------

summary(m.forest)


## ------------------------------------------------------------------------
anova(m.null, 
      m.urban)

## ------------------------------------------------------------------------
anova(m.null, 
      m.forest)

## ------------------------------------------------------------------------
library(bbmle)
AICtab(m.null,
       m.urban,
       m.forest)

## ------------------------------------------------------------------------
BBS_PA_BHCO_4 <- BBS_PA_BHCO_4 %>% mutate(SpeciesTotal.log = 
                                             log(SpeciesTotal+1))

## ------------------------------------------------------------------------
m.null.log   <- lm(SpeciesTotal.log ~ 1, BBS_PA_BHCO_4)

m.urban.log  <- lm(SpeciesTotal.log ~ urban.proportion, BBS_PA_BHCO_4)

m.forest.log  <- lm(SpeciesTotal.log ~ forest.proportion, BBS_PA_BHCO_4)

## ------------------------------------------------------------------------
anova(m.null.log,
        m.urban.log)

## ------------------------------------------------------------------------
anova(m.null.log,
        m.forest.log)

## ------------------------------------------------------------------------
AICtab(m.null.log,
       m.urban.log,
       m.forest.log)

## ------------------------------------------------------------------------
m.forest.log2  <- lm(SpeciesTotal.log ~ urban.proportion +
                      I(forest.proportion^2), BBS_PA_BHCO_4)

