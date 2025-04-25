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

for i, t in enumerate(df["title"]):
    title = f"{t} 오너평가"
    # query = quote_plus(title)

    print(f"{title}")
    driver.get(f"https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query={title}")
    time.sleep(2)
                            #//*[@id="main_pack"]/div[3]/div[2]/div/div/div[2]/div/div/ul/li[1]/div/div/span[1]
                            #//*[@id="main_pack"]/div[5]/div[2]/div/div/div[2]/div/div/ul/li[1]/div/div/span[1]
    try:
        a = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']")
        star = a.find_element(By.CLASS_NAME, "area_star_number")
        count = a.find_element(By.CLASS_NAME, "_count")

        rvs = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'area_star_number')]")
        rvp = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, '_count')]")
        dri = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'guide')]/li[1]/span")
        pri = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'guide')]/li[2]/span")
        hab = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'guide')]/li[3]/span")
        qua = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'guide')]/li[4]/span")
        des = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'guide')]/li[5]/span")
        fuel = driver.find_element(By.XPATH, "//*[@data-dss-logarea='x58']//*[contains(@class, 'guide')]/li[6]/span")

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

df.to_csv("car_owner.csv", index=False)
