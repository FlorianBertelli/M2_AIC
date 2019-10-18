% Loading the noises
[noise1,Fs1] = audioread("noise1.wav");
[noise2,Fs2] = audioread("noise2.wav");
[noise3,Fs3] = audioread("noise3.wav");
[music,Fs] = audioread("music.wav");

overall_noise = 0.1 * (noise1 + noise2 + noise3);
noised_music = music + overall_noise;


audiowrite('noised_music.wav', noised_music, Fs)

var_noise = var(overall_noise);
mean_noise = mean(overall_noise);

N = length(music); %Number of samples

%soundsc(noised_music,Fs);

P = 1/ N * abs(fft(music)).^2;

wien_filter = real(ifft( P ./ (P + var_noise)));    


figure();
plot(fftshift(wien_filter)); axis tight;

denoised_music = filter (wien_filter,1, noised_music );

figure();
plot(noised_music);
title('noised');

figure();
plot(denoised_music);
title ('denoised');


soundsc(denoised_music,Fs);