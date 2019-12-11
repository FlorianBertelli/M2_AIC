
addpath('toolbox_signal');
addpath('toolbox_general');
y = imread('impainted_lena.jpg');

noise_im1 = imread('noise_im1.png');
noise_im2 = imread('noise_im2.png');
noise_im3 = imread('noise_im3.png');

PSF = fspecial('gaussian',5,5);
noise_im1 = deconvlucy(noise_im1,PSF,5);
noise_im2 = deconvlucy(noise_im2,PSF,5);
noise_im3 = deconvlucy(noise_im3,PSF,5);
% imageplot(double(y) ,' ',1,2,1)
% imageplot(double(luc1),'',1,2,2)
% title('Restored Image')




step = 4
size_ = [512, 512]
transl_list = [ [1,0] ; [0,1] ;[1,1]]


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

