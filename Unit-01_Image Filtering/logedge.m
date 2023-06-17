function window = logedge(sigma)
%LOGEDGE Laplacian-of-gaussian edge detector

n = 2 * ceil(3*sigma) + 1; % Calculate n as per rule of thumb from lectures
window = zeros([n, n]); % Initialise window matrix
d = floor(n/2);

% Calculate weight for each pixel in window
for x = -d : d
    for y = -d : d
        f = -(x^2 + y^2) / (2 * sigma^2);
        window(x + d + 1, y + d + 1) = -1/(pi * sigma^4) * (1 + f) * exp(f);
    end
end

end