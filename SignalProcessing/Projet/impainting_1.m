y = imread('degraded_lena.jpg');
addpath('toolbox_signal');
addpath('toolbox_general');
% parameters
rho = 1;
Gamma = rand(512)>rho;
Pi = @(f)f.*(1-Gamma) + double(y).*Gamma;
Delta = @(f)div(grad(f));
tau = .2;
niter = 10;
E = [];
k = 1; ndisp = [1 5 10 niter];
norm1 = @(f)norm(f(:));

f = double(y);
for i=1:niter
    i
    E(i) = norm1(grad(f));
    f = Pi( f + tau*Delta(f) );
    if i==ndisp(k)
        imageplot(f, ['iter=' num2str(i)], 2, 2, k);
        k = k+1;
    end
    
end
figure;

subplot(1,2,1);
imageplot(f)
subplot(1,2,2);
imageplot(double(y));

figure;
plot(E); axis('tight');
set_label('Iteration #', 'E');


imwrite(uint8(f), 'impainted_lena.jpg')
