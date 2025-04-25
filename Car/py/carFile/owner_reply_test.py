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

for i, t in enumerate(df["title"][:5]):
    title = f"{t} 오너평가"

    print(f"{title}")
    driver.get(f"https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={title}")
    time.sleep(3)

    #//*[@id="cbox_module_wai_u_cbox_content_wrap_tabpanel"]/ul/li[1]/div[1]/div/div[2]/div/ul/li[2]/span[2]
    #//*[@id="cbox_module_wai_u_cbox_content_wrap_tabpanel"]/ul/li[1]/div[1]/div/div[3]
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
            # df.at[i, "drive"] = dri.text.replace("\n", " ")
            # df.at[i, "price"] = pri.text.replace("\n", " ")
            # df.at[i, "habitability"] = hab.text.replace("\n", " ")
            # df.at[i, "quality"] = qua.text.replace("\n", " ")
            # df.at[i, "design"] = des.text.replace("\n", " ")
            # df.at[i, "fuel"] = fuel.text.replace("\n", " ")
            # df.at[i, "reply"] = reply.text
        except Exception as e:
            print(f"Error for {t}: {e}")
        time.sleep(3)

df_reviews = pd.DataFrame(all_reviews)
df_reviews.to_csv("car_owner_reply_test.csv", index=False)