function [psnr_strength] = my_psnr(residual,initial,sigma2)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r2_bar = mean(residual.^2, 'all');
s_yr = mean((initial - mean(initial, 'all')).*(residual - mean(residual, 'all')), 'all');
mse = r2_bar + sigma2 - 2 * min(r2_bar, min(s_yr, sigma2));
psnr_strength = 10.0*log10(255^2/mse);
end

