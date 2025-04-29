import pandas as pd
import re
from konlpy.tag import Okt
from collections import Counter
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import os

# CSV 불러오기
df = pd.read_csv("./trim_analyze_test.csv")

# 형태소 분석기 & 불용어
okt = Okt()
stopwords = ['이', '있', '하', '것', '들', '그', '되', '수', 
             '보', '않', '없', '나', '사람', '주', '아니', 
             '등', '같', '우리', '때', '년', '가', '한', '지', 
             '대하', '오', '말', '일', '그렇', '위하', '월', '번']

# 저장 폴더
os.makedirs("wordclouds", exist_ok=True)

# 차종 + 트림 기준 그룹화
for (car, trim), group in df.groupby(["car_title", "trim"], sort=False):
    for sentiment in [0, 1]:
        filtered_group = group[group["sentiment"] == sentiment]

        if filtered_group.empty:
            continue

        # 텍스트 결합
        combined_text = " ".join(str(t) for t in filtered_group["reply"].dropna())
        combined_text = re.sub(r"[^가-힣\s]", "", combined_text)
        combined_text = combined_text.replace("\n", "")

        # 명사 추출 및 정제
        nouns = okt.nouns(combined_text)
        clean_nouns = [n for n in nouns if n not in stopwords and len(n) > 1]

        # 단어 빈도수 계산
        word_counts = Counter(clean_nouns)
        most_common_words = word_counts.most_common(100)

        if not most_common_words:
            print(f"⚠️ 단어 부족: {car} / {trim} - {'긍정' if sentiment == 1 else '부정'}")
            continue

        # 워드클라우드 생성
        wordcloud = WordCloud(
            font_path="malgun.ttf",
            background_color="white",
            width=800,
            height=600
        ).generate_from_frequencies(dict(most_common_words))

        # 감정 이름
        sentiment_label = "긍정" if sentiment == 1 else "부정"

        # 시각화
        plt.figure(figsize=(10, 8))
        plt.imshow(wordcloud, interpolation='bilinear')
        plt.axis('off')
        plt.title(f"{car} / {trim} - {sentiment_label} 워드클라우드", fontsize=16)
        plt.tight_layout()

        # 파일 이름 안전하게 처리
        safe_car = re.sub(r"[\\/:*?\"<>|]", "_", car)
        safe_trim = re.sub(r"[\\/:*?\"<>|]", "_", trim)

        # 파일 저장
        filename = f"wordclouds/{safe_car}_{safe_trim}_{sentiment_label}_wordcloud.png"
        wordcloud.to_file(filename)
