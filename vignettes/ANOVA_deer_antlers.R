## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, message = FALSE,fig.height = 3, fig.width = 5)

## ------------------------------------------------------------------------
library(wildlifeR)
data(antlers)

## ------------------------------------------------------------------------
# total sample size (all observations)
dim(antlers)

n.total <- length(antlers$mass)

#mean of ALL samples
summary(antlers)

mean(antlers$mass)

#variance of ALL samples
var(antlers$mass)

#stdev of ALL samples
mass.sd <- sd(antlers$mass)

## ------------------------------------------------------------------------
#square root of N
sqrt.n <- sqrt(n.total)

#the see
mass.se <- mass.sd/sqrt.n

mass.se


## ------------------------------------------------------------------------

mass.se <- mass.sd/sqrt(n.total)



## ------------------------------------------------------------------------

#Using raw data
mass.se <- sd(antlers$mass)/
             sqrt(length(antlers$mass))

## ------------------------------------------------------------------------
1.96*mass.se

## ------------------------------------------------------------------------
library(dplyr)

antlers %>% group_by(diet) %>%
   summarize(mass.mean = mean(mass))


## ------------------------------------------------------------------------

antlers %>% group_by(diet) %>%
   summarize(mass.sd = sd(mass))


## ------------------------------------------------------------------------

antlers %>% group_by(diet) %>%
   summarize(mass.N = length(mass))


## ------------------------------------------------------------------------

mass.means <- antlers %>% group_by(diet) %>%
   summarize(mass.mean = mean(mass),
             mass.sd = sd(mass),
             mass.N = length(mass))


## ------------------------------------------------------------------------

mass.SEs <- mass.means$mass.sd/sqrt(mass.means$mass.N)



## ------------------------------------------------------------------------

mass.means$mass.SEs <- mass.SEs


## ------------------------------------------------------------------------
mass.means$mass.CI95 <- mass.means$mass.SEs*1.96

## ------------------------------------------------------------------------
library(ggpubr)

ggerrorplot(antlers, 
            x = "diet", 
            y = "mass", 
            desc_stat = "mean_sd",
            add = "mean"
            )


## ------------------------------------------------------------------------
ggerrorplot(antlers, 
            x = "diet", 
            y = "mass", 
            desc_stat = "mean_se",
            add = "mean"
            )


## ------------------------------------------------------------------------
library("gridExtra")
plot1 <- ggerrorplot(antlers, 
            x = "diet", 
            y = "mass", 
            desc_stat = "mean_sd",
            add = "mean",
            ylim = c(400,900) #set axes
            )

plot2 <- ggerrorplot(antlers, 
            x = "diet", 
            y = "mass", 
            desc_stat = "mean_se",
            add = "mean",
            ylim = c(400,900) #set axes
            )


## ------------------------------------------------------------------------
grid.arrange(plot1,plot2)


## ------------------------------------------------------------------------
ggerrorplot(antlers, 
            x = "diet", 
            y = "mass", 
            desc_stat = "mean_ci",
            add = "mean",
            ylim = c(400,900) #set axes
            )

## ------------------------------------------------------------------------

model.null <- lm(mass ~ 1, 
                 data = antlers)


## ------------------------------------------------------------------------


model.alt <- lm(mass ~ diet, 
                 data = antlers)

## ------------------------------------------------------------------------
anova(model.null,
      model.alt)

## ------------------------------------------------------------------------
summary(model.null)
summary(model.alt)


## ------------------------------------------------------------------------
anova(model.alt)

## ------------------------------------------------------------------------
model.alt.2  <- lm(mass ~-1 + diet, data = antlers)

summary(model.alt.2)

## ------------------------------------------------------------------------
#load the library
library(ggfortify)

#plot the residuals
autoplot(model.alt)

## ------------------------------------------------------------------------
pairwise.t.test(x = antlers$mass,
                g = antlers$diet,
                p.adjust.method = "none")

## ------------------------------------------------------------------------
pairwise.t.test(x = antlers$mass,
                g = antlers$diet,
                p.adjust.method = "bonferroni")

## ------------------------------------------------------------------------

model.alt.aov <- aov(mass ~ diet, 
                     data = antlers)



## ------------------------------------------------------------------------

TukeyHSD(model.alt.aov)


## ------------------------------------------------------------------------
par(mfrow = c(1,1))

tukey.out <- TukeyHSD(model.alt.aov)

plotTukeysHSD(tukey.out)
abline(h = 0, col = 2, lty = 2)


