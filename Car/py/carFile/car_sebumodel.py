import pandas as pd

# 차량 스펙 정보
spec_df = pd.read_csv("./carFile/car_spec_result1.csv")

# 이미지, 가격 등 부가 정보
info_df = pd.read_csv("./carFile/car_informationFinal2.csv")

# 스펙 CSV의 title에서 '현대' 같은 브랜드 제거
spec_df["title_trimmed"] = spec_df["title"].apply(
    lambda x: ' '.join(x.split()[1:]) if isinstance(x, str) and len(x.split()) > 1 else x
)

#a = 1 if False else 0

# def a(x):
#     if isinstance(x, str) and len(x.split()) > 1:
#         return ' '.join(x.split()[1:])
#     else:
#         return x



# info CSV의 name에서도 동일하게
info_df["name_trimmed"] = info_df["name"].apply(
    lambda x: ' '.join(x.split()[1:]) if isinstance(x, str) and len(x.split()) > 1 else x
)

merged_df = pd.merge(spec_df, info_df, how="left", left_on="title_trimmed", right_on="name_trimmed")

merged_df = merged_df.drop(columns=["title_trimmed", "name", "name_trimmed"])

merged_df = merged_df.fillna("자료없음")
merged_df = merged_df.applymap(lambda x: "자료없음" if isinstance(x, str) and x.strip() == "" else x)

merged_df.to_csv("car_merged_result.csv", index=False)

print(merged_df.isnull().sum())