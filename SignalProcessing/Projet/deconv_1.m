clear all;
close all;
addpath('toolbox_signal');
addpath('toolbox_general');
s=5
x = [0:512/2-1, -512/2:-1];
[Y,X] = meshgrid(x,x);
h = exp( (-X.^2-Y.^2)/(2*s^2) );
h = h/sum(h(:));
% h = zeros(512,512);
% for i=1:s
%  for j=1:s
%      h(i ,j) = 1;
%  end
% end

hF = real(fft2(h));
imageplot(fftshift(hF), 'Fourier transform');

y = imread('impainted_lena.jpg');
y_true = imread('lena.png');
y_true = rgb2gray(y_true);

yF = fft2(y);

figure;
n_iter = 1000
imageplot(fftshift(yF), 'Fourier transform of lena');
SNR_list = zeros(n_iter,1);

for lambda_=1:n_iter
    lambda = lambda_ /n_iter;

    fL2 = real( ifft2( yF .* hF ./ ( abs(hF).^2 + lambda) ) );
    snr(double(y_true),fL2);
    SNR_list(lambda_)= snr(double(y_true),fL2);
   
end;

figure;
plot(SNR_list); axis('tight');
set_label('LAMBDA 1e3', 'SNR');
[argvalue, argmax] = max(SNR_list);

argmax/n_iter

lambda = argmax/n_iter;

deconv_im = real( ifft2( yF .* hF ./ ( abs(hF).^2 + lambda) ) );
figure;
imageplot(double(y), 'before deconv', 1,2,1); 
imageplot((deconv_im), 'after deconv', 1,2,2);

imwrite(uint8(50 +deconv_im), 'deconvoled.jpg')