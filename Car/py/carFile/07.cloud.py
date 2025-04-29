import pandas as pd
import re
from konlpy.tag import Okt
from collections import Counter
from wordcloud import WordCloud
import matplotlib.pyplot as plt

df = pd.read_csv("./trim_analyze_test.csv")

text_data = " ".join(str(t) for t in df["reply"].dropna())

text_data = re.sub(r"[^가-힣\s]", "", text_data)
#가-힣rhk, 빈문자를 제외한(^) 텍스트를 빈문자로 치환한다.

text_data = text_data.replace("\n", "")
#줄바꿈 제거

#명사 추출
okt = Okt()
nouns = okt.nouns(text_data)
print(nouns)

#불용어
stopwords = ['이', '있', '하', '것', '들', '그', '되', '수', 
             '이', '보', '않', '없', '나', '사람', '주', '아니', 
             '등', '같', '우리', '때', '년', '가', '한', '지', 
             '대하', '오', '말', '일', '그렇', '위하', '월', '번']

#nouns에서 불용어 제거
use_nouns = []
for noun in nouns :
  if noun not in stopwords :
    #명사 리스트 데이터에서 불용어 리스트에 포함되어있지 않은 텍스트만 별도로 저장
    use_nouns.append(noun)
print(use_nouns)

#불용어를 제거한 명사에서 단어 출현 빈도 계산
#애플 : 10?, 네이버 : 20
word_counts = Counter(use_nouns)
#print(word_counts)

#출현빈도 상위 100개 단어만 추출
most_common_words = word_counts.most_common(100)
#print(most_common_words)

#출현빈도 상위 100개 단어를 이용해서 워드클라우드 생성
#pip install wordcloud

wordcloud = WordCloud(
  font_path="malgun.ttf",
  background_color="white",
  width=800,
  height=600
).generate_from_frequencies(dict(most_common_words))

#워드클라우드 시각화
plt.figure(figsize=(10, 8))
plt.imshow(wordcloud, interpolation='bilinear')
plt.axis('off')
plt.tight_layout()
plt.show()