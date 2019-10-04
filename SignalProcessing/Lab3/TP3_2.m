%%  0dB Gaussian white noise and denoising with Wiener filter

I = imread ("barbara.jpg");
I = rgb2gray(I);

imshow(I);
title("Original image");
figure();

noised_0 = uint8(awgn(double(I),0,'measured'));
imshow(noised_0);
title("Noised image,SNR = 0 dB");


figure();
denoised_0 = wiener2(noised_0,[5 5]);
imshow(denoised_0);
title("Denoised image with wiener filter,SNR = 0 dB");


%%  5dB Gaussian white noise and denoising with Wiener filter

figure();
noised_5 = uint8(awgn(double(I),5,'measured'));
imshow(noised_5);
title("Noised image,SNR = 5 dB");


figure();
denoised_5 = wiener2(noised_5,[5 5]);
imshow(denoised_5);
title("Denoised image with wiener filter,SNR = 5 dB");


%%  10dB Gaussian white noise and denoising with Wiener filter

figure();
noised_10 = uint8(awgn(double(I),10,'measured'));
imshow(noised_10);
title("Noised image,SNR = 10 dB");


figure();
denoised_10 = wiener2(noised_10,[5 5]);
imshow(denoised_10);
title("Denoised image with wiener filter,SNR = 10 dB");



%%  15dB Gaussian white noise and denoising with Wiener filter


figure();
noised_15 = uint8(awgn(double(I),15,'measured'));
imshow(noised_15);
title("Noised image,SNR = 15 dB");


figure();
denoised_15 = wiener2(noised_15,[5 5]);
imshow(denoised_15);
title("Denoised image with wiener filter,SNR = 15 dB");


%%  20dB Gaussian white noise and denoising with Wiener filter   


figure();
noised_20 = uint8(awgn(double(I),20,'measured'));
imshow(noised_20);
title("Noised image,SNR = 20 dB");


figure();
denoised_20 = wiener2(noised_20,[5 5]);
imshow(denoised_20);
title("Denoised image with wiener filter,SNR = 20 dB");

