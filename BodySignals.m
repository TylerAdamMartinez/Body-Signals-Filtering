%{
PUT PROGRAM ALG HERE
explaination 
and over all comments about the code here. 

Created by Tyler Adam Martinez
%}

%Gathering ECG data from file
ECGfile = csvread("ECGLab.csv");
ECGtime = ECGfile(:,1);
ECGsignal = ECGfile(:, end);
%frequency spectrum analysis of the ECG data
N = length(ECGtime);
fs = 2500;
f = fs*(0:(N/2))/N;
y = fft(ECGsignal);
P2 = abs(y/N);
P1 = P2(1:N/2+1);
P1(2:end-1) = 2*P1(2:end-1);

%Gathering EMG data from file
EMGfile = fopen('EMG.txt', 'r');
EMGdata = fscanf(EMGfile, '%f');

%Gathering EEG data from file
%EEGfile = fopen('EEGSignalCopy.txt', 'r'); 
%EEGdata = fscanf(EEGfile, ['%f' Amplitude - EEG 'Amplitude - EEG']);
EEGdata = dlmread('EEGSignalCopy.txt', '\t');
EEGsignal = EEGdata(1, :);
EEGtime = EEGdata(2, :);

%plotting the data
subplot(4, 1, 1);
plot(ECGtime, ECGsignal);
title("ECG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude(mV)");

subplot(4,1,2);
plot(f, P1);
xlabel('frequency (hz)'); ylabel('amplitude'); title('Frequency Spectrum');
xlim([0 100]);

subplot(4, 1, 3);
plot(EMGdata);
title("EMG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude(mV)");

subplot(4, 1, 4);
plot(EEGtime, EEGsignal);
title("EEG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude(mV)");


%closing the nessary files
%fclose(EMGfile);
%fclose(EEGfile);