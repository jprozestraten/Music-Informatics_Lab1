%% Load 20-50 seconds of .wav-file
filename = 'road.wav';
Fs = 44.1e3;
% [x,Fs] = getaudio(filename,[20*Fs 50*Fs],'mono');
[x,Fs] = getaudio(filename,[1 Inf],'left');

%% Play sound
% sound(x,Fs)

%% Plot entire signal in time-domain
t = 0:1/Fs:(length(x)-1)/Fs;
figure(1);
plot(t,x)
title('Soundfile of a car passing by on a road')
xlabel('Time [s]')
ylabel('Amplitude')

%% Plot 25 ms segments at 4 s and at 15 s in time-domain
t1 = 4;
t2 = 15;
dt = 0.025;
range_t1 = (t1*Fs+1):(t1+dt)*Fs;
range_t2 = (t2*Fs+1):(t2+dt)*Fs;
N = length(range_t1);

figure(2);
subplot(211)
plot(t(range_t1)*1e3,x(range_t1))
title(['t_1 = ',num2str(t1),' s'])
xlabel('Time [ms]')
ylabel('Amplitude')
subplot(212)
plot(t(range_t2)*1e3,x(range_t2))
title(['t_2 = ',num2str(t1),' s'])
xlabel('Time [ms]')
ylabel('Amplitude')
sgtitle([num2str(dt*1e3),' ms segments'])

%% Plot segments at 4 s and at 15 s in frequency-domain
L = N;
[P_t1,f_t1] = fft2ss(fft(x(range_t1)));
[P_t2,f_t2] = fft2ss(fft(x(range_t2)));

figure(3)
subplot(211)
plot(f_t1*Fs*1e-3,10*log10(P_t1))
title(['t_1 = ',num2str(t1),' s'])
xlabel('Frequency [kHz]')
ylabel('P_X [dB]')
xlim([0 5])
subplot(212)
plot(f_t2*Fs*1e-3,10*log10(P_t2))
title(['t_2 = ',num2str(t2),' s'])
xlabel('Frequency [kHz]')
ylabel('P_X [dB]')
xlim([0 5])
sgtitle(['PSD of ',num2str(dt*1e3),' ms segments with box-car window'])

[P_t1_hann,f_t1_hann] = fft2ss(fft(x(range_t1).*hann(L,'periodic')));
[P_t2_hann,f_t2_hann] = fft2ss(fft(x(range_t2).*hann(L,'periodic')));

figure(4)
subplot(211)
plot(f_t1_hann*Fs*1e-3,10*log10(P_t1_hann))
title(['t_1 = ',num2str(t1),' s'])
xlabel('Frequency [kHz]')
ylabel('P_X [dB]')
xlim([0 5])
subplot(212)
plot(f_t2_hann*Fs*1e-3,10*log10(P_t2_hann))
title(['t_2 = ',num2str(t2),' s'])
xlabel('Frequency [kHz]')
ylabel('P_X [dB]')
xlim([0 5])
sgtitle(['PSD of ',num2str(dt*1e3),' ms segments with hann window'])

%% Windowing of complete signal with overlap
tSegment = 0.1;
nSegment = floor(tSegment*Fs);
tHop = 0.010;
nOverlap = nSegment - floor(tHop*Fs);

figure(5)
spectrogram(x,hann(nSegment,'periodic'),nOverlap,[],Fs,'onesided','yaxis')
ylim([0 5])

tSegment = 0.025;
nSegment = floor(tSegment*Fs);
tHop = 0.010;
nOverlap = nSegment - floor(tHop*Fs);

figure(6)
spectrogram(x,hann(nSegment,'periodic'),nOverlap,[],Fs,'onesided','yaxis')
ylim([0 5])