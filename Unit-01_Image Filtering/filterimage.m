function [newImg, pre] = filterimage(img, f, se, edgemode)
%FILTERIMAGE Performs an arbitrary filtering operation on the given image
%
%   Inputs:
%
%   img - The image to be filtered
%
%   f - A handle to the filter function to be applied. This should
%   accept an array of inputs of arbitrary size (potentially with NaN
%   values) corresponding to the window and return a value for the
%   resulting pixel in the output image.
%
%   se - A structuring element, as an array of logical values (can be
%   defined manually or using the Neighbourhood property of a strel object)
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

% Store image dimensions
% This should be done before pre-processing as we need the dimensions as
% given, not with padding
imgsize = size(img);

% Convert logical structuring element to a numerical array of 1s and NaNs
% We're using NaN here because 0 could reasonably be a pixel in the image,
% so for non-square structuring elements we need a way to define which
% parts of the array are to be excluded
se = double(se); % Convert logicals to doubles
se(~se) = NaN; % Replace zeros with NaNs

%% Pre-processing

windowsize = size(se); % Store dimensions of structuring element
pad = floor(windowsize / 2); % Calculate padding amounts in x and y

if edgemode == "discard" || edgemode == "black" % Discard is special as it reduces the image size
    imgsize = imgsize - windowsize + 1;
end

newImg = zeros(imgsize);

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

% Unlike the linear filter implementation, this generic one is done in the
% usual way of iterating through each image pixel in turn.

% For each pixel in the input image...
for x = 1:imgsize(1)
    for y = 1:imgsize(2)
        % Construct the window array with the actual values from the image,
        % but only if the structuring element has a 1 at that position
        % The nice thing about NaNs is that any calculation involving them
        % still results in NaN, so this is a one-liner
        window = se .* img(x : x + windowsize(1) - 1, y : y + windowsize(2) - 1);
        % Now process the neighbourhood defined above to get the value of
        % pixel (x, y) in the output image
        newImg(x, y) = f(window); % f is a handle to the filter function
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