import pandas as pd

df = pd.read_csv("./carFile/carname.csv")

df['title'] = df['title'].str.replace(" ", "", regex=False)

df.to_csv("carname_nospace.csv", index=False)

print("띄어쓰기 제거 완료! -> carname_nospace.csv")
