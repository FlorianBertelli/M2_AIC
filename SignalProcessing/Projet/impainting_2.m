close all;
clear all;

y = imread('degraded_lena.jpg');
addpath('toolbox_signal');
addpath('toolbox_general');

% parameters
rho = 1;
Gamma = rand(512)>rho;
Pi = @(f)f.*(1-Gamma) + double(y).*Gamma;
epsilon = 1;
Amplitude = @(u)sqrt(sum(u.^2,3)+epsilon^2);
Neps = @(u)u./repmat(Amplitude(u), [1 1 2]);
tau = .9*epsilon/4;
G = @(f)-div(Neps(grad(f)));


niter = 400;
J = [];
k = 1; ndisp = ceil(niter*[.001 1/10 1/5 1/4 1/3 1/2 2/3 1]);
f = double(y);
for i=1:niter
    i
    %grad_ = grad(f)
    J(i) = sum(sum(Amplitude(grad(f))));
    f = Pi( f - tau*G(f) );
    if i==ndisp(k)
        imageplot(f, ['iter=' num2str(i)], 4, 2, k);
        k = k+1;
    end
end
figure;

subplot(1,2,1);
imageplot(f)
subplot(1,2,2);
imageplot(double(y));
