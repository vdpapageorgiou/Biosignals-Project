import pandas as pd
import os
import neurokit2 as nk
import matplotlib.pyplot as plt

epochs = {}
DF_list = list()
folder_list = os.listdir()

res = [idx for idx in folder_list if idx[0] == 'S']

for i, Subject_folder in enumerate(res):
    for file in os.listdir(Subject_folder):
        if "EDA" in file:
            print(file)
            data = pd.read_csv(Subject_folder + '/' + file)
            data["Subject"] = file[0:-14]
            data_Subject = data[["EDA", "Label", "Subject"]]
            DF_list.append(data_Subject)

processed_list = list()

for i in DF_list:
    signals, info = nk.eda_process(i["EDA"], sampling_rate=8)
    combined = [signals, info]
    processed_list.append(combined)

signals = processed_list[00][0]
info = processed_list[00][1]
cleaned = signals["EDA_Clean"]
features = [info["SCR_Onsets"], info["SCR_Peaks"], info["SCR_Recovery"]]

plot = nk.events_plot(features, cleaned, color=['red', 'blue', 'orange'])
