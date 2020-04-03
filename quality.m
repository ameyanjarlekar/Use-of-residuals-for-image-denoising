function qual_val = quality(y_img, d_img, sigma2)
    r_img = y_img - d_img;
    r2_bar = mean(r_img.^2, 'all');
    s_yr = mean((y_img - mean(y_img, 'all')).*(r_img - mean(r_img, 'all')), 'all');
    mse = r2_bar + sigma2 - 2 * min(r2_bar, min(s_yr, sigma2));
    qual_val = 10*log10((255)^2/mse);
end