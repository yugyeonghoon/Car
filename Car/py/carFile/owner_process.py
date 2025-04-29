import pandas as pd
import numpy as np
df = pd.read_csv("./carCSV/car_owner.csv")

df = df.drop_duplicates()

# "평점없음"을 NaN으로 변환
df['ratingPeople'] = df['ratingPeople'].replace('평점없음', np.nan)

# ratingPeople을 float → int로 변환 (NaN은 그대로 유지)
# NaN이 있을 경우, 실수 값은 반올림하거나 버림 처리 가능합니다.
df['ratingPeople'] = pd.to_numeric(df['ratingPeople'], errors='coerce')  # 실수로 변환
df['ratingPeople'] = df['ratingPeople'].round().astype('Int64')  # 반올림 후 Int64로 변환

df.to_csv("./carCSV/car_owner.csv", index=False)
