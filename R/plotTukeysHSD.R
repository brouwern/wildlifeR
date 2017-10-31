#' Plot output of TukeyHSD() function when there are 3 groups
#'
#' @param tukey.out output of TukeyHSD()
#' @param x.axis.label what should be plotted on the x axis
#' @param y.axis.label what should be plotted on the y axis
#' @param axis.adjust for tweaking plotting
#'
#' @export


plotTukeysHSD <- function(tukey.out,
                          x.axis.label = "Comparison",
                          y.axis.label = "Effect Size",
                          axis.adjust = 0){

  tukey.out <- as.data.frame(tukey.out[[1]])
  means <- tukey.out$diff
  categories <- row.names(tukey.out)
  groups <- length(categories)
  ci.low <- tukey.out$lwr
  ci.up  <- tukey.out$upr

  # reset plot window
  #par(mfrow = c(1,1),
  #    mar = c(3.5,3,2,1))

  # calculate values for plotting limits
  y.max <- max(ci.up) +
    max(ci.up)*axis.adjust
  y.min <- min(ci.low) -
    max(ci.low)*axis.adjust

  if(groups == 2){ x.values <- c(0.25, 0.5)}
  if(groups == 3){ x.values <- c(0.25, 0.5,0.75)}

  x.axis.min <- min(x.values)-0.05
  x.axis.max <- max(x.values)+0.05

  x.limits <- c(x.axis.min,x.axis.max)

  #Plot means
  plot(means ~ x.values,
       xlim = x.limits,
       ylim = c(y.min,y.max),
       xaxt = "n",
       xlab = "",
       ylab = "",
       cex = 1.25,
       pch = 16)

  axis(side = 1,
       at = x.values,
       labels = categories
  )

  #Plot upper error bar
  lwd. <- 2
  arrows(y0 = means,
         x0 = x.values,
         y1 = ci.up,
         x1 = x.values,
         length = 0,
         lwd = lwd.)

  #Plot lower error bar
  arrows(y0 = means,
         x0 = x.values,
         y1 = ci.low,
         x1 = x.values,
         length = 0,
         lwd = lwd.)

  mtext(text = x.axis.label,side = 1,line = 1.75)
  mtext(text = y.axis.label,side = 2,line = 1.95)
  mtext(text = "Error bars = 95% CI",side = 3,line = 0,adj = 0)

}
