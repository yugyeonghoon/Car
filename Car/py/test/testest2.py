import pandas as pd
import re
from collections import Counter
from wordcloud import WordCloud
import matplotlib.pyplot as plt
import os

# CSV 불러오기
df = pd.read_csv("./carCSV/owner_analyze_okt.csv")

# 저장 폴더 생성
os.makedirs("wordclouds", exist_ok=True)

# 감정별(0: 부정, 1: 긍정) 처리
for sentiment in [0, 1]:
    filtered_df = df[df["sentiment"] == sentiment]

    if filtered_df.empty:
        continue

    # 텍스트 합치기
    combined_text = " ".join(str(t) for t in filtered_df["filtered"].dropna())
    combined_text = re.sub(r"[^가-힣\s]", "", combined_text)
    combined_text = combined_text.replace("\n", "")

    # 단어 리스트로 나누기 (공백 기준)
    words = combined_text.split()
    word_counts = Counter(words)
    most_common_words = word_counts.most_common(100)

    # 워드클라우드 생성
    wordcloud = WordCloud(
        font_path="malgun.ttf",
        background_color="white",
        width=800,
        height=600
    ).generate_from_frequencies(dict(most_common_words))

    sentiment_label = "긍정" if sentiment == 1 else "부정"

    # 시각화
    plt.figure(figsize=(10, 8))
    plt.imshow(wordcloud, interpolation='bilinear')
    plt.axis('off')
    plt.title(f"전체 {sentiment_label} 워드클라우드", fontsize=16)
    plt.tight_layout()
    # plt.show()

    # 저장
    wordcloud.to_file(f"wordclouds/전체_{sentiment_label}_워드클라우드.png")
