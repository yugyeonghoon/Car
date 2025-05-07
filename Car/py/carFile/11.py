from google import genai
import pandas as pd
import time
import os
import csv
from dotenv import load_dotenv
# 데이터 로드

car = pd.read_csv("./carCSV/car_reviews_grouped.csv")
fail_list = pd.read_csv("./fail_list.csv")
# Gemini 클라이언트 생성

# .env 파일 로드
load_dotenv()

api_key=os.getenv("API_KEY")

if not api_key:
    raise ValueError("API_KEY를 .env에서 불러올 수 없습니다. 변수명을 다시 확인하세요.")


client = genai.Client(api_key=api_key)

# 결과 CSV 파일 경로
output_file = "./carCSV/car_feedback.csv"


# 첫 실행 시 헤더 작성
if not os.path.exists(output_file):
    pd.DataFrame(columns=["car_title", "장점", "단점", "개선점"]).to_csv(output_file, index=False, encoding="utf-8-sig")

# Gemini 응답 파싱 함수
def parse_sections(text):
    sections = {'장점': '', '단점': '', '개선점': ''}
    for line in text.splitlines():
        if line.startswith("장점:"):
            sections['장점'] = line.replace("장점:", "").strip()
        elif line.startswith("단점:"):
            sections['단점'] = line.replace("단점:", "").strip()
        elif line.startswith("개선점:"):
            sections['개선점'] = line.replace("개선점:", "").strip()
    return sections

def clean_quotes(text):
    # 문장 내 쌍따옴표 제거 후 다시 감싸기
    sentences = [s.strip('"').strip() for s in text.split('"') if s.strip()]
    return ' '.join(f'"{s}"' for s in sentences)

fail_pd = pd.DataFrame([])

for _, row in fail_list.iterrows():
    idx = int(row["idx"]) - 1  # CSV에는 +1된 인덱스가 저장되어 있으므로 다시 -1
    try:
        car_title = car.loc[idx, 'car_name']
        car_reply = car.loc[idx, 'reply']

        search_text = f"""
        {car_title}에 대한 리뷰를 기반으로 차량의 장점, 단점, 개선점을 아래 형식으로 정리해줘.

        각 항목은 예의 있고 부드러운 문장으로 작성해줘.  
        모든 항목은 아래 형식을 따라주고 문장내의 ',' 쉼표는 넣지말아줘, 줄바꿈 없이 각 문장은 큰따옴표로 감싸고 공백으로 구분해주고, 각 항목별로 10개씩만 해줘.
        단 단어의 마무리는 ~입니다 혹은 ~ 합니다 형식으로 작성해줘

        형식:
        장점: "문장1" "문장2" ...
        단점: "문장1" "문장2" ...
        개선점: "문장1" "문장2" ...

        아래는 해당 차량의 리뷰야:
        {car_reply}
        """

        response = client.models.generate_content(
            model="gemini-2.0-flash",
            contents=search_text
        )

        parsed = parse_sections(response.text)

        result_row = pd.DataFrame([{
            'car_title': car_title,
            '장점': clean_quotes(parsed['장점']),
            '단점': clean_quotes(parsed['단점']),
            '개선점': clean_quotes(parsed['개선점'])
        }])

        result_row.to_csv(
            output_file,
            mode='a',
            header=False,
            index=False,
            encoding="utf-8-sig",
            quotechar="'",
            quoting=csv.QUOTE_MINIMAL
        )

        print(f"🔁 재시도 성공: [{idx+1}] {car_title}")
        time.sleep(2)

    except Exception as e:
        print(f"⛔ 재시도 실패: [{idx+1}] {car_title} - {e}")


# # 차량 반복 처리 (한 건씩 저장)
# for idx, row in car.iterrows():
#     car_title = row['car_name']
#     car_reply = row['reply']
    
#     search_text = f"""
#     {car_title}에 대한 리뷰를 기반으로 차량의 장점, 단점, 개선점을 아래 형식으로 정리해줘.

#     각 항목은 예의 있고 부드러운 문장으로 작성해줘.  
#     모든 항목은 아래 형식을 따라주고 문장내의 ',' 쉼표는 넣지말아줘, 줄바꿈 없이 각 문장은 큰따옴표로 감싸고 공백으로 구분해주고, 각 항목별로 10개씩만 해줘.
#     단 단어의 마무리는 ~입니다 혹은 ~ 합니다 형식으로 작성해줘

#     형식:
#     장점: "문장1" "문장2" ...
#     단점: "문장1" "문장2" ...
#     개선점: "문장1" "문장2" ...

#     아래는 해당 차량의 리뷰야:
#     {car_reply}
#     """

#     try:
#         response = client.models.generate_content(
#             model="gemini-2.0-flash",
#             contents=search_text
#         )

#         parsed = parse_sections(response.text)

#         # 바로 파일에 append 저장
#         result_row = pd.DataFrame([{
#             'car_title': car_title,
#             '장점': clean_quotes(parsed['장점']),
#             '단점': clean_quotes(parsed['단점']),
#             '개선점': clean_quotes(parsed['개선점'])
#         }])

#         result_row.to_csv(
#             output_file,
#             mode='a',
#             header=False,
#             index=False,
#             encoding="utf-8-sig",
#             quotechar="'",  # 쌍따옴표 중복 방지
#             quoting=csv.QUOTE_MINIMAL
#         )
#         print(f"✅ [{idx+1}/{len(car)}] 저장 완료: {car_title}")
#         time.sleep(2)

#     except Exception as e:
#         fail_pd = pd.DataFrame([{
#             "idx" : idx+1,
#             'car_title': car_title
#         }])
#         fail_pd.to_csv("./fail_list.csv",mode='a', header=False, index=False)
#         print(f"❌ [{idx+1}/{len(car)}] 오류 발생: {car_title} - {e}")

