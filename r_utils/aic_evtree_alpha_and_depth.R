aic_evtree_alpha_and_depth = function(gam_preds, gam_var,
                                          alpha_grid, tree_formula,
                                          glm_trainset, glm_formula,
                                          glm_family, max_depth) {
  # gam_preds := dataframe containing variables in formula and their weights
  # parent_dataset := trainset for GLM 
  # gam_var := the variable we are binning, this is the covariate in tree_formula
  # max_depth := maxdepth of the tree
  
  # to store AIC values
  aic_results = matrix(nrow=length(alpha_grid), ncol=length(max_depth))  
  
  for (depth_idx in 1:length(max_depth)) {
    
    depth = max_depth[depth_idx]
    for (alpha_idx in 1:length(alpha_grid)) {
      
      alpha = alpha_grid[alpha_idx]
      
      tmp_aic = AIC_from_evtree(gam_preds, depth, alpha, tree_formula, glm_trainset,
                            glm_formula, gam_var, glm_family)
      
      aic_results[alpha_idx, depth_idx] = tmp_aic
      
    }
  }
  
  aic_results = as.data.frame(aic_results)
  rownames(aic_results) = paste("alpha=", alpha_grid, sep="")
  colnames(aic_results) = paste("depth=", max_depth, sep="")
  
  return(aic_results)
}


# this function works just fine
AIC_from_evtree = function(gam_preds, depth, alpha,
                           tree_formula, glm_trainset, glm_formula,
                           gam_var, glm_family) {
  
  set.seed(0916778)  # re-producibility
  
  # 16 nodes * (at least) 0.05 = 0.8 => 32 nodes too many
  ctrl = evtree.control(minbucket=0.05*nrow(gam_preds), maxdepth=depth,
                        alpha=alpha, niterations=20000, ntrees=200)
  tmp_tree = evtree(formula=tree_formula, data=gam_preds, weights=Weights, control=ctrl)
  
  # get the splits
  splits = splits_evtree(tmp_tree, gam_preds[, gam_var], glm_trainset[, gam_var])
  
  # for training the GLM
  glm_df = smooth_to_factors(glm_trainset, splits, gam_var)
  
  # train the glm
  return( glm(glm_formula, family=glm_family, data=glm_df)$aic )
}