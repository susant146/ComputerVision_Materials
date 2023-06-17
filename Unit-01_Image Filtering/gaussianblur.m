function window = gaussianblur(sigma)
%GAUSSIANBLUR Gaussian blur filter (linear window)
%   Constructs a window of gaussian blur weights with standard deviation
%   sigma for use with linear filter functions. The window size is
%   calculated according to the rule of thumb n = 2 * ceil(3 * sigma) + 1.

n = 2 * ceil(3*sigma) + 1; % Calculate n as per rule of thumb from lectures
window = zeros([n, n]); % Initialise window matrix
d = floor(n/2);

% Calculate weight for each pixel in window
for x = -d : d
    for y = -d : d
        window(x + d + 1, y + d + 1) = exp(-(x^2 + y^2) / (2 * sigma^2));
    end
end

window = window / sum(window, 'all'); % Normalise to preserve overall brightness

end