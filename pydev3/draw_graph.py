# -*- coding: utf-8 -*-
import pandas as pd
import matplotlib.pyplot as plt

data = pd.read_csv("temp-humidty.csv", index_col='time')
df_tmp_humid = data.iloc[:, [0,1]]
df_tmp_humid.plot()
plt.savefig("tmp_humid.png")
plt.show()
