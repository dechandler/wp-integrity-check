#!/usr/bin/env python3

import requests
from bs4 import BeautifulSoup

url = "https://wordpress.org/download/release-archive/"
r = requests.get(url)
soup = BeautifulSoup(r.text, "lxml")
table = soup.find("table", {'class': "widefat"})
versions = []
for row in table.find_all("tr"):
    try:
        versions.append(row.find_all("td")[0].text)
    except IndexError:
        pass
versions.reverse()
print("\n".join(versions))
