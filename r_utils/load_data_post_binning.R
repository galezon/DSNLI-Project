load_data_post_binning = function(data_path) {
  data = read.csv(data_path, header=TRUE)
  freq_age_bins = readRDS("../data/freq_age_bins.Rda")
  sev_age_bins = readRDS("../data/sev_age_bins_corrected.Rda")  # decreased number of bins
  freq_postcode_bins = readRDS("../data/freq_postcode_bins.Rda")
  sev_postcode_bins = readRDS("../data/sev_postcode_bins.Rda")
  
  # postcode bins
  data = merge(data, freq_postcode_bins, by="CODPOSS", all.x=TRUE, all.y=FALSE)
  data = merge(data, sev_postcode_bins, by="CODPOSS", all.x=TRUE, all.y=FALSE)
  
  # rename x13clusters and x5clusters, and X (the index actually)
  names(data)[names(data) == "X"] = "policy_id"
  names(data)[names(data) == "x5clusters"] = "sev_codposs"
  names(data)[names(data) == "x13clusters"] = "freq_codposs"
  
  # frequency ageph binned
  data = merge(data, freq_age_bins, by="AGEPH", all.x=TRUE, all.y=FALSE)
  names(data)[names(data) == "AGEPH_binned"] = "freq_AGEPH"
  
  # severity ageph binned
  data = merge(data, sev_age_bins, by="AGEPH", all.x=TRUE, all.y=FALSE)
  names(data)[names(data) == "AGEPH_binned"] = "sev_AGEPH"
  
  data = subset(data, select=-c(AGEPH, CODPOSS, lnexpo, nbrtotan))
  
  cat_clmns = c("agecar", "sexp", "fuelc", "split", "usec",
                "fleetc", "sportc", "coverp", "powerc",
                "freq_codposs", "sev_codposs", "freq_AGEPH", "sev_AGEPH")
  for (cat_col in cat_clmns) {
    data[,cat_col] = as.factor(data[, cat_col])
  }
  
  data = within(data, agecar<-relevel(agecar, ref="6-10"))
  data = within(data, sexp<-relevel(sexp, ref="Male"))
  data = within(data, fuelc<-relevel(fuelc, ref="Petrol"))
  data = within(data, split<-relevel(split, ref="Once"))
  data = within(data, usec<-relevel(usec, ref="Private"))
  data = within(data, fleetc<-relevel(fleetc, ref="No"))
  data = within(data, sportc<-relevel(sportc, ref="No"))
  data = within(data, coverp<-relevel(coverp, ref="MTPL"))
  data = within(data, powerc<-relevel(powerc, ref="<66"))
  
  data = within(data, freq_codposs<-relevel(freq_codposs, ref="Class 9"))
  data = within(data, freq_AGEPH<-relevel(freq_AGEPH, ref="Class 10"))
  data = within(data, sev_codposs<-relevel(sev_codposs, ref="Class 3"))
  data = within(data, sev_AGEPH<-relevel(sev_AGEPH, ref="Class 8"))
  
  return(data)
}