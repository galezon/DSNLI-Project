# from Dr. Antonio's computer lab
splits_evtree = function(evtreemodel, GAMvar, DTvar){
  preds <- predict(evtreemodel, type = "node")
  nodes <- data.frame("x" = GAMvar, "nodes" = preds)
  nodes$change <- c(0, pmin(1, diff(nodes$nodes)))
  splits_evtree <- unique(c(min(DTvar), 
                            nodes$x[which(nodes$change==1)], 
                            max(DTvar)))
  return(splits_evtree)
}