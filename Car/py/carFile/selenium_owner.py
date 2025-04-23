from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from urllib.parse import quote_plus
import time
import pandas as pd

option = Options()
option.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=option)

df = pd.read_csv("./carFile/carname.csv")

if "rating" not in df.columns:
    df["rating"] = ""

if "ratingPeople" not in df.columns:
    df["ratingPeople"] = ""

if "drive" not in df.columns:
    df["drive"] = ""

if "price" not in df.columns:
    df["price"] = ""

if "habitability" not in df.columns:
    df["habitability"] = ""

if "quality" not in df.columns:
    df["quality"] = ""

if "design" not in df.columns:
    df["design"] = ""

if "fuel" not in df.columns:
    df["fuel"] = ""

for i, t in enumerate(df["title"][:10]):
    title = f"{t} 오너평가"
    # query = quote_plus(title)

    print(f"{title}")
    driver.get(f"https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={title}")
    time.sleep(2)

    try:
        rvs = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[1]/div[1]/div[1]/span[1]')
        rvp = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[1]/div[1]/div[1]/span[3]')
        dri = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[2]/div[1]/div[1]/div[1]/ul/li[1]')
        pri = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[2]/div[1]/div[1]/div[1]/ul/li[2]')
        hab = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[2]/div[1]/div[1]/div[1]/ul/li[3]')
        qua = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[2]/div[1]/div[1]/div[1]/ul/li[4]')
        des = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[2]/div[1]/div[1]/div[1]/ul/li[5]')
        fuel = driver.find_element(By.XPATH, '//*[@class="main_pack"]/div[3]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/ul/li[2]/div[1]/div[1]/div[1]/ul/li[6]')

        print(rvs.text, rvp.text, dri.text, pri.text)
        df.at[i, "rating"] = rvs.text
        df.at[i, "ratingPeople"] = rvp.text
        df.at[i, "drive"] = dri.text.replace("\n", " ")
        df.at[i, "price"] = pri.text.replace("\n", " ")
        df.at[i, "habitability"] = hab.text.replace("\n", " ")
        df.at[i, "quality"] = qua.text.replace("\n", " ")
        df.at[i, "design"] = des.text.replace("\n", " ")
        df.at[i, "fuel"] = fuel.text.replace("\n", " ")
    except Exception as e:
        print(f"Error for {t}: {e}")
    time.sleep(2)

df.to_csv("testcar.csv", index=False)
