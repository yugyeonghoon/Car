from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.common.keys import Keys
from urllib.parse import quote_plus
import time
import pandas as pd

option = Options()
option.add_experimental_option("detach", True) 
driver = webdriver.Chrome(options=option)

df = pd.read_csv("./carFile/carname.csv")

# if "drive" not in df.columns:
#     df["drive"] = ""

# if "price" not in df.columns:
#     df["price"] = ""

# if "habitability" not in df.columns:
#     df["habitability"] = ""

# if "quality" not in df.columns:
#     df["quality"] = ""

# if "design" not in df.columns:
#     df["design"] = ""

# if "fuel" not in df.columns:
#     df["fuel"] = ""

# if "reply" not in df.columns:
#     df["reply"] = ""

all_reviews = []

for i, t in enumerate(df["title"][1491:]):
    title = f"{t} 오너평가"

    print(f"{title}")
    driver.get(f"https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={title}")
    time.sleep(2)

    try:
        #//*[@id="main_pack"]/div[3]/div[2]/div/div/div[5]
        #//*[@id="main_pack"]/div[5]/div[2]/div/div/div[5]
        scrollable_div = driver.find_element(By.XPATH, "//*[@class='sc_new cs_common_module case_normal color_5 _cs_car_single']/div[2]/div/div/div[5]")
        height = driver.execute_script("return arguments[0].scrollHeight", scrollable_div)
        scroll_count = 0
        max_scrolls = 45

        while scroll_count < max_scrolls:
            driver.execute_script("arguments[0].scrollTop = arguments[0].scrollHeight", scrollable_div)
            time.sleep(2)
            new_height = driver.execute_script("return arguments[0].scrollHeight", scrollable_div)
            if new_height == height:
                break
            height = new_height
            scroll_count += 1
    except Exception as e:
        print(f"Error for {t}: {e}")

    #//*[@id="cbox_module_wai_u_cbox_content_wrap_tabpanel"]/ul/li[1]/div[1]/div/div[2]/div/ul/li[2]/span[2]
    #//*[@id="cbox_module_wai_u_cbox_content_wrap_tabpanel"]/ul/li[1]/div[1]/div/div[3]
    fail_count = 0

    for review_index in range(1, 401):
        try:
            base_xpath = f'//*[@id="cbox_module_wai_u_cbox_content_wrap_tabpanel"]/ul/li[{review_index}]'

            dri  = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[1]/span[2]')
            pri  = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[2]/span[2]')
            hab  = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[3]/span[2]')
            qua  = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[4]/span[2]')
            des  = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[5]/span[2]')
            fuel = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[2]/div/ul/li[6]/span[2]')
            reply = driver.find_element(By.XPATH, base_xpath + '/div[1]/div/div[3]/span')

            review_data = {
                "car_title": t,
                "drive": dri.text.strip(),
                "price": pri.text.strip(),
                "habitability": hab.text.strip(),
                "quality": qua.text.strip(),
                "design": des.text.strip(),
                "fuel": fuel.text.strip(),
                "reply": reply.text.strip()
            }
            all_reviews.append(review_data)

            print(dri.text, pri.text, reply.text)
            fail_count = 0  # 성공했으니 실패 카운터 초기화

            # df.at[i, "drive"] = dri.text.replace("\n", " ")
            # df.at[i, "price"] = pri.text.replace("\n", " ")
            # df.at[i, "habitability"] = hab.text.replace("\n", " ")
            # df.at[i, "quality"] = qua.text.replace("\n", " ")
            # df.at[i, "design"] = des.text.replace("\n", " ")
            # df.at[i, "fuel"] = fuel.text.replace("\n", " ")
            # df.at[i, "reply"] = reply.text

            # 중간 저장
            if len(all_reviews) % 50 == 0:
                pd.DataFrame(all_reviews).to_csv("car_owner_reply_partial.csv", index=False)

        except Exception as e:
            print(f"Error for {t}: {e}")
            fail_count += 1
            if fail_count >= 5:
                print(f"Error for {t}: {e}")
                break
        time.sleep(2)

df_reviews = pd.DataFrame(all_reviews)
df_reviews.to_csv("car_owner_reply_final.csv", index=False)
