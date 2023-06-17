%%%%.............>>>>>>>>>>>>
%%%%%%%%%%%%%% FOR CALCULATING PSNR......................
%...........EXAMPLE..............a=imread('image1.jpg');
%>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>b=imread('image2.jpg');....>> PSNR(a,b)
%%%%.......TESTED FORMULAE.............................

function psnr_Value = psnr_mes(A,B)
% PSNR (Peak Signal to noise ratio)

if (size(A) ~= size(B))
   error('The size of the 2 matrix are unequal')

   psnr_Value = NaN;
   return; 
elseif (A == B)
   disp('Images are identical: PSNR has infinite value')

   psnr_Value = Inf;
   return;   
else

    maxValue = double(max(A(:)));

    % Calculate MSE, mean square error.
    mseImage = (double(A) - double(B)) .^ 2;
    [rows columns] = size(A);
    
    mse = sum(mseImage(:)) / (rows * columns);

    % Calculate PSNR (Peak Signal to noise ratio)
    psnr_Value = 10 * log10( 256^2 / mse);
    RMSE = sqrt(mse);                                   % RMSE

end