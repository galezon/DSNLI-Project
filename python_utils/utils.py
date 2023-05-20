import pandas as pd

def postcodes_to_latlong(df: pd.DataFrame):
    spatial = pd.read_excel("../initial_docs/inspost.xls")
    spatial.drop(columns=["INS", "COMMUNE"], inplace=True)  # we do not need these info
    tmp_df = pd.merge(df, spatial, how="left", on="CODPOSS")
    tmp_df.drop(columns="CODPOSS", inplace=True)
    
    return tmp_df


def cat_to_numeric(data: pd.DataFrame):
    tmp = data.copy(deep=True)
    
    tmp['agecar'] = tmp['agecar'].map({"0-1": 0, "2-5": 1, "6-10":2, ">10": 3})
    tmp['sexp'] = tmp['sexp'].map({"Male": 0, "Female": 1})
    tmp['fuelc'] = tmp['fuelc'].map({"Petrol": 0, "Gasoil": 1})
    tmp['split'] = tmp['split'].map({"Once": 0, "Monthly": 1, "Twice":2, "Thrice": 3})
    tmp['usec'] = tmp['usec'].map({"Private": 0, "Professional": 1})
    tmp['fleetc'] = tmp['fleetc'].map({"Yes": 0, "No": 1})
    tmp['sportc'] = tmp['sportc'].map({"Yes": 0, "No": 1})
    tmp['coverp'] = tmp['coverp'].map({"MTPL": 0, "MTPL+": 1, "MTPL+++":2})
    tmp['powerc'] = tmp['powerc'].map({"<66": 0, "66-110": 1, ">110":2})
    
    return tmp


def avg_claim(row):
    if row['nbrtotc'] == 0:
        return 0
    else:
        return row['chargtot'] / row['nbrtotc']



