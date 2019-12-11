close all;
clear all;
im = imread("lena.png");

im = rgb2gray(im);



mask = ones(5,5);
imconv = conv2(im, mask, 'same');

max_ = max(max(imconv));
imconv = 255*(imconv/max_);
imconv = uint8(imconv);




transl_list = [ [2,0] ; [0,3] ;[2,1]]

trans_im1 = imtranslate(imconv,transl_list(1 ,:));
% subplot(3,1,1);
% imshow(trans_im1)
trans_im2 = imtranslate(imconv,transl_list(2 ,:));
% subplot(3,1,2);
% imshow(trans_im2)
trans_im3 = imtranslate(imconv,transl_list(3 ,:));
% subplot(3,1,3);
% imshow(trans_im3);



ref_img = imconv;
i=0;
list_images ={trans_im1,trans_im2,trans_im3};

trans_list_guessed = zeros(3,2);
for index=1:3
    image = list_images{index};
    max = 0;
    
    for i=0:1:3
        for j=0:1:3
           transl_im  =imtranslate(imconv,[i,j]);
           if(corr2(transl_im,image)>max)
                argmax = [i,j];
                max = corr2(transl_im,image);
            end
    end
    end
    argmax
    
    trans_list_guessed(index,:) = argmax;
 
end


if(trans_list_guessed == transl_list)
    disp('WELL GUESSED')
end
