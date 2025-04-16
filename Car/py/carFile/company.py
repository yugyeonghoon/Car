from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd
import time

# 크롬 팝업 차단 옵션 추가
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
time.sleep(5)  # 페이지 로딩 시간 늘리기

# 팝업 창 감지 후 닫기
main_window = driver.current_window_handle
all_windows = driver.window_handles

for window in all_windows:
    if window != main_window:
        driver.switch_to.window(window)
        print(f"[INFO] 팝업 창 닫는 중: {driver.title}")
        driver.close()

driver.switch_to.window(main_window)

# 제조사 클릭 (예: 첫 번째 제조사 클릭)
try:
    # 제조사 요소 대기 후 클릭
    company_element = WebDriverWait(driver, 10).until(
        EC.element_to_be_clickable((By.XPATH, '//*[@id="manufact"]/a'))
    )
    company_element.click()
    print("[INFO] 제조사 클릭 성공")


except Exception as e:
    print(f"[ERROR] 제조사 클릭 또는 하위 셀렉터 로딩 실패: {e}")

try:
    WebDriverWait(driver, 3).until(
        EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#manufactListText ul li a'))
    )
    print("[INFO] 제조사 목록 로딩 완료")

    # 제조사 목록 수집
    company_elements = driver.find_elements(By.CSS_SELECTOR, '#manufactListText ul li a')
    company_names = []

    for elem in company_elements:
        name = elem.text.strip()
        if name:
            company_names.append(name)
            print(f"[INFO] 제조사: {name}")

    # CSV 저장
    df = pd.DataFrame({'manufacturer': company_names})
    df.to_csv("./carFile/company_list.csv", index=False, encoding='utf-8-sig')
    print("[INFO] CSV 저장 완료")

except Exception as e:
    print(f"[ERROR] 제조사 목록 수집 실패: {e}")