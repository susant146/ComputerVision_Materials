%% Image Denoising using Non-Local Means Filter
clear 
close all
clc

%% Read an image 
I = imread('cameraman.tif');
% add noise .... Gaussian Noise 
noisyImage = imnoise(I,'gaussian',0,0.0015);

% Denoised Image: Non Local Means Filter
[filteredImage,estDoS] = imnlmfilt(noisyImage);
montage({noisyImage,filteredImage})
title(['Estimated Degree of Smoothing, ', 'estDoS = ',num2str(estDoS)])

% Calculating PSNR Measure
disp('GrayScale Denoised Image: PSNR Measure')
psnr_NI = psnr_mes(double(I), double(noisyImage))
psnr_DI = psnr_mes(double(I), double(filteredImage))


%% Color (RGB) Image Denoising using Uncorellated Color space
imRGB = imread('peppers.png');
% Noisy Image
noisyRGB = imnoise(imRGB,'gaussian',0,0.0015);
figure, imshow(noisyRGB)
title('Noisy Image (Color)')

% Converting Image to LAB color Space
noisyLAB = rgb2lab(noisyRGB);
% Compute Noise standard Deviation
roi = [210,24,52,41];
patch = imcrop(noisyLAB,roi);

% Compute Nstd
patchSq = patch.^2;
edist = sqrt(sum(patchSq,3));
patchSigma = sqrt(var(edist(:)));

% Denoising in LAB color space
DoS = 1.5*patchSigma;
denoisedLAB = imnlmfilt(noisyLAB,'DegreeOfSmoothing',DoS);

% Lab to RGB
denoisedRGB = lab2rgb(denoisedLAB,'Out','uint8');
figure, imshow(denoisedRGB)
title('Denoised Image (Color)')

% Calculating PSNR Measure
disp('Color Denoised Image: PSNR Measure')
psnrRGB_NI = psnr_mes(double(imRGB), double(noisyRGB))
psnrRGB_DI = psnr_mes(double(imRGB), double(denoisedRGB))
