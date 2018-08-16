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
data(BBS_PA)

## ------------------------------------------------------------------------
dim(BBS_PA)

## ------------------------------------------------------------------------
data(AOU_species_codes)

## ------------------------------------------------------------------------
library(dplyr)

## ------------------------------------------------------------------------
AOU_species_codes %>% filter(alpha.code == "PIWO")

## ------------------------------------------------------------------------
BBS_PA_PIWO <- BBS_PA %>% filter(Aou == "4050")

## ----eval=TRUE-----------------------------------------------------------
BBS_PA_PIWO_2 <- BBS_PA_PIWO %>% filter(Year == 2006)

## ------------------------------------------------------------------------
data(BBS_PA_landcover_1km)

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km %>%
  select(Route, 
         NLCD.41, # Deciduous Forest
         NLCD.42, # Evergreen
         NLCD.43, # Mixed
         SUM)

## ------------------------------------------------------------------------
BBS_PA_landcover_1km_2$decid.percent <- BBS_PA_landcover_1km_2$NLCD.41/BBS_PA_landcover_1km_2$SUM

BBS_PA_landcover_1km_2$conifer.percent <- BBS_PA_landcover_1km_2$NLCD.42/BBS_PA_landcover_1km_2$SUM

BBS_PA_landcover_1km_2$mixed.forest.percent <- BBS_PA_landcover_1km_2$NLCD.42/BBS_PA_landcover_1km_2$SUM

## ------------------------------------------------------------------------
BBS_PA_PIWO_3 <- full_join(BBS_PA_PIWO_2 ,
                       BBS_PA_landcover_1km_2, 
                       by = "Route")

## ------------------------------------------------------------------------
BBS_PA_PIWO_3$Year <- 2006
BBS_PA_PIWO_3$Aou <- 6080
BBS_PA_PIWO_3$name <- "PIWO"

## ------------------------------------------------------------------------
BBS_PA_PIWO_4 <- NA_to_zero(dat = BBS_PA_PIWO_3,
           column = "SpeciesTotal")

## ------------------------------------------------------------------------
#with NAs
summary(BBS_PA_PIWO_3$SpeciesTotal)

#with NAs removed by set_NA_SpeciesTotal_to_zero()
summary(BBS_PA_PIWO_4$SpeciesTotal)

## ----eval = FALSE--------------------------------------------------------
#  write.csv(BBS_PA_PIWO_4, file = "PIWO_vs_forest_cover.csv")

## ------------------------------------------------------------------------
PIWO_00_05_10 <- sample_BBS_routes(dat = BBS_PA_PIWO,
                  years = c(2000,2005,2010),
                  aou.code = 4050)


## ------------------------------------------------------------------------
library(ggplot2)
library(ggpubr)
ggerrorplot(data = PIWO_00_05_10,
   y = "SpeciesTotal",
   x = "Year",
   desc_stat = "mean_ci")


## ------------------------------------------------------------------------
write.csv(PIWO_00_05_10, file = "PIWO_00_05_10.csv")

## ------------------------------------------------------------------------
## number of birds seen
plot.spp.total <- ggboxplot(data = BBS_PA_PIWO_4,
          y = "SpeciesTotal",
          xlab = "")

## Deciduous landcover
plot.decid.percent <- ggboxplot(data = BBS_PA_PIWO_4,
          y = "decid.percent",
          xlab = "")

## Coniferous landcover
plot.confir.percent <- ggboxplot(data = BBS_PA_PIWO_4,
          y = "conifer.percent",
          xlab = "")

## Mixed forest landcover
plot.mixed.percent <- ggboxplot(data = BBS_PA_PIWO_4,
          y = "mixed.forest.percent",
          xlab = "")

## ------------------------------------------------------------------------
library(cowplot)

plot_grid(plot.spp.total, 
          plot.decid.percent,
          plot.confir.percent, 
          plot.mixed.percent,
          labels = c("A", "B",
                     "C","D"))

## ------------------------------------------------------------------------
## number of birds seen
plot.spp.total <- gghistogram(data = BBS_PA_PIWO_4,
          x = "SpeciesTotal",
          xlab = "")

## Deciduous landcover
plot.decid.percent <- gghistogram(data = BBS_PA_PIWO_4,
          x = "decid.percent",
          xlab = "")

## Coniferous landcover
plot.confir.percent <- gghistogram(data = BBS_PA_PIWO_4,
          x = "conifer.percent",
          xlab = "")

## Mixed forest landcover
plot.mixed.percent <- gghistogram(data = BBS_PA_PIWO_4,
          x = "mixed.forest.percent",
          xlab = "")

## ------------------------------------------------------------------------
library(cowplot)

plot_grid(plot.spp.total, 
          plot.decid.percent,
          plot.confir.percent, 
          plot.mixed.percent,
          labels = c("A", "B",
                     "C","D"))

## ------------------------------------------------------------------------
library(ggplot2)
library(ggpubr)

ggscatter(data = BBS_PA_PIWO_4,
          y = "SpeciesTotal",
          x = "conifer.percent") +
  geom_smooth(se = FALSE)

## ------------------------------------------------------------------------
ggboxplot(data = PIWO_00_05_10,
            y = "SpeciesTotal",
            x = "Year")

## ------------------------------------------------------------------------
gghistogram(data = PIWO_00_05_10,
            x = "SpeciesTotal",
            facet.by = "Year")

## ------------------------------------------------------------------------
ggerrorplot(data = PIWO_00_05_10,
   y = "SpeciesTotal",
   x = "Year",
   desc_stat = "mean_ci")

## ------------------------------------------------------------------------
m.null   <- lm(SpeciesTotal ~ 1, BBS_PA_PIWO_4)

m.decid  <- lm(SpeciesTotal ~ decid.percent, BBS_PA_PIWO_4)

m.mixed  <- lm(SpeciesTotal ~ mixed.forest.percent, BBS_PA_PIWO_4)

## ------------------------------------------------------------------------
library(broom)

tidy(m.null)

tidy(m.decid)

tidy(m.mixed)


## ------------------------------------------------------------------------

summary(m.null)


## ------------------------------------------------------------------------

summary(m.decid)


## ------------------------------------------------------------------------

summary(m.mixed)


## ------------------------------------------------------------------------
anova(m.null, m.decid)

## ------------------------------------------------------------------------
anova(m.null, m.mixed)

## ------------------------------------------------------------------------
library(bbmle)
AICtab(m.null,
       m.decid,
       m.mixed)

## ------------------------------------------------------------------------
PIWO_00_05_10$Year <- factor(PIWO_00_05_10$Year)

## ------------------------------------------------------------------------
m.time.null <- lm(SpeciesTotal ~ 1 , data = PIWO_00_05_10)
m.time.year <- lm(SpeciesTotal ~ Year , data = PIWO_00_05_10)


## ------------------------------------------------------------------------
library(broom)
tidy(m.time.null)
tidy(m.time.year)

## ------------------------------------------------------------------------
library(bbmle)
AICtab(m.time.null,
       m.time.year)

## ------------------------------------------------------------------------

m.time.year.aov <- aov(SpeciesTotal ~ Year , data = PIWO_00_05_10)


## ------------------------------------------------------------------------

TukeyHSD(m.time.year.aov)


## ------------------------------------------------------------------------

tukey.out <- TukeyHSD(m.time.year.aov)


## ------------------------------------------------------------------------
plotTukeysHSD(tukey.out)

