from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import pandas as pd
import time

# 크롬 설정
options = Options()
options.add_experimental_option("detach", True)
prefs = {
    "profile.default_content_setting_values.notifications": 2,
    "profile.default_content_setting_values.popups": 2
}
options.add_experimental_option("prefs", prefs)

driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
driver.get("http://www.encar.com/index.do")
time.sleep(5)

# 팝업 창 닫기
main_window = driver.current_window_handle
for window in driver.window_handles:
    if window != main_window:
        driver.switch_to.window(window)
        driver.close()
driver.switch_to.window(main_window)

# 제조사 버튼 클릭
WebDriverWait(driver, 3).until(
    EC.element_to_be_clickable((By.XPATH, '//*[@id="manufact"]/a'))
).click()

# 제조사 목록 로딩
WebDriverWait(driver, 3).until(
    EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#manufactListText ul li a'))
)

company_elements = driver.find_elements(By.CSS_SELECTOR, '#manufactListText ul li a')

result = []

# 제조사 개수 가져오기
num_companies = len(driver.find_elements(By.CSS_SELECTOR, '#manufactListText ul li a'))
print(f"총 제조사 수: {num_companies}")

for idx in range(num_companies):
    manufacturer_name = ""  # 예외 대비 초기화
    try:
        # 제조사 버튼 다시 클릭 (항상 열려 있도록)
        WebDriverWait(driver, 5).until(
            EC.element_to_be_clickable((By.XPATH, '//*[@id="manufact"]/a'))
        ).click()

        # 제조사 목록 다시 로딩
        WebDriverWait(driver, 5).until(
            EC.presence_of_all_elements_located((By.CSS_SELECTOR, '#manufactListText ul li a'))
        )
        company_elements = driver.find_elements(By.CSS_SELECTOR, '#manufactListText ul li a')

        if idx >= len(company_elements):
            print(f"idx {idx} 범위 초과")
            continue

        company = company_elements[idx]
        manufacturer_name = company.text.strip()

        if not manufacturer_name:
            continue

        print(f"제조사 클릭: {manufacturer_name}")
        driver.execute_script("arguments[0].click();", company)
        time.sleep(1)

        # 모델 목록 대기
        WebDriverWait(driver, 5).until(
            EC.presence_of_all_elements_located((By.XPATH, '//*[@id="seriesItemList"]/li/a'))
        )

        model_elements = driver.find_elements(By.XPATH, '//*[@id="seriesItemList"]/li/a')

        model_info_list = [(i, el.text.strip()) for i, el in enumerate(model_elements[1:], start=1)]  # [1:] 첫번째는 "전체"니까 제외

        for model_index, model_name in model_info_list:
            try:

                driver.find_element(By.CSS_SELECTOR, "#series > a").click()
                time.sleep(1)
                # ✅ 인기순 버튼 클릭 (항상 모델 클릭 이후에!)
                try:
                    # popular_sort_btn = WebDriverWait(driver, 3).until(
                    #     EC.element_to_be_clickable((By.XPATH, '//*[@id="seriesList"]/ul/li[1]/button'))
                    # )
                    popular_sort_btn = driver.find_element(By.XPATH, '//*[@id="seriesList"]/ul/li[1]/button')
                    popular_sort_btn.click()
                    time.sleep(1)
                except Exception as e:
                    print(f"[인기순 버튼 클릭 실패: {e}")
                
                # 모델 목록 다시 로딩 (매 루프마다 새로)
                WebDriverWait(driver, 5).until(
                    EC.presence_of_all_elements_located((By.XPATH, '//*[@id="seriesItemList"]/li/a'))
                )
                model_elements = driver.find_elements(By.XPATH, '//*[@id="seriesItemList"]/li/a')
                model_element = model_elements[model_index]

                print(f"모델 클릭: {model_name}")
                driver.execute_script("arguments[0].click();", model_element)
                time.sleep(1)

                # 세부모델 로딩
                WebDriverWait(driver, 5).until(
                    EC.presence_of_all_elements_located((By.XPATH, '//*[@id="mdlItemList"]/li/a'))
                )
                sebumodel_elements = driver.find_elements(By.XPATH, '//*[@id="mdlItemList"]/li/a')

                for sebumodel in sebumodel_elements[1:]:
                    sebumodel_name = sebumodel.text.strip()
                    if sebumodel_name:
                        print(f"세부모델명 : {sebumodel_name}")
                        result.append({
                            "manufacturer": manufacturer_name,
                            "model": model_name,
                            "sebumodel": sebumodel_name
                        })

            except Exception as e:
                print(f"모델 '{model_name}' 세부모델 수집 실패: {e}")
                continue

    except Exception as e:
        print(f"{manufacturer_name if manufacturer_name else '알 수 없음'} 모델 수집 실패: {e}")
        continue  # 다음 제조사로 넘어가기

# 저장
df = pd.DataFrame(result)
df.to_csv("./carFile/carname_submodel_list.csv", index=False, encoding='utf-8-sig')
print("수집 완료 및 CSV 저장 완료")
