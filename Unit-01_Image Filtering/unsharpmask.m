function window = unsharpmask(n)
%UNSHARPMASK Unsharp mask filter (linear window)
%   Constructs a window of unsharp mask weights of size n*n for use with
%   linear filter functions. This is a simple, non adaptive implementation
%   with a fixed value of k.

window = -ones(n) / n^2; % Make all values equal and sum to -1
m = ceil(n/2);
window(m, m) = 2 - 1 / n^2; % Change central value so the sum is now 1

end