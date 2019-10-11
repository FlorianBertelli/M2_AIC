[noise1,Fs1] = audioread("noise1.wav");
[noise2,Fs2] = audioread("noise2.wav");
[noise3,Fs3] = audioread("noise3.wav");
[music,Fs] = audioread("music.wav");

overall_noise_1 = 0.05 * (noise1 + noise2 + noise3);
overall_noise_2 = 0.1 * (noise1 + noise2 + noise3);
overall_noise_3 = 0.2 * (noise1 + noise2 + noise3);


noised_music_1 = music + overall_noise_1;
disp('SNR of noised_music_1' )
disp(snr(music, overall_noise_1))
noised_music_2 = music + overall_noise_2;
disp("SNR of noised_music_2" )
disp(snr(music, overall_noise_2))
noised_music_3 = music + overall_noise_3;
disp("SNR of noised_music_3" )
disp(snr(music, overall_noise_3))

%Parameters of the spectogram
window_size = 1024;
recouvering = window_size/4;
T = length(music);
g = gabwin({'tight', 'hann'}, recouvering, window_size);

%Pointeur matlab (pour éviter de réécrire à chaque fois)
op.analysis = @(x) dgtreal(x,g,recouvering,window_size);
op.synthesis = @(x) idgtreal(x,g,recouvering,window_size,T);


%Performing the Analysis on Original Music
X = op.analysis(music);
[NbFreq, NbTime] = size(X);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Music');



%Performing the Analysis
X = op.analysis(noised_music_1);
[NbFreq, NbTime] = size(X);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Noised Music V1')



%Performing the Analysis
X = op.analysis(noised_music_2);
[NbFreq, NbTime] = size(X);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Noised Music V2')



%Performing the Analysis
X = op.analysis(noised_music_3);
[NbFreq, NbTime] = size(X);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Noised Music V3')

