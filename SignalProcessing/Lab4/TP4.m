%% Creation of the noisy versions of the music


close all;

[noise1,Fs1] = audioread("noise1.wav");
[noise2,Fs2] = audioread("noise2.wav");
[noise3,Fs3] = audioread("noise3.wav");
[music,Fs] = audioread("music.wav");

%For each song adding some noise which is a combination of the three noises
%and display the SNR
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
X_1 = op.analysis(noised_music_1);
[NbFreq, NbTime] = size(X_1);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X_1)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Noised Music V1')



%Performing the Analysis
X_2= op.analysis(noised_music_2);
[NbFreq, NbTime] = size(X_2);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X_2)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Noised Music V2')



%Performing the Analysis
X_3= op.analysis(noised_music_3);
[NbFreq, NbTime] = size(X_3);
FreqGaborAxis = linspace(0,Fs/2,NbFreq);
TimeGaborAxis = linspace(0,T,NbTime);

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X_3)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Noised Music V3')


spectrum1_welch = pwelch(overall_noise_1, window_size , recouvering);
spectrum2_welch = pwelch(overall_noise_2 , window_size , recouvering );
spectrum3_welch = pwelch(overall_noise_3 ,  window_size , recouvering);


%For each song doing the substraction
HWienerNum = bsxfun(@minus,abs(X_1).^2,spectrum1_welch); 
HWienerNum(HWienerNum < 0) = 0;
HWienerDenum = abs(X_1).^2;

HWiener = HWienerNum./(HWienerDenum+eps); % +eps pour eviter les divisions par 0
X_estim_1 = X_1.*HWiener ;

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X_estim_1)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Denoised Music V1');

X_denoised1 = op.synthesis(X_estim_1);



HWienerNum = bsxfun(@minus,abs(X_2).^2,spectrum1_welch); 
HWienerNum(HWienerNum < 0) = 0;
HWienerDenum = abs(X_2).^2;

HWiener = HWienerNum./(HWienerDenum+eps); % +eps pour eviter les divisions par 0
X_estim_2 = X_2.*HWiener ;

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X_estim_2)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Denoised Music V2');

X_denoised2 = op.synthesis(X_estim_2);



HWienerNum = bsxfun(@minus,abs(X_3).^2,spectrum1_welch); 
HWienerNum(HWienerNum < 0) = 0;
HWienerDenum = abs(X_3).^2;

HWiener = HWienerNum./(HWienerDenum+eps); % +eps pour eviter les divisions par 0
X_estim_3 = X_3.*HWiener ;

%Plotting the result
figure;
imagesc(TimeGaborAxis, FreqGaborAxis, 20*log(abs(X_estim_3)+eps));
set(gca,'Ydir','Normal');
title('Spectrogram of Denoised Music V3');

X_denoised3 = op.synthesis(X_estim_3);


%SNR and PSNR %signal to noise ratio %peak signal to noise ratio




SNR_compute(music, X_denoised1,1);
SNR_compute(music, X_denoised2,2);
SNR_compute(music, X_denoised3,3);


function [SNR] = SNR_compute(music, denoised_music , j)
    
    temp=music;
    y=denoised_music;
    num=0;
    den=0;
    for i=1:length(temp)
    den=den+(y(i)-temp(i))^2;
    end
    for i=1:length (temp)
    num=num+temp(i)^2;
    end
    SNR = 20*log10(sqrt(num)/sqrt(den));

    fprintf('signal to noise ratio of denoised V %d %f db\n',j,SNR);
end