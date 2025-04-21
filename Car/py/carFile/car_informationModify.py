import pandas as pd
import re

df = pd.read_csv("car_informationFinal.csv")

#이미지 컬럼에 있는 값만 출력
image = df["image"].unique()
#print(image)

#빈 값인 이미지 칼럼만 출력
image = df[df["image"].isna()]
#df의 image컬럼의 값이 nan인 행을 찾는다.
#print(image["image"].fillna("./free-icon-car-3097144.png"))

df["image"] = df["image"].fillna("free-icon-car-3097144.png")
#df의 image컬럼의 값이 nan인 행을 찾아서 "./free-icon-car-3097144.png"이 값으로 채워넣고(결측치 대체)
#원본 df의 image컬럼에 다시 대입

print(df[df["image"].isna()])

df.to_csv("car_informationFinal2.csv", index=False)