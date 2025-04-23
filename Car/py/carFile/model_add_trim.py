import pandas as pd

# 1. model.csv 불러오기 (mno, no, title)
model_df = pd.read_csv("./carFile/carmodel.csv")  # mno, no, title


# 2. 세부 모델 csv 불러오기
detail_df = pd.read_csv("./carFile/carsebu.csv")  # carName, trim, engine...

#3. 두 모델 합치기
merged_df = pd.merge(detail_df, model_df[["mno", "title"]], left_on="carName", right_on="title", how="left")

# 3. title은 필요 없으니 제거
merged_df.drop(columns=["title"], inplace=True)

# 4. 결과 확인
print(merged_df.head())

# 5. mno를 맨 앞으로 이동
cols = ["mno"] + [col for col in merged_df.columns if col != "mno"]
merged_df = merged_df[cols]

# 6. 결과 저장
merged_df.to_csv("./carFile/car_details1.csv", index=False, encoding="utf-8-sig")

# 7. 확인 (추가된 mno 컬럼 확인)
print(merged_df.head())






