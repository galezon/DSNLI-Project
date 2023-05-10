subset_on_level = function(data, level_obj) {
  # e.g. level_obj = levels[1, ]
  tmp = data
  for (fact_col in names(Filter(is.factor, data))) {
    if (fact_col != "CODPOSS") {
      # below is monstrous but it's the only way I know
      tmp = tmp[tmp[fact_col] == as.character(level_1[fact_col][1, 1]), ]
    }
  }
  return (tmp)
}