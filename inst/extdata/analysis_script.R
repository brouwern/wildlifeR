## Example script

### Analysis of change in Pileated woodpecker abundance versus habitat
#### and variation over time (2000,2005, 2010)

### Script written 11/21/2017
### by Nathan Brouwer
### brouwern@gmail.com


# This is a bare-bones script to carry out the creation of the dataframe
# and begin the regression/ANOVA anlaysis.  To be complete this script
# MUST have additional comment added.  Please see the associated vignette
# in the widlifeR package for more infomation.


#load devtools
library(devtools)

#download wildlifeR from github
install_github("brouwern/wildlifeR")

#load wildlifeR into your current R sessions
library(wildlifeR)



### The USGS BBS data
data(BBS_PA)


### Selecting a focal bird species

### Determing the numeric species code

data(AOU_species_codes)

library(dplyr)

#Pileated woodpecker
AOU_species_codes %>% filter(alpha.code == "PIWO")

#Brown headed cowbird
AOU_species_codes %>% filter(alpha.code == "BHCO")

#Blue jay
AOU_species_codes %>% filter(alpha.code == "BLJA")


#American crow
AOU_species_codes %>% filter(alpha.code == "AMCR")

#L. waterthrush
AOU_species_codes %>% filter(alpha.code == "LOWA")


BBS_PA_PIWO <- BBS_PA %>% filter(Aou == "4050")
BBS_PA_BHCO <- BBS_PA %>% filter(Aou == "4950")
BBS_PA_BLJA <- BBS_PA %>% filter(Aou == "4770")
BBS_PA_AMCR <- BBS_PA %>% filter(Aou == "4880")
BBS_PA_LOWA <- BBS_PA %>% filter(Aou == "6760")



### Selecting a focal analysis question

### Formatting data for habitat analyses

#### Subsetting bird data

BBS_PA_PIWO_2 <- BBS_PA_PIWO %>% filter(Year == 2006)

#### Preparing habitat data

data(BBS_PA_landcover_1km)


BBS_PA_landcover_1km_2 <- BBS_PA_landcover_1km %>%
  select(Route, NLCD.41, NLCD.42, NLCD.43, SUM)



#### Calculating percentages of habitat


BBS_PA_landcover_1km_2$decid.percent <- BBS_PA_landcover_1km_2$NLCD.41/BBS_PA_landcover_1km_2$SUM

BBS_PA_landcover_1km_2$conifer.percent <- BBS_PA_landcover_1km_2$NLCD.42/BBS_PA_landcover_1km_2$SUM

BBS_PA_landcover_1km_2$mixed.forest.percent <- BBS_PA_landcover_1km_2$NLCD.42/BBS_PA_landcover_1km_2$SUM


#### Merging bird counts and habitat cover

BBS_PA_PIWO_3 <- full_join(BBS_PA_PIWO_2 ,
                           BBS_PA_landcover_1km_2,
                           by = "Route")

#### Filling in columns
BBS_PA_PIWO_3$Year <- 2006
BBS_PA_PIWO_3$Aou <- 6080
BBS_PA_PIWO_3$name <- "PIWO"

#### Filling in NAs
BBS_PA_PIWO_4 <- NA_to_zero(dat = BBS_PA_PIWO_3,
column = "SpeciesTotal")

#compare output
#with NAs
summary(BBS_PA_PIWO_3$SpeciesTotal)

#with NAs removed by set_NA_SpeciesTotal_to_zero()
summary(BBS_PA_PIWO_4$SpeciesTotal)

## Save data
write.csv(BBS_PA_PIWO_4, file = "PIWO_vs_forest_cover.csv")




### Formatting data for analysis of change over time

library(Hmisc)

PIWO_00_05_10 <- sample_BBS_routes(dat = BBS_PA_PIWO,
years = c(2000,2005,2010),
aou.code = 4050)

library(ggplot2)
library(ggpubr)

#### Plot
ggerrorplot(data = PIWO_00_05_10,
y = "SpeciesTotal",
x = "Year",
desc_stat = "mean_ci")




### save

write.csv(PIWO_00_05_10, file = "PIWO_00_05_10.csv")



