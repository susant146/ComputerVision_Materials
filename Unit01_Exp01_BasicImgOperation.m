% Run Individual Codes. 
% Starting of Each code, Number is mentioned.
% Run Individual Codes in MATLAB.
% Author: Dr. Susant Kumar Panigrahi
% Assistant Professor Grade-01
% School of Electrical and Electronics Engineering (SEEE)
% VIT Bhopal University.
% Version - 01 [Will be Updated in Future. More codes will be added.]



% -------- 1. Reading an Image ---------
im=imread('Test Images\cameraman.tif');
imwrite(im, gray(256), 'b.bmp');
imshow('b.bmp')% imshow is used to display image
imwrite (im, 'cameraman.png');

% --------- 2. Imtool: Open Image Viewer app -----------------
clear; close all; clc;
% imtool('board.tif');
im = imread('board.tif');
% im = imread('Test Images\cameraman.tif'); % Display a grayscale image.
% h = imtool(I,[0 80]); %Display a grayscale image, adjusting the
display range.
% close(h)
imtool(im);
im_Max = max(max(im(:,:,1)))
im_Min = min(min(im(:,:,1)))
imtool(im, [im_Min im_Max]);
imtool(im, [0 120]);

% ------- 3. Basic Image Pre-Processing Examples ------
% ----------------------------------------

im = imread("Test Images\I23.BMP"); Read a color or RGB Image
% Convert image to grayscale ---
im_gray = rgb2gray(im);

figure,
imshow(im_gray, [])
title('Gray-scale Image')

% Resized image.
im_512 = imresize(im, [512,512]);
figure,
imshow(im_512, [])
title('RGB Image- Resized to 512 \times 512')

% Color Space Conversion. 
im_yuv = rgb2yuv(im);

figure,
imshow(im_yuv, [])
title('Uncorrelated Color Space: YUV')

% Thresholed Image. [Converting to Binary Image]
im_bw = im_gray>120;
im_bw1 = imbinarize(im_gray);
figure,
imshow([im_bw, im_bw1], [])
title('Binary Image: Using Thresholding')

%% Image Edge Detection. 
im_fp = double(rgb2gray(imread('image_0040.jpg')));
im_fp1 = im_fp + 30*randn(size(im_fp));

% Always advised to perform denosing before Edge Detection.
im_fpDenosie = imnlmfilt(im_fp1);
figure, imshow([im_fp, im_fpDenosie], [])
title('Noisy and Denoised Image')

% Edge Detection. Canny Edge Detection.
imEdge1 = edge(im_fp1,"sobel");
imEdge2 = edge(im_fpDenosie, "sobel");
figure, imshow([imEdge1, imEdge2], [])
title('Sobel Edge: Noisy & Denoised Image')
