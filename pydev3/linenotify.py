

import requests
import subprocess
import csv

def line(Me):
    line_notify_token = 'gRMky65S21R7zX3NxovVI0LDsvmGW0bKbifWy0rrill' #先程発行したコードを貼ります
    line_notify_api = 'https://notify-api.line.me/api/notify'
    message = '\n' + Me
    #変数messageに文字列をいれて送信します トークン名の隣に文字が来てしまうので最初に改行しました
    payload = {'message': message}
    headers = {'Authorization': 'Bearer ' + line_notify_token}
    line_notify = requests.post(line_notify_api, data=payload, headers=headers)

def subproc():
    cmd = 'python ~/pydev3/get_sensor_data.py >> ~/pydev3/temp-humidty.csv'
    retcode = subprocess.call(cmd, shell=True)
    return retcode

def strfloatstr(s):
    f = float(s)
    retstr = '{:.0f}'.format(f)
    return retstr

r = subproc()
target_file = open('/home/pi/pydev3/temp-humidty.csv')
target_reader = csv.reader(target_file)
target_data = list(target_reader)
last_no = len(target_data) - 1
now_date = target_data[last_no][0]
temp_data = strfloatstr(target_data[last_no][1])  + " ℃"
humi_data = strfloatstr(target_data[last_no][2]) + " %"
pres_data = strfloatstr(target_data[last_no][3]) + " hPa"
target_file.close()


msg = now_date + '\n' + temp_data + '\n' +humi_data + '\n' + pres_data + '\n'
#関数lineの引数に任意の文字列を入れます
line(msg)
