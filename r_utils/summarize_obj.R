summarize_obj = function(obj) {
  print(summary(obj))
  print("-----------------------------------------------------------------")
  print(anova(obj))
  print("-----------------------------------------------------------------")
  print(paste("AIC =", AIC(obj), "BIC =", BIC(obj)))
}