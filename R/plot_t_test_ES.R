#' Function to plot the absolute effect size from a t-test
#'
#' This function takes a fitted t-test as its input and plots a graph of the absolute effect size (difference between means).
#' Note that this is just the raw difference between means of each group, not a standardized effect size.
#' Data that is plotted is extracted from the means and confidence intervals reported by the t.test() function.
#' Uses ggplot
#'
#' @param t.test.out Output of 2-sample t-test using t.test()
#' @param point.sze Size of point representing the mean.
#'
#' @examples
#' #Subset frogarms data
#' data(frogarms)
#' mass.t <- t.test(mass ~ sex, data = frogarms)
#' plot_t_test_ES(mass.t)
#'
#' @export

plot_t_test_ES <- function(t.test.out, point.sz = 5){

  ES <-t.test.out$estimate[1]-t.test.out$estimate[2]

  df <- c(ES,t.test.out$conf.int)
  names(df) <- c("Difference", "CI.low","CI.high")
  df <- data.frame(t(df))
  t. <- round(t.test.out$statistic,2)
  p. <- round(t.test.out$p.value,2)
  test.stats <- paste("t = ",t.,", p = ",p.)
  ggplot(data = df) +
    geom_point(aes(y = Difference, x = 1),
               size = point.sz) +
    xlab("") +
    geom_errorbar(data = df,
                  aes(x = 1,
                      ymax = CI.high ,
                      ymin = CI.low),
                  width =0,
                  size = 1.5)+
    geom_hline(yintercept = 0, linetype = 2) +
    xlim(0.9,1.1) +
    annotate("text",x = 0.95, y= df$CI.high,label = test.stats) +
    theme(axis.text.x = element_blank()) +
    theme(axis.ticks.x = element_blank())
}
