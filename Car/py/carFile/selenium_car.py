import subprocess
import time
from selenium import webdriver
from selenium.webdriver.chrome.options import Options
from webdriver_manager.chrome import ChromeDriverManager
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pandas as pd

option = Options()
option.add_experimental_option("detach", True)

# 드라이버 실행
driver = webdriver.Chrome(service=Service(), options=option)
driver.get("https://naver.com")

namelist = []
car_typelist = []
yearlist = []
imagelist = []
pricelist = []

# csv 데이터 불러오기
data = pd.read_csv("./carFile/carname.csv")
print(data)

count = 50  # 저장 주기 체크용 카운터

# csv 값 하나씩 꺼내서 검색하며 데이터 수집
for search in data["title"]:
    # 검색
    search_url = driver.find_element(By.NAME, "query")
    search_url.clear()
    browser = search_url.send_keys(search)
    search_url.send_keys(Keys.RETURN)

    time.sleep(2)

    try:
        car_container = driver.find_element(By.XPATH, "//div[@data-dss-logarea='x58']")
        print(car_container.get_attribute("innerHTML")[:100])
        print(search)

        sub_title = car_container.find_element(By.CLASS_NAME, "sub_title")

        # 차량 타입
        car_type = sub_title.find_elements(By.CSS_SELECTOR, "span")[0].text
        print(car_type)

        # 차량 연식
        year = sub_title.find_elements(By.CSS_SELECTOR, "span")[2].text
        print(year)

        # 차량 이미지
        #인덱스 5번의 이미지 없을 시 인덱스 0번의 이미지 출력 그마저도 없을 시 빈문자
        try:
            view_image = car_container.find_element(By.CLASS_NAME, "img_area")
            image = view_image.find_elements(By.CSS_SELECTOR, "img")[5]
            src = image.get_attribute("src")
            print(src)
        except:
            try:
                view_image = car_container.find_element(By.CLASS_NAME, "img_area")
                image = view_image.find_elements(By.CSS_SELECTOR, "img")[0]
                src = image.get_attribute("src")
                print(src)
            except:
                src = ""

        # 차량 가격
        #차량 가격 없을 시 "가격정보 없음" 출력
        try:
            price_information = car_container.find_element(By.CLASS_NAME, "info_group")
            price = price_information.find_element(By.CSS_SELECTOR, "dd").text
            print(price)
        except:
            price = "가격정보 없음"

        namelist.append(search)
        car_typelist.append(car_type)
        yearlist.append(year)
        imagelist.append(src)
        pricelist.append(price)

        count += 1

        # 5개마다 중간 저장
        if count % 5 == 0:
            temp_data = {
                "name": namelist,
                "car_type": car_typelist,
                "year": yearlist,
                "image": imagelist,
                "price": pricelist
            }
            temp_df = pd.DataFrame(temp_data)
            temp_df.to_csv("car_information_partial.csv", encoding="utf-8-sig", index=False)
            print(f"{count}개 저장 완료 (중간 저장)")

    except Exception as e:
        print(f"오류 발생: {e}")
        continue

# 마지막 전체 저장
driver.close()
final_data = {
    "name": namelist,
    "car_type": car_typelist,
    "year": yearlist,
    "image": imagelist,
    "price": pricelist
}
df = pd.DataFrame(final_data)
df.to_csv("car_informationFinal.csv", encoding="utf-8-sig", index=False)
print("최종 저장 완료")
