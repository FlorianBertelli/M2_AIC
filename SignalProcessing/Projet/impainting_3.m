clear all;
close all;
%y = imread('degraded_lena.jpg');

y_true = imread('lena.png');
y_true = double(rgb2gray(y_true));

addpath('toolbox_signal');
addpath('toolbox_general');

% parameters
Omega = double(~imread('mask.png'));

n = 512;
Phi = @(f,Omega)f.*(1-Omega);
y = double(Phi(y_true,Omega));
SoftThresh = @(x,T)x.*max( 0, 1-T./max(abs(x),1e-10) );
Jmax = log2(n)-1;
Jmin = Jmax-3;
options.ti = 0; % use orthogonality.
if using_matlab()
    Psi = @(a)perform_wavelet_transf(a, Jmin, -1,options);
    PsiS = @(f)perform_wavelet_transf(f, Jmin, +1,options);
end
SoftThreshPsi = @(f,T)Psi(SoftThresh(PsiS(f),T));
lambda = 1;
ProjC = @(f,Omega)Omega.*f + (1-Omega).*y;
fSpars = y;
fSpars = ProjC(fSpars,Omega);

fSpars = SoftThreshPsi( fSpars, lambda );

fSpars = y;
energy = [];
niter = 1000;
for i=1:niter
    i
    fSpars = SoftThreshPsi( ProjC(fSpars,Omega), lambda );
    % record the energy
    fW = PsiS(fSpars);
    energy(i) = 1/2 * norm(double(y-Phi(fSpars,Omega)), 'fro')^2 + lambda * sum(abs(fW(:)));
end

h = plot(energy);
axis('tight');
set_label('Iteration', 'E');
if using_matlab()
    set(h, 'LineWidth', 2);
end

figure;
imageplot((fSpars));


