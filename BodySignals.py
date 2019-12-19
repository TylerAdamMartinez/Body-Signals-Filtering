"""
The ECG, EMG, and EEG was taken from a patient. 
ECG was recorded in a .csv file
EMG and EEG was recorded in a .txt file with different delimiters

Our task: 
Load the data from the given files into a Python script and plot the data.
Then take the discrete fourier transforms of each signal then plot the
frequency Spectrums. In addition, create a digital notch filter to remove
the noise coming from mains power in the ECG signal, determine if the patient was tired
during the recording of the EMG signal based on the frequency spectrum of
the EMG signal, and determine the mental state of the patient during
recording of the EEG signal based on the frequency spectrum of the EEG
signal. Finally, break down how much of the EEG signal is comprised of the
four EEG wave components (Delta, Theta, Alpha and Beta), and display it in a bar graph.

Created by Tyler Adam Martinez 
Date: 12/16/2019
"""
import matplotlib.pyplot as plt
import matplotlib as mat
import numpy as np
import scipy as sp
import pylab as lab
from math import pi
import math
import pandas as pd

#ECG Signal
ECGtime = pd.read_csv('ECGtime.csv') + 2; 
ECGsignal = pd.read_csv('ECGsignal.csv');
#ECG Frequency Spectrum
#ECGN = mat.length(ECGtime);
ECGfs = 2500; #signal has a sampling frequency of 2500Hz
#ECGpowersignal = mat.fft(ECGsignal);
#ECGf = ECGfs*np.arange(0,1,(ECGN/2))/ECGN;
#plotting ECG Signal
plt.figure(1);
plt.subplot(4,1,1);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);
plt.subplot(4,1,2);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);
plt.subplot(4,1,3);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);
plt.subplot(4,1,4);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);

plt.figure(2);
plt.subplot(2,1,1);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);
plt.subplot(2,1,2);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);


plt.figure(3);
plt.subplot(2,1,1);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);
plt.subplot(2,1,2);
plt.title('ECG Unfiltered'); plt.ylabel('Amplitude (mV)'); plt.xlabel('Time (s)');
plt.plot(ECGtime, ECGsignal);
plt.show();


