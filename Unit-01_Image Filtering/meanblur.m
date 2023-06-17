function window = meanblur(n)
%MEANBLUR Mean blur filter (linear window)
%   Constructs a window of mean blur weights of size n*n, where all weights
%   are equal and sum to 1, for use with linear filter functions.

window = ones([n, n]) / (n^2);

% 3x3 mean filter
% window = [
%     1/9, 1/9, 1/9;
%     1/9, 1/9, 1/9;
%     1/9, 1/9, 1/9
% ];

% 5x5 mean filter
% window = ones([5, 5]) / 25;

end
