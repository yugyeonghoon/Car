import pandas as pd

# CSV 파일을 읽어옵니다
df = pd.read_csv('./carCSV/trim_reply_1.csv')

# 'trim' 컬럼에서 "종합" 값을 가진 행을 삭제합니다
df_cleaned = df[df['trim'] != '종합']

df_cleaned = df_cleaned[df_cleaned['price'].notna()]        # NaN 제거
df_cleaned = df_cleaned[df_cleaned['price'] != '']
# 변경된 내용을 새로운 CSV 파일로 저장합니다
df_cleaned.to_csv('./carCSV/trim_reply_final.csv', index=False)

