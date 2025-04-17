import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from selenium.webdriver.support.ui import WebDriverWait 
from selenium.webdriver.support import expected_conditions as EC
from webdriver_manager.chrome import ChromeDriverManager
import time

df = pd.read_csv("./carFile/carname.csv")



# 크롬 설정
options = Options()
options.add_experimental_option("detach", True)
prefs = {
    "profile.default_content_setting_values.notifications": 2,
    "profile.default_content_setting_values.popups": 2
}
options.add_experimental_option("prefs", prefs)


driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)
driver.get("https://search.naver.com/search.naver?where=nexearch&sm=tab_etc&mra=bjg1&pkid=128&os=5569929&qvt=0&query=")
time.sleep(5)
df = pd.read_csv("./carFile/carname.csv")