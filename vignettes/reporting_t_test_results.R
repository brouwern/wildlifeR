## ---- include=FALSE------------------------------------------------------
library(wildlifeR)
data(brook_trout_ABD)

#calculate survival
brook_trout_ABD$survival <- brook_trout_ABD$salmon.released/(brook_trout_ABD$salmon.surv+brook_trout_ABD$salmon.released)

#make column of fake data
fake.surv <- brook_trout_ABD$survival
fake.surv[1:6] <- with(brook_trout_ABD,
                       survival - survival*0.15)[1:6]

salmon <- brook_trout_ABD

## ------------------------------------------------------------------------
salmon <- data.frame(survival = c(0.83,0.87,0.82,
                                  0.84,0.81,0.84,
                                  0.72, 0.84,0.75,
                                  0.79,0.89,0.87),
                     brook.trout.PRES.ABS =
                       c("present","present","present",                                            "present","present","present",
                          "absent","absent","absent",
                          "absent","absent","absent"))


## ------------------------------------------------------------------------
#library(ggplot2)
library(ggpubr)

ggboxplot(data = salmon,
          y = "survival",
          x = "brook.trout.PRES.ABS",
          fill = "brook.trout.PRES.ABS",
          xlab = "Brook trout - absent or present?",
          ylab = "Chinook salmon survival")



## ------------------------------------------------------------------------
t.test(survival ~ brook.trout.PRES.ABS, 
       data = salmon)

## ---- echo=FALSE---------------------------------------------------------
t.test(fake.surv ~ salmon$brook.trout.PRES.ABS)

