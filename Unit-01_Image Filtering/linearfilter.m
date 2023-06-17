function [newImg, pre] = linearfilter(img, window, edgemode)
%LINEARFILTER Performs a linear filtering operation on the given image
%
%   Inputs:
%
%   img - The image to be filtered
%
%   window - The window function describing the filter to be applied;
%   should be an odd-sized square matrix. Various functions to generate
%   different types of windows are available, see the linear_windows
%   folder.
%
%   edgemode - Specifies how to treat edges. Valid edge modes:
%   "discard"  Discards the edges entirely, cropping the image
%   "black"    Sets edge pixels to zero in the resulting image
%   "extend"   Duplicates the values at the edges to fill the window
%   "wrap"     Copies values from the opposite side of the image to fill
%              the window
%   "reflect"  Mirrors the pixel values along the borders to fill the
%              window
%
%   Outputs:
%
%   newImg - The resulting filtered image
%
%   pre - The image after pre-processing, but before the filter is applied
%
% N.B. This implementation of linear filters uses vectorisation to make the
% code more efficient. Linear filter windows can also be converted to
% function handles using the linearwindow function for use with the
% generalised filter function, at the expense of vectorisation.

%% Pre-processing

d = size(window); % Store dimensions of window
pad = floor(d / 2); % Calculate padding amounts in x and y

if edgemode == "discard" || edgemode == "black" % Discard is special as it reduces the image size
    newImg = zeros(size(img) - d + 1);
else
    newImg = zeros(size(img));
end

switch edgemode
    case "discard"
        % No padding needed, discard reduces the image size
    case "black"
        % Padding done after the filter is applied
    case "extend"
        % Pad in x and then in y
        img = [repmat(img(1, :), pad(1), 1); img; repmat(img(end, :), pad(1), 1)];
        img = [repmat(img(:, 1), 1, pad(2)), img, repmat(img(:, end), 1, pad(2))];
    case "wrap"
        % Pad in x and then in y
        img = [img(end - pad(1) + 1 : end, :); img; img(1:pad(1), :)];
        img = [img(:, end - pad(2) + 1 : end), img, img(:, 1:pad(2))];
    case "reflect"
        % Pad in x and then in y
        img = [flip(img(1:pad(1), :), 1); img; flip(img(end - pad(1) + 1 : end, :), 1)];
        img = [flip(img(:, 1:pad(2)), 2), img, flip(img(:, end - pad(2) + 1 : end), 2)];
    otherwise
        error("Invalid edge mode!");
end

pre = img; % Output pre-processed image for debugging / demonstration

%% Filtering

% Rather than looping through each pixel of the image, here we're looping
% through each element in the window, shifting the entire image accordingly
% and multiplying it by the weight at that position, and adding the result
% to the output. This can be thought of as stacking up copies of the image,
% with each one offset slightly from the others.

% In MATLAB, this is a much more efficient method as the number of loop
% iterations is equal to the number of elements in the window rather than
% the number of pixels in the image. However, it only works for linear
% filters because the positions in the window are processed sequentially,
% so filters such as ordered statistics cannot be done this way.

% For each element in the window...
for x = 1:d(1)
    for y = 1:d(2)
        % ... add a weighted, offset copy of the original to the output
        % This looks a bit convoluted (pun intended) but it's worth it!
        newImg = newImg + window(x, y) * img(x:end-d(1)+x, y:end-d(2)+y);
    end
end

%% Post-processing

% If edge mode is "black", pad the image back to original size with zeros
if edgemode == "black"
    oldImg = newImg;
    newImg = zeros(size(img));
    newImg(pad(1) + 1 : end - pad(1), pad(2) + 1 : end - pad(2)) = oldImg;
end

end