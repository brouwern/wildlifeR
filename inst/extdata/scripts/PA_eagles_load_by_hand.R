#### Step one: Build R objects
#####First, we'll use the assignment operator ("<-") to create an R object called "year" that lists the years from 1980 through 2015 for which the number breeding pairs of eagles in Pennsylvania, USA, is known.   

year <- c(1980,1981,1982,1983,1984,1985,1986,1987,1988,1989,
          1990,1991,1992,1993,1994,1995,1996,1997,1998,1999,
          2000,2001,2002,2003,2004,2005,2006,2007,2008,2009,
          2010,2011,2012,2013,2014,2015,2016)

#A quick trick to do this much fast is

year <- c(1980:2016)


#### Second, we'll create an object called "eagles" with the number of breeding pairs (male and females paired up for making baby eagles) recorded each year. Note that most years in the 1980s are skipped because there is not data available. 
eagles <-  c(3, NA, NA, NA, NA, NA, NA,NA,NA,NA,
             7,  9, 15, 17, 19, 20, 20,23,29,43,
             51,55, 64, 69, NA, 96,100,NA,NA,NA,
             NA,NA, NA, NA,252,277, NA)

#### Step two: Build dataframe
##### We can then turn these two seperate R objects into a dataframe
eagle.df <-data.frame(year, eagles)

