


data("AOU_species_codes")
names(AOU_species_codes)


i.name <- grep("Robin",AOU_species_codes$name,ignore.case = F)
AOU_species_codes[i.name,]




data("BBS_PA")
names(BBS_PA)

function(years = c(1990,2000,2005),
         aou.code = 7610,
         max.sample = 50)


years <- c(1990,2000,2005)
aou.code <- 7610
max.sample <- 50


unique.routes <- unique(BBS_PA$Route)
n.unique.routes <- length(unique.routes)
n.years <- length(years)

#number of routes per year, rounding down
n.routes.per.year <- trunc(n.unique.routes/n.years)

#set total number of routes
##can be less that all possible if allowed by user
n.routes.per.year <- ifelse(n.routes.per.year > max.sample,
                            max.sample,
                            n.routes.per.year)

n.routes.tot <- n.routes.per.year*n.years


#sample w/o replacement n.routes.total from vector of
##all unique routes
sampled.routes <- sample(x = unique.routes,
                         size = n.routes.total,
                         replace = F)

route.index <- 1:n.routes.tot

route.df <- data.frame(Aou = aou.code,
                       route.index,
                        Route = sampled.routes)
dim(route.df)
requireNamespace("Hmisc")

route.df$cuts <- cut2(route.df$route.index,
     m = n.routes.per.year)

route.df$Year <- factor(route.df$cuts,
                        labels = years)
route.df$Year <- as.numeric(as.character(route.df$Year))
any(duplicated(route.df) == TRUE)

df.out <- merge(route.df, BBS_PA)

summary(df.out)


