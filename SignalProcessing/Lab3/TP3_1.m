close all;
% Loading the noises
[noise1,Fs1] = audioread("noise1.wav");
[noise2,Fs2] = audioread("noise2.wav");
[noise3,Fs3] = audioread("noise3.wav");

% soundsc(noise1,Fs1);

%% Estimating the spectrum density by periodigram

spectrum1 = periodogram(noise1);
spectrum2 = periodogram(noise2);
spectrum3 = periodogram(noise3);

figure();
loglog(spectrum1);
title('Spectrum of noise 1 obtained by periodigram');


figure();
loglog(spectrum2);
title('Spectrum of noise 2 obtained by periodigram');


figure();
loglog(spectrum3);
title('Spectrum of noise 3 obtained by periodigram');



%% Estimating the spectrum density with Welch method


spectrum1_welch = pwelch(noise1);
spectrum2_welch = pwelch(noise2);
spectrum3_welch = pwelch(noise3);

figure();
loglog(spectrum1_welch);
title('Spectrum of noise 1 obtained by Welch method');


figure();
loglog(spectrum2_welch);
title('Spectrum of noise 2 obtained by Welch method');

figure();
loglog(spectrum3_welch);
title('Spectrum of noise 3 obtained by Welch method');

%% Determinating the color of each noise :

