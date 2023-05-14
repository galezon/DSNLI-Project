smooth_to_factors = function(df, breaks, on_var) {
  classes = seq(1, length(breaks) - 1)  # breaks are like |a|b|c|
  
  # one of the break points is 
  breaks = breaks[-c(1, length(breaks))]  # throw away the min and max
  
  assigned_class = rep(0, nrow(df))
  for (idx in 1:nrow(df)) {
    value = df[idx, on_var]
    assigned_class[idx] = 1 + sum(breaks <= value)
    # > breaks
    # [1] -0.5252497 -0.1044548  0.1219658  0.3700434
    # value = 0.1
    # > sum(breaks <= value)
    # [1] 1
  }
  
  df[paste(on_var, "binned", sep="_")] = paste("Class", assigned_class)
  return (df)
}