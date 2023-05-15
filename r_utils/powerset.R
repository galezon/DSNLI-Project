# https://stackoverflow.com/q/18715580/13508076
powerset = function(s){
  len = length(s)
  l = vector(mode="list",length=2^len) ; l[[1]]=numeric()
  counter = 1L
  for(x in 1L:length(s)){
    for(subset in 1L:counter){
      counter=counter+1L
      l[[counter]] = c(l[[subset]],s[x])
    }
  }
  return(l)
}

# I wrote this function myself
powerset_formula = function(vars, base_formula, operation) {
  # operation = "+" or "-"
  
  var_powerset = powerset(vars)
  
  formulas_list = list()
  for (idx in 2:length(var_powerset)) {  # idx=1 is the empty-set
    var_combo = var_powerset[[idx]]  # [1] "usec"   "fleetc"
    var_combo_as_str = paste(var_combo, collapse=operation)  # "usec+fleetc"
    base_formula_str = paste("~.", operation, sep="")
    
    new_formula_update_str = paste(base_formula_str, var_combo_as_str, sep="")
    new_formula = update(base_formula, new_formula_update_str)
    formulas_list[[idx - 1]] = new_formula
  }
  return(formulas_list)
}