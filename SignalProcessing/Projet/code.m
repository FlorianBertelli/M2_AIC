  
close all;
%% ouverture image
im = imread("lena.png");
imshow(im);
figure();

im = rgb2gray(im);
imshow(im);
figure();

%% convolution
mask = ones(5,5);
imconv = conv2(im, mask, 'same');

max_ = max(max(imconv));
imconv = 255*(imconv/max_);
imconv = uint8(imconv);
imshow(imconv);
figure();


%% translation
transl_list = [ [1,0] ; [0,1] ;[1,1]]

trans_im1 = imtranslate(imconv,transl_list(1 ,:));
subplot(3,1,1);
imshow(trans_im1)
trans_im2 = imtranslate(imconv,transl_list(2 ,:));
subplot(3,1,2);
imshow(trans_im2)
trans_im3 = imtranslate(imconv,transl_list(3 ,:));
subplot(3,1,3);
imshow(trans_im3);

figure();


%% downsampling
step = 4 ; 
size_ = size(im);

down_im1 =trans_im1(1:step : size_(1), 1:step:size_(2));
down_im2 =trans_im2(1:step : size_(1), 1:step:size_(2));
down_im3 =trans_im3(1:step : size_(1), 1:step:size_(2));

%% adding noise
noise_im1 = imnoise(down_im1, 'gaussian', 0 , 0.01);
noise_im2 = imnoise(down_im2, 'gaussian', 0 , 0.01);
noise_im3 = imnoise(down_im3, 'gaussian', 0 , 0.01);
imwrite(noise_im1, 'noise_im1.png')
imwrite(noise_im1, 'noise_im2.png')
imwrite(noise_im1, 'noise_im3.png')
subplot(3,1,1);
imshow(noise_im1)
subplot(3,1,2);
imshow(noise_im2)
subplot(3,1,3);
imshow(noise_im3);

figure();

%% matrix 
shape = size(noise_im1)*step;
mask = zeros(shape);
mask1 = zeros(shape);
mask2 = zeros(shape);
mask3 = zeros(shape);
sum_im =  zeros(shape);


mask1(1:step : size_(1), 1:step:size_(2)) = 1;
mask1 = imtranslate(mask1,transl_list(1 ,:));

im_sum1 = mask1 ;
im_sum1(im_sum1>0.5) = noise_im1;

mask2(1:step : size_(1), 1:step:size_(2)) = 1;
mask2 = imtranslate(mask2,transl_list(2 ,:));

im_sum2 = mask2 ;
im_sum2(im_sum2>0.5) = noise_im2;

mask3(1:step : size_(1), 1:step:size_(2)) = 1;
mask3 = imtranslate(mask3,transl_list(3 ,:));

im_sum3 = mask3 ;
im_sum3(im_sum3>0.5) = noise_im3;

im_sum = uint8(im_sum1 + im_sum2 +im_sum3);
mask = or(mask1, or(  mask2 ,  mask3));
imshow(im_sum)
figure();
imshow(mask);
imwrite(im_sum, 'degraded_lena.jpg');

imwrite(mask, 'mask.png')

