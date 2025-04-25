import pandas as pd
import re

df = pd.read_csv("./carFile/car_owner_reply_final.csv")

def remove_special_characters(text):
    if pd.isna(text):
        return text
    return re.sub(r'[^가-힣a-zA-Z0-9\s]', '', text)

df['reply'] = df['reply'].apply(remove_special_characters)

df.to_csv("car_owner_reply_cleaned.csv", index=False)
