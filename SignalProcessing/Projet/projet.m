close all;
im =  imread("lena.png");
imshow(im);
figure();


im = rgb2gray(im);
imshow(im);
figure();

%% DOWNSAMPLING AND TRANSLATING
% A IMPLEMENTER AVEC IMTRANSLATE

% im_low_1_0 = imtranslate(im ,[1,0]);
% 
% im_low_2_0 = imtranslate(im ,[2,0]);
% im_low_3_0 = imtranslate(im ,[3,0]);
% im_low_4_0 = imtranslate(im ,[4,0]);
% 
% 
% im_low_0_1 = imtranslate(im ,[0,1]);
% im_low_0_2 = imtranslate(im ,[0,2]);
% im_low_0_3 = imtranslate(im ,[0,3]);
% im_low_0_4 = imtranslate(im ,[0,4]);
% 
% 
% imshow(im_low_0_4);
% figure();
% list_image = [im_low_1_1 , im_low_2_1 , im_low_3_1 , im_low_4_1 ,  im_low_1_2 ,im_low_1_3 , im_low_1_4];


shiftX = 1; % shift columns
shiftY = 0; % shift rows



%% CONVOLUTIONAL FILTERING

%for image = [list_image]
 %   image = (image,[5 5]);
%end