#!/usr/bin/env python

from PyQt5.QtWidgets import (QApplication, QWidget, QSizePolicy,
                             QGridLayout, QVBoxLayout, QHBoxLayout,
                             QLabel, QLineEdit, QPushButton)
import subprocess
import csv

def subproc():
    cmd = 'python /home/pi/pydev3/get_sensor_data.py >> /home/pi/pydev3/temp-humidty.csv'
    retcode = subprocess.call(cmd, shell=True)
    return retcode

def strfloatstr(s):
    f = float(s)
    retstr = '{:.0f}'.format(f)
    return retstr

class MainWindow(QWidget):
    def __init__(self, parent=None):
        super(MainWindow, self).__init__(parent)

        self.inputLine = QLineEdit()
        self.outputLine = QLineEdit()
        self.outputLine2 = QLineEdit()
        self.outputLine3 = QLineEdit()
        self.outputLine4 = QLineEdit()
        self.inputLine.setReadOnly(True)
        self.outputLine.setReadOnly(True)
        self.outputLine2.setReadOnly(True)
        self.outputLine3.setReadOnly(True)
        self.outputLine4.setReadOnly(True)

        self.calcButton = QPushButton("取得")
        self.calcButton.setSizePolicy(QSizePolicy.Fixed, QSizePolicy.Fixed)
        self.calcButton.clicked.connect(self.calc)

        lineLayout = QGridLayout()
        lineLayout.addWidget(QLabel("取得時刻"), 0, 0)
        lineLayout.addWidget(self.inputLine, 0, 1)
        lineLayout.addWidget(QLabel("温度"), 1, 0)
        lineLayout.addWidget(self.outputLine, 1, 1)
        lineLayout.addWidget(QLabel("湿度"), 2, 0)
        lineLayout.addWidget(self.outputLine2, 2, 1)
        lineLayout.addWidget(QLabel("気圧"), 3, 0)
        lineLayout.addWidget(self.outputLine3, 3, 1)
        lineLayout.addWidget(QLabel("エラー"), 4, 0)
        lineLayout.addWidget(self.outputLine4, 4, 1)
 

        buttonLayout = QHBoxLayout()
        buttonLayout.addWidget(self.calcButton)

        mainLayout = QVBoxLayout()
        mainLayout.addLayout(lineLayout)
        mainLayout.addLayout(buttonLayout)

        self.setLayout(mainLayout)
        self.setWindowTitle("気温 湿度 気圧")
        self.setGeometry(100, 100, 330, 250)

    def calc(self):
       r = subproc()
       target_file = open('/home/pi/pydev3/temp-humidty.csv')
       target_reader = csv.reader(target_file)
       target_data = list(target_reader)
       last_no = len(target_data) - 1
       now_date = target_data[last_no][0]
       temp_data = strfloatstr(target_data[last_no][1])  + " ℃"
       humi_data = strfloatstr(target_data[last_no][2]) + " %"
       pres_data = strfloatstr(target_data[last_no][3]) + " hPa"
       if r == 0:
            err_msg = 'Subprocess 成功!'
       else:
            err_msg = 'Subprocess 失敗!'

       self.inputLine.setText(now_date)
       self.outputLine.setText(temp_data)
       self.outputLine2.setText(humi_data)
       self.outputLine3.setText(pres_data)
       self.outputLine4.setText(err_msg)

       target_file.close()
 

if __name__ == '__main__':
    import sys
    app = QApplication(sys.argv)
    main_window = MainWindow()

    main_window.show()
    sys.exit(app.exec_())
