import pandas as pd
import re
# 자동차 스펙 데이터
df = pd.read_csv("./carFile/car_spec_result.csv")

 # 자동차 이름 데이터
fd =pd.read_csv("./carFile/carname.csv")

# 사용할 자동차 컬럼리스트
target_columns = ["title", "trim", "engine", "compressor", "exhaust", "gas", "output", "torque", "fuel", "lengthWidth", "weight", "shift"]

# 빈값 자료없음 채워넣기
df[target_columns] = df[target_columns].fillna("자료없음")

# 빈값 자료없음 채우기
df[target_columns] = df[target_columns].applymap(lambda x: "자료없음" if isinstance(x, str) and x.strip() == "" else x)

#중복된 title 값 지우기 (title 컬럼에서 첫 번째 단어를 제외한 나머지 단어들을 합쳐서 새로운 값으로 업데이트)
df["title"] = df["title"].apply(lambda x: ' '.join(x.split()[1:]) if isinstance(x, str) and len(x.split()) > 1 else x)
print(df.isnull().sum())


fd["title"] = fd["title"].apply(lambda x: ' '.join(x.split()[1:]) if isinstance(x, str) and len(x.split()) > 1 else x)

#저장
fd.to_csv("./carFile/carname.csv", index=False)
df.to_csv("./carFile/car_spec_result2.csv", index=False)