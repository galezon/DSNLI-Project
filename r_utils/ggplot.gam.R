# from Dr. Antonio's computer lab
ggplot.gam <- function(model, variable, gam_term, 
                       xlabel, ylabel){
  pred <- predict(model, type = "terms", se = TRUE)
  col_index <- which(colnames(pred$fit)==gam_term)
  x <- variable
  b <- pred$fit[, col_index]
  l <- pred$fit[, col_index] - 
    qnorm(0.975) * pred$se.fit[, col_index]
  u <- pred$fit[, col_index] + 
    qnorm(0.975) * pred$se.fit[, col_index]
  df <- unique(data.frame(x, b, l, u))
  p <- ggplot(df, aes(x = x))
  p <- p + geom_line(aes(y = b), size = 1, 
                     col = "#003366")
  p <- p + geom_line(aes(y = l), size = 0.5, 
                     linetype = 2, col = "#99CCFF")
  p <- p + geom_line(aes(y = u), size = 0.5, 
                     linetype = 2, col = "#99CCFF")
  p <- p + xlab(xlabel) + ylab(ylabel) + theme_bw()
  p
}