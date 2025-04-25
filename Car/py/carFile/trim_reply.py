import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
from urllib.parse import quote_plus
import time
import os

# Chrome 설정
option = Options()
option.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=option)

# 자동차 모델 리스트 불러오기
df = pd.read_csv("./carCSV/carmodel.csv")
all_reviews = []

for i, t in enumerate(df["title"][:5]):
    query = f"{t} 오너평가"
    print(f"모델 검색: {query}")
    driver.get(f"https://search.naver.com/search.naver?query={quote_plus(query)}")
    time.sleep(2)

    try:
        # 트림 탭 찾기
        trim_elements = driver.find_elements(By.CSS_SELECTOR, ".tab_list._tab_list li")

        if not trim_elements:
            trim_elements = [None]  # 트림이 없는 경우도 루프에 포함시킴

        for trim_index, trim_element in enumerate(trim_elements):
            if trim_element:
                trim_name = trim_element.text.strip()
                print(f" ▶ 트림 선택: {trim_name}")
                try:
                    driver.execute_script("arguments[0].click();", trim_element)
                    time.sleep(2)
                except:
                    print(f"트림 클릭 실패: {trim_name}")
                    continue
            else:
                trim_name = ""  # 트림 없는 경우

            # 스크롤: 리뷰 더 보기 위해 아래로 내리기
            try:
                scrollable_div = driver.find_element(By.XPATH, "//*[@class='sc_new cs_common_module case_normal color_5 _cs_car_single']/div[2]/div/div/div[5]")
                for _ in range(3):
                    driver.execute_script("arguments[0].scrollTop = arguments[0].scrollHeight", scrollable_div)
                    time.sleep(2)
            except:
                print(f"스크롤 영역 없음: {t} / 트림: {trim_name}")

            # 리뷰 수집 (최대 20개)
            for review_index in range(1, 21):
                try:
                    base_xpath = f'//*[@id="cbox_module_wai_u_cbox_content_wrap_tabpanel"]/ul/li[{review_index}]'

                    dri = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[1]/span[2]')
                    pri = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[2]/span[2]')
                    hab = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[3]/span[2]')
                    qua = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[4]/span[2]')
                    des = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[5]/span[2]')
                    fuel = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[6]/span[2]')

                    # BEST 있는 댓글 대응 (span[2]가 없을 수도 있음)
                    try:
                        reply = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[3]/span[2]')
                    except:
                        reply = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[3]/span[1]')

                    review_data = {
                        "car_title": t,
                        "trim": trim_name,
                        "drive": dri.text.strip(),
                        "price": pri.text.strip(),
                        "habitability": hab.text.strip(),
                        "quality": qua.text.strip(),
                        "design": des.text.strip(),
                        "fuel": fuel.text.strip(),
                        "reply": reply.text.strip()
                    }
                    all_reviews.append(review_data)

                    print(f"{t} | {trim_name} | 리뷰 {review_index} 수집됨")

                    if len(all_reviews) % 50 == 0:
                        pd.DataFrame(all_reviews).to_csv("trim_test_partial.csv", index=False)

                    time.sleep(1.5)

                except Exception as e:
                    print(f"[리뷰 {review_index} 오류] {e}")
                    continue

    except Exception as e:
        print(f"[모델 오류] {t}: {e}")
        continue

# 최종 저장
pd.DataFrame(all_reviews).to_csv("trim_test.csv", index=False, encoding="utf-8-sig")
print("전체 수집 끝")
