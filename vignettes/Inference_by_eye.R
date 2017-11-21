## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE, warnings = FALSE, message = FALSE,fig.height = 3, fig.width = 5)

## ------------------------------------------------------------------------
MASS::data("cats")

## ------------------------------------------------------------------------
dim(cats)
summary(cats)

## ------------------------------------------------------------------------
library(doBy)

#get the mean and SD
cat.df1 <- summaryBy(Bwt ~ Sex, data = cats, FUN = c(mean,sd))

#get the sample size using length()
cat.df2 <- summaryBy(Bwt ~ Sex, data = cats, FUN = c(length))

#make a combined dataframe
cat.df3 <- merge(cat.df1,cat.df2)

#calculate the standard error SE by hand

cat.df3$SE <- cat.df3$Bwt.sd/sqrt(cat.df3$Bwt.length)


## ------------------------------------------------------------------------

cat.df3


## ------------------------------------------------------------------------
par(mfrow = c(1,1),mar = c(3,3.5,1,1))

boxplot(Bwt ~ Sex, data = cats)

## ------------------------------------------------------------------------
library(Hmisc)
par(mfrow = c(1,2),mar = c(3,3.5,1,1))

y.lim <- c(2.295,3)
errbar(1:2,
       y = cat.df3$Bwt.mean,
       yplus =cat.df3$Bwt.mean + cat.df3$SE,
       yminus = cat.df3$Bwt.mean-cat.df3$SE,
       xlab = "",
       ylab = "",
       xlim=c(0.5,2.5),
       ylim = y.lim,
       xaxt="n",cex =1)
axis(side=1,at=1:2,labels=cat.df3$Sex)
mtext("Sex", side = 1, line = 2, cex = 2)
mtext("Mass (g)", side = 2, line = 2.1, cex = 1.3)

errbar(1:2,
       y = cat.df3$Bwt.mean,
       yplus =cat.df3$Bwt.mean + 1.96*cat.df3$SE,
       yminus = cat.df3$Bwt.mean-1.96*cat.df3$SE,
       xlab = "",
       ylab = "",
       xlim=c(0.5,2.5),
       ylim = y.lim,
       xaxt="n",cex =1)
axis(side=1,at=1:2,labels=cat.df3$Sex)
mtext("Sex", side = 1, line = 2, cex = 2)
mtext("Mass (g)", side = 2, line = 2.1, cex = 1.3)



## ------------------------------------------------------------------------
cat.df3.mod <- cat.df3
cat.df3.mod$Bwt.mean[1] <- cat.df3$Bwt.mean[2]-cat.df3$Bwt.mean[2]*0.0425

## ------------------------------------------------------------------------
y.lim <- c(2.6975,3)
par(mar = c(3,3.5,1,1))
errbar(1:2,
       y = cat.df3.mod$Bwt.mean,
       yplus =cat.df3.mod$Bwt.mean + cat.df3.mod$SE,
       yminus = cat.df3.mod$Bwt.mean-cat.df3.mod$SE,
       xlab = "",
       ylab = "",
       xlim=c(0.5,2.5),
       ylim = y.lim,
       xaxt="n",cex =1)
axis(side=1,at=1:2,labels=cat.df3.mod$Sex)
mtext("Sex", side = 1, line = 2, cex = 2)
mtext("Mass (g)", side = 2, line = 2.1, cex = 1.3)

errbar(1:2,
       y = cat.df3.mod$Bwt.mean,
       yplus =cat.df3.mod$Bwt.mean + 1.96*cat.df3.mod$SE,
       yminus = cat.df3.mod$Bwt.mean-1.96*cat.df3.mod$SE,
       xlab = "",
       ylab = "",
       xlim=c(0.5,2.5),
       ylim = y.lim,
       xaxt="n",cex =1)
axis(side=1,at=1:2,labels=cat.df3.mod$Sex)
mtext("Sex", side = 1, line = 2, cex = 2)
mtext("Mass (g)", side = 2, line = 2.1, cex = 1.3)




## ------------------------------------------------------------------------

t.test(Bwt ~ Sex, data = cats)



## ------------------------------------------------------------------------

summary(lm(Bwt ~ -1+Sex, data = cats))


