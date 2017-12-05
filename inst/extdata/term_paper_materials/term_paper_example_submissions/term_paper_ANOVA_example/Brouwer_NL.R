## Example script

### ANOVA analysis with TukeyHSD comparison of means

### Analysis of change in Pileated woodpecker (PIWO) abundance over time
#### and variation over time (2000,2005, 2010)

### Script written 11/21/2017
### by Nathan Brouwer
### brouwern@gmail.com


### Load libraries

library(Hmisc)
library(ggplot2)
library(ggpubr)
library(copwlot)


## Load data
### Abundance of PIWO in 2000, 2005, 2010
PIWO_00_05_10 <- read.csv(file ="PIWO_00_05_10.csv")




## Exploring abudance-time data

### Boxplot
ggboxplot(data = PIWO_00_05_10,
          y = "SpeciesTotal",
          x = "Year")

### Histograms
gghistogram(data = PIWO_00_05_10,
            x = "SpeciesTotal",
            facet.by = "Year")


## Data modeling

### Modeling variation over time

#### Make sure Year is a factor
PIWO_00_05_10$Year <- factor(PIWO_00_05_10$Year)

### Null model: no change over time
m.time.null <- lm(SpeciesTotal ~ 1 , data = PIWO_00_05_10)

### alt model: change over time
m.time.year <- lm(SpeciesTotal ~ Year , data = PIWO_00_05_10)



### Results

## Compare  alt model against null model
### using omnibus ANOVA F-test

#### Significance test with anova()
anova(m.time.null,
      m.time.year)

    # Analysis of Variance Table
    #
    # Model 1: SpeciesTotal ~ 1
    # Model 2: SpeciesTotal ~ Year
    # Res.Df    RSS Df Sum of Sq      F Pr(>F)
    # 1    119 247.97
    # 2    117 247.75  2   0.21667 0.0512 0.9501



### Summary of year model

#### No overall "Sig" for omnibus ANOVA, but
#### want to examine results to understand data better

summary(m.time.year)

    # Coefficients: Estimate Std. Error t value Pr(>|t|)
    # (Intercept)   0.7750     0.2301   3.368  0.00102 **
    # Year2005      0.0250     0.3254   0.077  0.93889
    # Year2010      0.1000     0.3254   0.307  0.75914
    # ---
    #   Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    #
    # Residual standard error: 1.455 on 117 degrees of freedom
    # Multiple R-squared:  0.0008738,	Adjusted R-squared:  -0.01621
    # F-statistic: 0.05116 on 2 and 117 DF,  p-value: 0.9501



#### Multiple comparisons using TukeyHSD

#### Overall ANOVA not significant but want to carry out exploratory analyses.

##### Refit model w/aov()
###### need to refit model with aov() to get TUkey to work
m.time.year.aov <- aov(SpeciesTotal ~ Year , data = PIWO_00_05_10)

#Run TukeyHSD
TukeyHSD(m.time.year.aov)

# Tukey multiple comparisons of means
# 95% family-wise confidence level
# Fit: aov(formula = SpeciesTotal ~ Year, data = PIWO_00_05_10)
#
# $Year
# diff        lwr       upr     p adj
# 2005-2000 0.025 -0.7474376 0.7974376 0.9967509
# 2010-2000 0.100 -0.6724376 0.8724376 0.9492915
# 2010-2005 0.075 -0.6974376 0.8474376 0.9711441


### save output to object
tukey.out <- TukeyHSD(m.time.year.aov)

### Plot effect sizes using TUkeysHSD
#### not that "s" in Tukey's!
plotTukeysHSD(tukey.out)


### Create focal figure

### Plotting means and error bars
#### Means with 95% CI
ggerrorplot(data = PIWO_00_05_10,
            y = "SpeciesTotal",
            x = "Year",
            desc_stat = "mean_ci",
            xlab = "Year",
            ylab = "Number of PIWO observed",
            ylim = c(0, 1.5))


