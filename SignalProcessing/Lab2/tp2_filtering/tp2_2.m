close all;
im = imread('barbara.jpg');



imshow(im)
title('Original Image')
figure();
%% Gradient Filtering
% DESCRIPTIVE TEXT

gradienty = fspecial('prewitt');
gradientx= transpose(gradienty);
imgradienty = imfilter(im , gradienty);
imgradientx = imfilter(im , gradientx);

subplot(121);
imshow(imgradienty);
title('Gradient y Filtering');


subplot(122);
imshow(imgradientx);
title('Gradient x Filtering');


%% Sobel Filtering

sobely = fspecial('sobel');
sobelx= transpose(sobely);
imsobelx = imfilter(im , sobelx);
imsobely = imfilter(im , sobely);

figure();
subplot(121);
imshow(imsobelx);
title('Sobel x Filtering');

subplot(122);
imshow( imsobely);
title('Sobel y Filtering');
figure();
%% Average Filtering
%This part will be about average filtering

figure();
average = fspecial('average');
imaverage = imfilter(im, average);



imshow(imaverage);
title('Average Filtering');
figure();

%% Gaussian Filtering
%
figure();
gaussian = fspecial('gaussian');
imgaussian = imfilter(im , gaussian);

imshow(imgaussian);
title('Gaussian Filtering')




