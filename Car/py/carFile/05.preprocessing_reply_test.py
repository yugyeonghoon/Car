import pandas as pd
from konlpy.tag import Okt

# 데이터 불러오기
df = pd.read_csv("car_owner_reply_cleaned.csv")
df = df.head(56000) 

# 형태소 분석기와 불용어 정의
okt = Okt()
stopwords = ['이', '가', '은', '는', '들', '의', '을', '를', '에', '과', '와', 
             '한', '하다', '으로', '년', '때', '고', '서', '도', '부터', '까지', '에서', '까지는', '년',
             '별', '거', '및', '용', '있다', '로', '움', '함', '것', '면', '앞', '비', '니', '안나', '서다', '단', '호', '이다', '되다', '글자',
             '탈', '위', '너', '타'] 

def tokenize_and_filter(text):
    tokens = okt.pos(str(text), stem=True)
    result = []
    for word, tag in tokens:
        if tag in ['Noun', 'Adjective', 'Verb']:
            if word not in stopwords:
                result.append(word)
    return ' '.join(result)

# 필터링 적용
df['filtered'] = df['reply'].apply(tokenize_and_filter)

# 결과 저장 (car_title과 filtered만)
df[['car_title', 'filtered']].to_csv("preprocessing_reply_test.csv", index=False)

# 출력 확인
print(df[['reply', 'filtered']])
