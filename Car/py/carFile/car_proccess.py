import pandas as pd
import re
df = pd.read_csv("./carFile/carname_submodel_list.csv")

# 특정 열에 대해 괄호 안의 내용 제거
# 예시로 '차량명'이라는 열에서 괄호를 제거한다고 가정
df['sebumodel'] = df['sebumodel'].apply(lambda x: re.sub(r'\(.*?\)', '', str(x)).strip())

df = df["manufacturer"] +" " + df['sebumodel']
df.to_csv('carname.csv', index=False)