%{
The ECG, EMG, and EEG was taken from a patient. 
ECG was recorded in a .csv file
EMG and EEG was recorded in a .txt file with different delimiters

Our task: 
Load the data from the given files into a MATlab script and plot the data.
Then take the discrete fourier transforms of each signal then plot the
frequency Spectrums. In addition, create a digital notch filter to remove
the noise coming from mains power in the ECG signal, determine if the patient was tired
during the recording of the EMG signal based on the frequency spectrum of
the EMG signal, and determine the mental state of the patient during
recording of the EEG signal based on the frequency spectrum of the EEG
signal. Finally, break down how much of the EEG signal is comprised of the
four EEG wave components (Delta, Theta, Alpha and Beta), and display it in a bar graph.

Created by Tyler Adam Martinez 
Date: 12/12/2019
%}

%% ECG Portion
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

%% EMG Portion
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

%% EEG Portion
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

%% plotting the data for ECG Unfiltered
figure('Name','Electrocardiography Unfiltered','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGsignal);
title("RAW ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2,1,2);
plot(ECGf, ECGP1);
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 100]);

%% plotting the data for ECG Filtered
figure('Name','Electrocardiography Filtered','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGfiltered);
title("Filtered ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2,1,2);
plot(ECGf, ECGP1fil);
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 100]);

%% plotting the data for ECG Unfiltered vs. Filtered 
figure('Name','Electrocardiographs Unfiltered Vs Filtered','NumberTitle','off');
subplot(2, 1, 1);
plot(ECGtime, ECGsignal);
title("Unfiltered ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2, 1, 2);
plot(ECGtime, ECGfiltered);
title("Filtered ECG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

%% plotting the data for EMG 
figure('Name','Electromyographs ','NumberTitle','off');
subplot(2, 1, 1);
plot(EMGtime, EMGdata);
title("EMG Signal"); xlabel("Seconds (s)"); ylabel("Amplitude (100 mV)");

subplot(2,1,2);
plot(EMGf, EMGP1);
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 100]);

%% plotting the data for EEG
figure('Name','Electroencephalograhy','NumberTitle','off');
subplot(3, 1, 1);
plot(EEGtime, EEGsignal);
title("EEG Signal"); xlabel("Seconds(s)"); ylabel("Amplitude (uV)");

subplot(3,1,2);
plot(EEGf, EEGP1); 
xlabel('frequency (hz)'); ylabel('Amplitude'); title('Frequency Spectrum');
xlim([0 30]);

%% Sorting the EEG signal into its four components and displaying it in a histogram  
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