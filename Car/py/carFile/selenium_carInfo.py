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

# CSV 파일 경로 설정
csv_path = "./carFile/car_spec_result.csv"
write_header = not os.path.exists(csv_path)

# carname.csv 파일에서 데이터 읽기
df = pd.read_csv("./carFile/carname.csv")
df["title"] = df["title"].str.strip()
title_list = df["title"].tolist()
print(title_list)

# 필요한 컬럼이 없으면 추가
for col in ["trim", "gas", "compressor", "weight", "fuel", "output", "torque", "exhaust", "engine[i]", "shift", "height", "lengthWidth"]:
    if col not in df.columns:
        df[col] = ""

# 크롬 설정
options = Options()
options.add_experimental_option("detach", True)
prefs = {
    "profile.default_content_setting_values.notifications": 2,
    "profile.default_content_setting_values.popups": 2
}
options.add_experimental_option("prefs", prefs)

# 크롬 드라이버 시작
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

result = []
fail_list = []

for title in title_list:
    url = f"https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={title + ' 제원'}"
    driver.get(url)
    time.sleep(2)

    trims = driver.find_elements(By.CSS_SELECTOR, ".cm_tap_area .tab_list > li > a > span")
    panel = driver.find_elements(By.XPATH, '//div[@data-kgs-tab-panel]')
    
    if not trims:
            print(f" 트림 없음: {title}")

            # 트림 없이 빈 값으로 한 줄 저장
            empty_row_df = pd.DataFrame([{
                "title": title,
                "trim": "",
                "engine[i]": "",
                "compressor": "",
                "exhaust": "",
                "gas": "",
                "output": "",
                "torque": "",
                "fuel": "",
                "lengthWidth": "",
                "weight": "",
                "shift": ""
            }])
            empty_row_df.to_csv(csv_path, mode='a', header=write_header, index=False, encoding='utf-8-sig')
            write_header = False  # 다음 줄부터는 헤더 없이 저장

            continue

    for i, trim in enumerate(panel):
        trimTitle = trims[i].text
        print(f"\n[{i+1}번째 트림]")

        try:
            # 트림 클릭하여 해당 트림의 세부 정보 로딩
            driver.execute_script("arguments[0].click();", trims[i])

            # 새로운 세부 정보가 로드될 때까지 기다림
            WebDriverWait(driver, 10).until(
                EC.presence_of_element_located((By.CSS_SELECTOR, ".cm_table_area"))
            )
            time.sleep(3)  # 잠시 대기

            cm_table = trim.find_elements(By.CSS_SELECTOR, "div.cm_table_area")
            engine = cm_table[0]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue

        # 세부정보 추출
        try:
            engine_type = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td > a").text
            print(engine_type)
        except:
            engine_type = " " 

        try:
            compressor = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
            print(compressor)
        except:
            compressor = " " 

        try:
            exhaust = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(3) > td").text
            print(exhaust)
        except:
            exhaust = " " 

        try:
            gas = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(4) > td > a").text
            print(gas)
        except:
            gas = " " 

        try:
            output = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(5) > td").text
            print(output)
        except:
            output = " " 

        try:
            torque = engine.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(6) > td").text
            print(torque)
        except:
            torque = " "

        try:
            perform = cm_table[1]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue

        try:
            fuel = perform.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td").text
            print(f"연비{fuel}")
        except:
            fuel = " "

        try:
            size = cm_table[2]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue

        try:
            length = size.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(1) > td").text
            print(f"전장/전폭{length}")
        except:
            length = " "

        try:
            weight = size.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(4) > td").text
            print(f"무게 {weight}")
        except:
            weight = " "

        try:
            shiftinfo = cm_table[3]
        except Exception as e:
            print(f"{title} 제원 테이블 파싱 실패: {e}")
            continue

        try:
            shift = shiftinfo.find_element(By.CSS_SELECTOR, ".cm_table > tbody > tr:nth-child(2) > td > a").text
            print(f"변속 {shift}")
        except:
            shift = " "

        # 데이터를 DataFrame에 저장
        row_df = pd.DataFrame([{
            "title": title,
            "trim": trimTitle,
            "engine": engine_type,
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

# 실패한 데이터는 별도 파일로 저장
result_fail = pd.DataFrame(fail_list)
result_fail.to_csv("./carFile/car_spec_failresult.csv", index=False)

print("제원 완료")
