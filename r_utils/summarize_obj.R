summarize_obj = function(obj) {
  print(summary(obj))
  print("-----------------------------------------------------------------")
  print(anova(obj))
  print("-----------------------------------------------------------------")
  print(paste("AIC =", AIC(obj), "BIC =", BIC(obj)))
}

summarize_obj_glm = function(obj) {
  print(summary(obj))
  print("-----------------------------------------------------------------")
  print(anova(obj, test="Chisq"))
  print("-----------------------------------------------------------------")
  print(paste("AIC =", AIC(obj), "BIC =", BIC(obj)))
}