## Data Exploration

### Exploring abundance-habitat data

Boxplots, histograms, and scatterplots can be used to explore the data



#### Boxplots


## number of birds seen
plot1.spp.total <- ggboxplot(data = BBS_PA_PIWO_4,
    y = "SpeciesTotal",
    xlab = "")

## Deciduous landcover
plot2.decid.percent <- ggboxplot(data = BBS_PA_PIWO_4,
    y = "decid.percent",
    xlab = "")

## Coniferous landcover
plot3.confir.percent <- ggboxplot(data = BBS_PA_PIWO_4,
    y = "conifer.percent",
    xlab = "")

## Mixed forest landcover
plot4.mixed.percent <- ggboxplot(data = BBS_PA_PIWO_4,
    y = "mixed.forest.percent",
    xlab = "")


###
library(cowplot)

plot_grid(plot1.spp.total,
          plot2.decid.percent,
          plot3.confir.percent,
          plot4.mixed.percent,
          labels = c("A", "B",
                      "C","D"))



#### Histograms

## number of birds seen
plot1.spp.total <- gghistogram(data = BBS_PA_PIWO_4,
                              x = "SpeciesTotal",
                              xlab = "")

## Deciduous landcover
plot2.decid.percent <- gghistogram(data = BBS_PA_PIWO_4,
                                  x = "decid.percent",
                                  xlab = "")

## Coniferous landcover
plot3.confir.percent <- gghistogram(data = BBS_PA_PIWO_4,
                                   x = "conifer.percent",
                                   xlab = "")

## Mixed forest landcover
plot4.mixed.percent <- gghistogram(data = BBS_PA_PIWO_4,
                                  x = "mixed.forest.percent",
                                  xlab = "")

## Layout the four plots in a grid.

library(cowplot)

plot_grid(plot1.spp.total,
          plot2.decid.percent,
          plot3.confir.percent,
          plot4.mixed.percent,
          labels = c("A", "B",
                     "C","D"))


#### Scatter plot

library(ggplot2)
library(ggpubr)

ggscatter(data = BBS_PA_PIWO_4,
          y = "SpeciesTotal",
          x = "conifer.percent") +
          geom_smooth(se = FALSE)



### Exploring abudance-time data

#### Boxplot

ggboxplot(data = PIWO_00_05_10,
          y = "SpeciesTotal",
          x = "Year")



#### Histograms

gghistogram(data = PIWO_00_05_10,
            x = "SpeciesTotal",
            facet.by = "Year")



#### Plotting means and error bars

ggerrorplot(data = PIWO_00_05_10,
            y = "SpeciesTotal",
            x = "Year",
            desc_stat = "mean_ci")



## Data modeling

### Modeling habitat

m.null   <- lm(SpeciesTotal ~ 1, BBS_PA_PIWO_4)

m.decid  <- lm(SpeciesTotal ~ decid.percent, BBS_PA_PIWO_4)

m.mixed  <- lm(SpeciesTotal ~ mixed.forest.percent, BBS_PA_PIWO_4)



### Present results

#### Regression summary
library(broom)
tidy(m.null)
tidy(m.decid)
tidy(m.mixed)

#### Significance test
anova(m.null, m.decid)
anova(m.null, m.mixed)


#### Model comparison
library(bbmle)
AICtab(m.null,
       m.decid.
       m.mixed)

### Modeling variation over time
PIWO_00_05_10$Year <- factor(PIWO_00_05_10$Year)
m.time.null <- lm(SpeciesTotal ~ 1 , data = PIWO_00_05_10)
m.time.year <- lm(SpeciesTotal ~ Year , data = PIWO_00_05_10)

#### Regression summary
library(broom)
tidy(m.time.null)
tidy(m.time.year)

#### Model comparison
library(bbmle)
AICtab(m.time.null,
       m.time.year)

#### Multiple comparisons

##### Refit model w/aov()
m.time.year.aov <- aov(SpeciesTotal ~ Year , data = PIWO_00_05_10)


TukeyHSD(m.time.year.aov)

tukey.out <- TukeyHSD(m.time.year.aov)

plotTukeysHSD(tukey.out)
