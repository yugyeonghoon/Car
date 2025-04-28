import pandas as pd
import json

# 데이터 로드
df = pd.read_csv("preprocessing_reply_test.csv")
df = df.head(56000)  # 상위 10개 데이터만 처리

# 감성 사전 로드
with open("./carFile/SentiWord_info.json", "r", encoding="utf-8") as f:
    senti_raw = json.load(f)

# 감성 사전 정리
if isinstance(senti_raw, list):
    senti_dict = {item['word']: int(item['polarity']) for item in senti_raw}
else:
    senti_dict = {k: int(v) for k, v in senti_raw.items()}

def sentiment(text):
    if not isinstance(text, str):
        return 0

    words = text.split()
    has_positive = False
    has_negative = False
    for word in words:
        if word in senti_dict:
            if senti_dict[word] > 0:
                has_positive = True
            elif senti_dict[word] < 0:
                has_negative = True

    if has_negative:
        return 0
    elif has_positive:
        return 1
    else:
        return 0

# 감성 분석 적용
df['sentiment'] = df['filtered'].apply(sentiment)

# 최종 출력 및 저장
print(df[['car_title', 'filtered', 'sentiment']])
df[['car_title', 'filtered', 'sentiment']].to_csv("owner_analyze_test.csv", index=False)
