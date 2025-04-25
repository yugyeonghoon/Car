import pandas as pd
import re
from konlpy.tag import Okt

df = pd.read_csv("./carFile/car_owner_reply_final.csv")

def clean_text(text):
    return re.sub(r'[^가-힣\s]', '', str(text))

def tokenize_and_filter(text, okt, stopwords):
    tokens = okt.morphs(text, stem=True)
    filtered = [word for word in tokens if word not in stopwords]
    return ' '.join(filtered)

okt = Okt()
stopwords = ['이', '가', '은', '는', '들', '의', '을', '를', '에', '과', '와', '한', '하다']

df['cleaned_reply'] = df['reply'].apply(clean_text)
df['filtered'] = df['cleaned_reply'].apply(lambda x: tokenize_and_filter(x, okt, stopwords))

df.to_csv("preprocessed_reply.csv", index=False)
print(df[['reply', 'filtered']].head())
