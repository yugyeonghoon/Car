import pandas as pd

df = pd.read_csv("./carFile/car_spec_result.csv")


target_columns = ["title", "trim", "engine", "compressor", "exhaust", "gas", "output", "torque", "fuel", "lengthWidth", "weight", "shift"]
df[target_columns] = df[target_columns].fillna("자료없음")
df[target_columns] = df[target_columns].applymap(lambda x: "자료없음" if isinstance(x, str) and x.strip() == "" else x)
print(df.isnull().sum())

df.to_csv("./carFile/car_spec_result1.csv", index=False)