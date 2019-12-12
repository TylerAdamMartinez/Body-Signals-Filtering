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
%frequency spectrum analysis of the RAW ECG data
ECGN = length(ECGtime);
ECGfs = 2500;
ECGf = ECGfs*(0:(ECGN/2))/ECGN;
ECGy = fft(ECGsignal);
ECGP2 = abs(ECGy/ECGN);
ECGP1 = ECGP2(1:ECGN/2+1);
ECGP1(2:end-1) = 2*ECGP1(2:end-1);
%filering out the 60Hz noise from the signal
Num = designfilt('bandstopiir','FilterOrder',2, ...
               'HalfPowerFrequency1',59,'HalfPowerFrequency2',61, ...
               'DesignMethod','butter','SampleRate',ECGfs);
ECGfiltered = filtfilt(Num, ECGsignal);
%frequency spectrum analysis of the Filtered ECG data
ECGN = length(ECGtime);
ECGfs = 2500;
ECGf = ECGfs*(0:(ECGN/2))/ECGN;
ECGyfiltered = fft(ECGfiltered);
ECGP2fil = abs(ECGyfiltered/ECGN);
ECGP1fil = ECGP2fil(1:ECGN/2+1);
ECGP1fil(2:end-1) = 2*ECGP1fil(2:end-1);

%Gathering EMG data from file
EMGfile = fopen('EMG.txt', 'r');
EMGdata = fscanf(EMGfile, '%f');
%frequency spectrum analysis of the EMG data
EMGN = length(EMGdata);
EMGfs = 1000;
EMGtime = 1/(EMGfs):1/(EMGfs):30;
EMGtime = transpose(EMGtime);
EMGf = EMGfs*(0:(EMGN/2))/EMGN;
EMGy = fft(EMGdata);
EMGP2 = abs(EMGy/EMGN);
EMGP1 = EMGP2(1:EMGN/2+1);
EMGP1(2:end-1) = 2*EMGP1(2:end-1);
%Calculating Area underneath curve using Reimann Sums
IntFatigue = sum(EMGP1(1:1501)); 
IntNFatigue = sum(EMGP1(1:3001, 1)); 
Fatigue = IntFatigue/IntNFatigue;


%Gathering EEG data from file
EEGdata = dlmread('EEGSignal.txt', '\t');
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
figure('Name','Electrocardiography Unfiltered','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGsignal);
title("RAW ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2,1,2);
plot(ECGf, ECGP1);
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 100]);

figure('Name','Electrocardiography Filtered','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGfiltered);
title("Filtered ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2,1,2);
plot(ECGf, ECGP1fil);
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 100]);

figure('Name','Electrocardiographs Unfiltered Vs Filtered','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGsignal);
title("Unfiltered ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2, 1, 2);
plot(ECGtime, ECGfiltered);
title("Filtered ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");


figure('Name','Electromyographs ','NumberTitle','off');
subplot(2, 1, 1);
plot(EMGtime, EMGdata);
title("EMG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2,1,2);
plot(EMGf, EMGP1);
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 100]);

figure('Name','Electroencephalograhy','NumberTitle','off');
subplot(3, 1, 1);
plot(EEGtime, EEGsignal);
title("EEG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude (uV)");

subplot(3,1,2);
plot(EEGf, EEGP1); 
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 30]);

Delta = EEGP1(1:17);
Delta = sum(Delta);
Theta = EEGP1(18:33);
Theta = sum(Theta);
Alpha = EEGP1(34:49);
Alpha = sum(Alpha);
Beta = EEGP1(50:162);
Beta = sum(Beta);

EEGbarlabels = categorical({'Delta','Theta','Alpha','Beta'});
EEGbar = [Delta Theta Alpha Beta];

subplot(3,1,3);
EEGb = bar(EEGbarlabels, EEGbar);
title('EEG Signals'); ylabel('Amplitude');