#!/usr/bin/env python
# coding: utf-8

from urllib.request import urlopen
from bs4 import BeautifulSoup
import requests


def line(Me):
    # 先程発行したコードを貼ります
    line_notify_token = \
        'gRMky65S21R7zX3NxovVI0LDsvmGW0bKbifWy0rrill'
    line_notify_api = 'https://notify-api.line.me/api/notify'
    message = '\n' + Me
    # 変数messageに文字列をいれて送信します トークン名の隣に文字が来てしまうので最初に改行しました
    payload = {'message': message}
    headers = {'Authorization': 'Bearer ' + line_notify_token}
    line_notify = requests.post(line_notify_api, data=payload, headers=headers)


def unkou_status(url):
    html = urlopen(url).read()
    bsobj = BeautifulSoup(html, 'lxml')
    rosenElement = bsobj.find('div', {'class': 'mainWrp'})
    rosen_name = rosenElement.find('h1', {'class': 'title'}). \
        find(text=True, recursive=False)
    jikoku = rosenElement.find('span', {'class': 'subText'}).find(text=True, recursive=False)
    informationElement = bsobj.find('div', {'id': 'mdServiceStatus'}).find('dl')
    status = informationElement.find('dt').get_text()
    if status.startswith('\n'):
        status_txt = status[4:]
    else:
        status_txt = status[3:]

    information = informationElement.find('dd').find('p').find(text=True, recursive=False)
    unkou_info = []
    unkou_info.append(rosen_name + ":" + jikoku)
    unkou_info.append(status_txt)
    unkou_info.append(information)
    return unkou_info


# 横浜線
yoko_url = "https://transit.yahoo.co.jp/traininfo/detail/31/0/"
# 小田急小田原線
odakyu_odawara_url = "https://transit.yahoo.co.jp/traininfo/detail/109/0/"
# 小田急江ノ島線
odakyu_enosima_url = "https://transit.yahoo.co.jp/traininfo/detail/110/0/"


info = []
info = unkou_status(yoko_url)
msg = info[0] + '\n' + info[1] + '\n' + info[2] + '\n' + '\n'
info = unkou_status(odakyu_odawara_url)
msg = msg + info[0] + '\n' + info[1] + '\n' + info[2] + '\n' + '\n'
info = unkou_status(odakyu_enosima_url)
msg = msg + info[0] + '\n' + info[1] +  '\n' + info[2] + '\n'
# 関数lineの引数に任意の文字列を入れます
# line(msg)
print(msg)

soubu_url = 'https://transit.yahoo.co.jp/traininfo/detail/137/0/'
info = []
info = unkou_status(soubu_url)
msg_test = info[0] + '\n' + info[1] + '\n' + info[2] + '\n' + '\n'

print(msg_test)
