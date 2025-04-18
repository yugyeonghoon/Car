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

#드라이버 실행
driver = webdriver.Chrome(service=Service(), options=option)
driver.get("https://naver.com")

namelist = []
car_typelist = []
yearlist = []
imagelist = []
pricelist = []

#csv 데이터 불러오기
data = pd.read_csv("./carFile/carname.csv")

print(data)
"""
현대 그랜저
현대 그랜저 하이브리드
현대 더 뉴 그랜저 IG
"""

#csv 값 하나씩 꺼내서 검색하며 데이터 수집
for search in data["name"]:
    #검색
    search_url = driver.find_element(By.NAME, "query")
    search_url.clear()
    browser = search_url.send_keys(search)
    search_url.send_keys(Keys.RETURN)

    time.sleep(2)

    try:
        car_container = driver.find_element(By.XPATH, "//div[@data-dss-logarea='x58']")
        print(car_container.get_attribute("innerHTML")[:100])
        #name = car_container.find_element(By.CLASS_NAME, "area_text_title").text
        print(search)

        sub_title = car_container.find_element(By.CLASS_NAME, "sub_title")

        #차량 타입
        car_type = sub_title.find_elements(By.CSS_SELECTOR, "span")[0].text
        print(car_type)

        #차량 연식
        year = sub_title.find_elements(By.CSS_SELECTOR, "span")[2].text
        print(year)

        #차량 이미지
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
                src= ""
        
        price_information = car_container.find_element(By.CLASS_NAME, "info_group")
        
        #차량 가격
        price = price_information.find_element(By.CSS_SELECTOR, "dd").text
        print(price)

        namelist.append(search)
        car_typelist.append(car_type)
        yearlist.append(year)
        imagelist.append(src)
        pricelist.append(price)
    except:
        continue
    
driver.close()


data = {"name" : namelist, "car_type" : car_typelist, "year" : yearlist, "image" : imagelist, "price" : pricelist}
df = pd.DataFrame(data)
df.to_csv("car_information.csv", encoding="utf-8-sig")
