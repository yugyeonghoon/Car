import pandas as pd

# 1. model.csv 불러오기 (mno, no, title)
model_df = pd.read_csv("./carFile/merged_company_car.csv")  # mno, no, title
model_df = model_df[["no", "mno", "title"]]

df = model_df.drop_duplicates(subset="title", keep="first").reset_index(drop=True)

# 3. mno 재정렬 (1부터 시작)
df["mno"] = range(1, len(df) + 1)

# 4. 확인
print(df)

df.to_csv("./carFile/carmodel2.csv", index=False)

# 중복제거
df_cleaned = model_df.drop_duplicates()
df_cleaned = model_df[["no", "mno", "title"]]
df_cleaned.to_csv("./carFile/carmodel.csv", index=False)

# 2. 세부 모델 csv 불러오기
detail_df = pd.read_csv("./carFile/car_merged_result.csv")  # carName, trim, engine...

#중복제거
detail_df_clean = detail_df.drop_duplicates()
detail_df_clean = detail_df[["carName","trim","engine","compressor","exhaust","gas","output","torque","fuel","lengthWidth","weight","shift","carType","year","image","price"]]
detail_df_clean.to_csv("./carFile/carsebu.csv", index=False)