import pandas as pd

company_df = pd.read_csv("./carFile/company_list.csv")
# company_df.index = range(1, len(company_df) + 1)
# company_df.to_csv("./carFile/company_list.csv", index=True, index_label="no")

car_df = pd.read_csv("./carFile/carname.csv")
# # fd.index = range(1, len(fd) + 1)
# # fd.to_csv("./carFile/carname.csv", index=True, index_label="no")

df_cleaned = car_df.drop_duplicates()
df_cleaned.to_csv("./carFile/carname.csv")

car_df = pd.read_csv("./carFile/carname.csv")

company_df["no"] = company_df["no"].astype(int)

# 2. 자동차 모델에서 브랜드명 찾아 회사번호 매칭
def match_company_no(title, companies):
    for _, row in companies.iterrows():
        if title.startswith(row["manufacturer"]):
            return row["no"]
    return 0  # 매칭 안 되는 경우 0 처리 (또는 None)

# 3. 회사번호 매칭
car_df["company_no"] = car_df["title"].apply(lambda x: match_company_no(x, company_df))

# 4. 모델 번호(mno) = 1부터 시작하도록 수정
car_df["mno"] = range(1, len(car_df) + 1)  # mno를 1부터 시작하도록 설정

# 5. 컬럼 정리
result_df = car_df[["company_no", "mno", "title"]]
result_df = result_df.rename(columns={"company_no": "no"})

# 6. 저장 (선택)
result_df.to_csv("./carFile/merged_company_car1.csv", index=False)

# 7. 확인
print(result_df.head(10))