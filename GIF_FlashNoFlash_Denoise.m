% Guided Image Filtering: MATLAB-2020b
%% Perform Flash/No-flash Denoising with Guided Filter
close all
clc 
clear
% Read an image
%% No Flash Image
A = imread('toysnoflash.png');
figure;
imshow(A);
title('Input Image - Camera Flash Off')

%% Flash Image --- (More Detila Less Ambiance)
G = imread('toysflash.png');
figure;
imshow(G);
title('Guidance Image - Camera Flash On')

%% Guided Image Filtering 
nhoodSize = 3;
smoothValue  = 0.001*diff(getrangefromclass(G)).^2;
B = imguidedfilter(A, G, 'NeighborhoodSize',nhoodSize, 'DegreeOfSmoothing',smoothValue);
figure, imshow(B), title('Filtered Image')

