#' Extract random subset of a dataframe
#'
#' Currently only works with data with 2-levels.  Notes that if the size of the dataframe is too small to accomodate n.sample then with.rep is set to TRUE.
#'
#' @param dat R dataframe to randomly subset
#' @param mycode Unique code, such as your email address.  Must contain only letters and numbers and not the at symbol or other punctuation.
#' @param cat.var Categorical variable by which to split the data up
#' @param n.sample Number of samples per group to randomly select.  2*n.sample will be the total size of the dataframe.
#' @param with.rep Should sampling be with replacement?  If with.rep = TRUE then individuals can occur more than once within the dataframe.
#'
#'
#' @examples
#' #Subset frogarms data
#' data(frogarms)
#' my.frogs <- make_my_data2L(dat = frogarms,
#'                            my.code = "nlb24",
#'                            cat.var = "sex",
#'                            n.sample = 20,
#'                            with.rep = FALSE)
#'
#' summary(my.frogs)
#'
#' @export

make_my_data2L <- function(dat,
                           my.code = "nlb24",
                           cat.var,
                           n.sample = 20,
                           with.rep = FALSE){

  cat("Codes should only contain letters and numbers")

  if(n.sample*2 > nrow(dat)){
    cat("\n WARNING: number of samples requested per group exceeds size of dataframe.
        \n Setting with.rep == TRUE will alleviate this.")
  }

  #split string into character vector
  my.code <- unlist(strsplit(my.code,split = ""))

  #extract any numeric parts of code
  i.num <- grep("[01-9]",my.code)

  my.letters <- my.code[-i.num]
  my.numbers <- as.numeric(my.code[i.num])

  #turn letters to numeric position in alaphabet
  my.letters <- match(my.letters,letters)

  #create vector of numbers
  my.code <- c(my.letters,my.numbers)

  #ceate unique variable for seet
  my.seed <- (min(my.code, na.rm = TRUE)+1)^max(my.code, na.rm = TRUE)

  cat("\nYour special code is ", my.seed)
  cat("\n(You don't really need to know this, though).", my.seed)

  #set seed
  set.seed(seed = my.seed)

  cat("\n")
  cat("NOTE: This function only works properly for data with TWO levels to the categorical var.")
  cat("\n eg male vs. female; it doesn't work for >2 levels (eg red vs blue vs. green)")

  #extract levels of categorical varibale
  cat.var.1 <- levels(dat[,cat.var])[1]


  #define 1st subgroup
  i.group1 <- which(dat[,cat.var] == cat.var.1)

  #create numeric row index if it doesn't already exist
  dat$i.rows.working <- 1:nrow(dat)

  #extract groups
  group1 <- sample(dat$i.rows.working[i.group1],size = n.sample,replace = with.rep)
  group2 <- sample(dat$i.rows.working[-i.group1],size = n.sample,replace = with.rep)

  #create new dataframe
  my.dat <- rbind(dat[group1,],
                  dat[group2,])

  return(my.dat)
}
