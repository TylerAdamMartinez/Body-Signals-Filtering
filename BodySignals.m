%{
PUT PROGRAM ALG HERE
explaination 
and over all comments about the code here. 

Created by Tyler Adam Martinez
%}

%Gathering ECG data from file
ECGfile = csvread("ECGLab.csv");
ECGtime = ECGfile(:,1) + 2;
ECGsignal = ECGfile(:, end);
%frequency spectrum analysis of the ECG data
ECGN = length(ECGtime);
ECGfs = 2500;
ECGf = ECGfs*(0:(ECGN/2))/ECGN;
ECGy = fft(ECGsignal);
ECGP2 = abs(ECGy/ECGN);
ECGP1 = ECGP2(1:ECGN/2+1);
ECGP1(2:end-1) = 2*ECGP1(2:end-1);

%Gathering EMG data from file
EMGfile = fopen('EMG.txt', 'r');
EMGdata = fscanf(EMGfile, '%f');
%frequency spectrum analysis of the EMG data
EMGN = length(EMGdata);
EMGtime = 0:(EMGN - 1);
EMGtime = transpose(EMGtime);
EMGfs = 1000;
EMGf = EMGfs*(0:(EMGN/2))/EMGN;
EMGy = fft(EMGdata);
EMGP2 = abs(EMGy/EMGN);
EMGP1 = EMGP2(1:EEGN/2+1);
EMGP1(2:end-1) = 2*EMGP1(2:end-1);

%Gathering EEG data from file
EEGdata = dlmread('EEGSignalCopy.txt', '\t');
EEGsignal = EEGdata(1, :);
EEGtime = EEGdata(2, :);
%frequency spectrum analysis of the EEG data
EEGN = length(EEGtime);
EEGfs = 2500;
EEGf = EEGfs*(0:(EEGN/2))/EEGN;
EEGy = fft(EEGsignal);
EEGP2 = abs(EEGy/EEGN);
EEGP1 = EEGP2(1:EEGN/2+1);
EEGP1(2:end-1) = 2*EEGP1(2:end-1);

%plotting the data
%figure(1);
figure('Name','Electrocardiography','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGsignal);
title("ECG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude(100 mV)");

subplot(2,1,2);
plot(ECGf, ECGP1);
xlabel('frequency (hz)'); ylabel('amplitude'); title('Frequency Spectrum');
xlim([0 100]);

figure('Name','Electromyography','NumberTitle','off');
subplot(2, 1, 1);
plot(EMGdata);
title("EMG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude(mV)");

subplot(2,1,2);
plot(EMGP1);
xlabel('frequency (hz)'); ylabel('amplitude'); title('Frequency Spectrum');
xlim([0 100]);

figure('Name','Electroencephalograhy','NumberTitle','off');
subplot(2, 1, 1);
plot(EEGtime, EEGsignal);
title("EEG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude(mV)");

subplot(2,1,2);
plot(EEGf, EEGP1);
xlabel('frequency (hz)'); ylabel('amplitude'); title('Frequency Spectrum');
xlim([0 40]);
