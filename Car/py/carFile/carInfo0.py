import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import time
import os
import re

csv_path = "./carFile/car_spec_result.csv"
write_header = not os.path.exists(csv_path)

df = pd.read_csv("./carFile/carname.csv")
df["title"] = df["title"].str.strip()
title_list = df["title"].tolist()
print(title_list)

for col in ["trim", "gas", "compressor", "weight", "fuel", "output", "torque", "exhaust", "engine[i]", "shift", "height", "lengthWidth"]:
    if col not in df.columns:
        df[col] = ""

engine_content = ["엔진형식", "과급방식", "배기량", "연료", "최고출력", "최대토크"]





# 크롬 설정
options = Options()
options.add_experimental_option("detach", True)
prefs = {
    "profile.default_content_setting_values.notifications": 2,
    "profile.default_content_setting_values.popups": 2
}
options.add_experimental_option("prefs", prefs)

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
result = []
fail_list = []

for title in title_list[24:] :
    url = f"https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={title + ' 제원'}"
    driver.get(url)
    time.sleep(2)

    trims = driver.find_elements(By.CSS_SELECTOR, ".cm_tap_area .tab_list > li > a > span")

    panel = driver.find_elements(By.XPATH, '//div[@data-kgs-tab-panel]')

    
    for i, trim in enumerate(panel):
        trimTitle = trims[i].text

        print(f"\n[{i+1}번째 트림]")

        try:
            cm_table = trim.find_elements(By.CSS_SELECTOR, "div.cm_table_area")
            engine = cm_table[0]
            engine_data = [a.text for a in cm_table[0].find_elements(By.CSS_SELECTOR, "tbody > tr > th")]
            engine_data = [
                re.sub(r'\n.*', '', a.text).strip()  # '\n' 이후의 내용 제거하고 양쪽 공백 제거
                for a in cm_table[0].find_elements(By.CSS_SELECTOR, "tbody > tr > th")
            ]

            print(engine_data)
            ['엔진형식', '과급방식', '배기량', '연료', '최고출력']

            engin_type = ""
            compressor = ""
            exhaust = ""
            gas = ""
            output = ""
            torque = ""
            for data in engine_data:
                if data == '엔진형식':
                    try :
                        engin_type = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td > a").text
                        print(engin_type)
                    except :
                        engin_type = " " 
                elif data == '배기량':
                    try :
                        compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
                        print(compressor)
                    except :
                        compressor = " "
                elif data == '연료':
                    try :
                        compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
                        print(compressor)
                    except :
                        compressor = " "
                elif data == '최고출력':
                    try :
                        compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
                        print(compressor)
                    except :
                        compressor = " "
                elif data == '최대토크':
                    try :
                        compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
                        print(compressor)
                    except :
                        compressor = " "
                elif data == '과급방식':
                    try :
                        compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
                        print(compressor)
                    except :
                        compressor = " "
        except Exception as e:

            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue
            
        try :
            engin_type = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td > a").text
            print(engin_type)
        except :
            engin_type = " " 
        try :
            compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
            print(compressor)
        except :
            compressor = " "
        try :
            exhaust = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(3) > td").get_attribute("innerHTML")
            print(exhaust)
        except :
            exhaust = " "
        try :
            gas = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(4) > td > a").text
            print(gas)
        except :
            gas = " "
        try :
            output = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(5) > td").get_attribute("innerHTML")
            print(output)
        except :
            output = " "
        try :
            torque = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(6) > td").get_attribute("innerHTML")
            print(f" 토크 = {torque} ")
        except :
            torque = " "
        
        try:
            perform = cm_table[1]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue

        try :
            fuel = perform.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td ").get_attribute("innerHTML")
            print(f"연비{fuel}")
        except :
            fuel = " "

        try:
            size = cm_table[2]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue
        
        try :
            length = size.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td ").get_attribute("innerHTML")
            print(f"전장/전폭{length}")
        except :
            length = " "
        
        try :
            weight = size.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(4) > td ").get_attribute("innerHTML")
            print(f"무게 {weight}")
        except :
            weight = " "

        try:
            shiftinfo = cm_table[3]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue

        try :
            shift = shiftinfo.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
            print(f"변속 {shift}")
        except :
            shift = " "
            
        row_df = pd.DataFrame([{
        "title": title,
        "trim": trimTitle,
        "engine": engin_type,
        "compressor": compressor,
        "exhaust": exhaust,
        "gas": gas,
        "output": output,
        "torque": torque,
        "fuel": fuel,
        "lengthWidth": length,
        "weight": weight,
        "shift": shift
        }])

        # CSV에 바로 추가 (헤더는 처음 한 번만)
        row_df.to_csv(csv_path, mode='a', header=write_header, index=False, encoding='utf-8-sig')
        write_header = False  # 다음부터는 헤더 없이 append



# result_df = pd.DataFrame(result)
# result_df.to_csv("./carFile/car_spec_result.csv",mode='a', index=False,)
result_fail = pd.DataFrame(fail_list)
result_fail.to_csv("./carFile/car_spec_failresult.csv", index=False,)
print("제원 완료")
        # df["trim"] = trim
        # df["engine[i]"] = engin_type
        # df["compressor"] = compressor
        # df["exhaust"] = exhaust
        # df["gas"] = gas
        # df["output"] = output
        # df["torque"] = torque
        # df["fuel"] = fuel
        # df["lengthWidth"] = length
        # df["weight"] = weight
        # df["shift"] = shift

    # try:
    #     tirm = driver.find_element(By.XPATH, '//*[@id="main_pack"]/div[3]/div[2]/div/div/div[1]/div/div/ul/li')

    # except Exception as e:
    #     print(f"{title}제원이 없습니다")
    #     continue
    
