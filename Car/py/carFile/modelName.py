from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd
import time
import os

# 크롬 옵션 설정
options = Options()
options.add_experimental_option("detach", True)
prefs = {
    "profile.default_content_setting_values.notifications": 2,
    "profile.default_content_setting_values.popups": 2
}
options.add_experimental_option("prefs", prefs)

# 드라이버 실행
driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
driver.get("http://www.encar.com/index.do")
time.sleep(5)

# 팝업 닫기
main_window = driver.current_window_handle
for window in driver.window_handles:
    if window != main_window:
        driver.switch_to.window(window)
        driver.close()
driver.switch_to.window(main_window)

# 제조사 버튼 클릭
WebDriverWait(driver, 5).until(
    EC.element_to_be_clickable((By.XPATH, '//*[@id="manufact"]/a'))
).click()

# 제조사 목록 로딩
WebDriverWait(driver, 5).until(
    EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#manufactListText ul li a'))
)

result = []

# 제조사 수집 시작
company_elements = driver.find_elements(By.CSS_SELECTOR, '#manufactListText ul li a')
num_companies = len(company_elements)
print(f"[INFO] 총 제조사 수: {num_companies}")

for idx in range(num_companies):
    try:
        # 제조사 목록 새로 로드
        WebDriverWait(driver, 5).until(
            EC.element_to_be_clickable((By.XPATH, '//*[@id="manufact"]/a'))
        ).click()

        WebDriverWait(driver, 5).until(
            EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#manufactListText ul li a'))
        )
        company_elements = driver.find_elements(By.CSS_SELECTOR, '#manufactListText ul li a')

        if idx >= len(company_elements):
            print(f"[WARN] idx {idx} 범위 초과")
            continue

        company = company_elements[idx]
        manufacturer_name = company.text.strip()
        if not manufacturer_name:
            continue

        print(f"\n[INFO] 제조사 클릭: {manufacturer_name}")
        driver.execute_script("arguments[0].click();", company)
        time.sleep(1)

        # 모델 목록 대기
        WebDriverWait(driver, 5).until(
            EC.presence_of_all_elements_located((By.XPATH, '//*[@id="seriesItemList"]/li/a'))
        )

        # 모델 수집 with while 루프
        m_idx = 1  # 0번째는 "전체" 버튼
        while True:
            try:
                model_elements = driver.find_elements(By.XPATH, '//*[@id="seriesItemList"]/li/a')
                if m_idx >= len(model_elements):
                    break

                model = model_elements[m_idx]
                model_name = model.text.strip()
                if not model_name:
                    m_idx += 1
                    continue

                print(f"    [모델 클릭]: {model_name}")
                driver.execute_script("arguments[0].click();", model)

                # 페이지 로딩 기다리기
                WebDriverWait(driver, 10).until(
                    EC.presence_of_all_elements_located((By.XPATH, '//*[@id="mdlItemList"]/li/a'))
                )
                time.sleep(2)  # 추가적인 대기 시간

                # 세부모델 수집
                try:
                    sub_model_elements = driver.find_elements(By.XPATH, '//*[@id="mdlItemList"]/li/a')
                    if not sub_model_elements:  # 세부모델이 없으면 빈 리스트로 처리
                        print("        [INFO] 세부모델 없음")
                        result.append({
                            "manufacturer": manufacturer_name,
                            "model": model_name,
                            "sub_model": ""
                        })
                    else:
                        for sub_model in sub_model_elements:
                            sub_model_name = sub_model.text.strip()
                            if sub_model_name:
                                print(f"        └ 세부모델: {sub_model_name}")
                                result.append({
                                    "manufacturer": manufacturer_name,
                                    "model": model_name,
                                    "sub_model": sub_model_name
                                })
                except Exception as e:
                    print(f"        [INFO] 세부모델 수집 실패: {e}")
                    result.append({
                        "manufacturer": manufacturer_name,
                        "model": model_name,
                        "sub_model": ""
                    })

                # 모델 페이지 → 뒤로가기
                driver.execute_script("window.history.go(-1)")
                WebDriverWait(driver, 5).until(
                    EC.presence_of_all_elements_located((By.XPATH, '//*[@id="seriesItemList"]/li/a'))
                )
                m_idx += 1

            except Exception as e:
                print(f"    [ERROR] 모델 처리 중 예외 발생: {e}")
                m_idx += 1
                continue

        # 제조사 페이지 → 뒤로가기
        driver.execute_script("window.history.go(-1)")
        WebDriverWait(driver, 5).until(
            EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#manufactListText ul li a'))
        )

    except Exception as e:
        print(f"[ERROR] 제조사 수집 실패: {e}")
        continue

# 결과 저장 폴더 생성
os.makedirs('./carFile', exist_ok=True)

# CSV 저장
df = pd.DataFrame(result)
df.to_csv("./carFile/carname_submodel_list.csv", index=False, encoding='utf-8-sig')
print("수집 완료 및 CSV 저장 완료")
