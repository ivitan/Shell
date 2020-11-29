import requests
import _thread
import time
from datetime import datetime

url = "https://caiyun.feixin.10086.cn:7071/portal/cyhuodong/gdllAccept.action"

header = {
    'Content-Type' : 'application/x-www-form-urlencoded; charset=UTF-8',
    'Accept': 'application/json, text/javascript, */*; q=0.01',
    'Origin' : 'https://caiyun.feixin.10086.cn:7071',
    'X-Requested-With': 'XMLHttpRequest',
    'Sec-Fetch-Dest': 'empty',
    'Referer': 'https://caiyun.feixin.10086.cn:7071/portal/gdll/index.jsp',
    'Cookie': '这里填入Cookies',
    'User-Agent': 'Mozilla/5.0 (Linux; Android 8.0.0; Pixel 2 XL Build/OPD1.170816.004) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Mobile Safari/537.36'
}

data = "pOrder=2"

def CatchTheMouse():
    result = requests.post(url, data = data, headers = header).json()
    print(datetime.now().strftime('%m-%d %H:%M:%S'), result)

try:
    print("Press Ctrl + C to exit.")
    for i in range(50):
        _thread.start_new_thread( CatchTheMouse, ())
        time.sleep(0.5)
except Exception as ex:
   print (ex)

while 1:
    pass