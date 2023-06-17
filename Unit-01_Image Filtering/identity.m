function window = identity(n)
%IDENTITY Do-nothing filter (linear window)
%   Constructs a window of size n*n that retains the original pixel values
%   when applied (consisting of a 1 in the centre and 0 everywhere else).

window = zeros([n, n]);
window(ceil(n/2), ceil(n/2)) = 1;

end