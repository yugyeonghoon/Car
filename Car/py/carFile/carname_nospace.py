import pandas as pd

df = pd.read_csv("./carFile/carname.csv")

df['title'] = df['title'].str.replace(" ", "", regex=False)

df.to_csv("carname_nospace.csv", index=False)
