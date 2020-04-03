%% Making use of residuals in image denoising
% We aim to demonstrate the use of residuals in the evaluation and
% improvement of the various denoising algorithms we have studied in this
% course.
% The following are the meanings of the symbols used:
% 1. $\mathbf{x}$: Original image
% 2. $\mathbf{n}$: Additive white Gaussian noise
% 3. $\sigma^2$: Noise power
% 4. $\mathbf{y}$: Noisy image
% 5. $\mathbf{d}$: Denoised image
% 6. $\mathbf{r}$: Residual of the image $(\mathbf{d}-\mathbf{y})$

%%
% We prepare the field by loading the data and adding noise to it.
x_img = imread("../images/lena_256.tif");
x_img = double(x_img);
sigma2 = 400;
y_img = x_img + sqrt(sigma2) * randn(size(x_img));
figure(1);
imshow(mat2gray(x_img));
figure(2);
imshow(mat2gray(y_img));

%% Applying first iteration of denoising
% Here we choose the algorithm being used to denoise the image $y$.
% d_img = myBilateralFilter(y_img, 6, 15, 20);
d_img = myPCADenoising(y_img);

figure(3);
imshow(mat2gray(d_img));

%%
% Now we calculate the residual image.
r_img = y_img - d_img;

%%
% Next we find out the no-reference peak signal-to-noise ratio estimate
% using the estimate provided in the paper. The estimate is given by:
%
% $$\mathrm{PSNR}(\mathbf{x}, \mathbf{d}) = 10 \log_{10}\left(
% \dfrac{L^2}{\hat{\mathrm{MSE}}(\mathbf{x}, \mathbf{d})} \right)$$
%
% The mean-squared error estimate between the denoised image and the
% original image is given by:
%
% $$ \hat{\mathrm{MSE}}(\mathbf{x}, \mathbf{d})} = \overbar{\mathbf{r^2}} +
% \sigma^2 - 2\,\min\left( \overbar{\mathbf{r^2}}, s_{\mathbf{yr}},
% \sigma^2} \right) $$
%
% where $\overbar{\mathbf{r^2}}$ is the sample mean of $\mathbf{r^2}$ and
% $s_{\mathbf{yr}}$ is the sample covariance of $\mathbf{y}$ and 
% $\mathbf{r}$.
r2_bar = mean(r_img.^2, 'all');
s_yr = mean((y_img - mean(y_img, 'all')).*(r_img - mean(r_img, 'all')), 'all');
mse = r2_bar + sigma2 - 2 * min(r2_bar, min(s_yr, sigma2));
psnr_val = 10*log10((255)^2/mse);

%% Iterative Denoising Algorithm
% We use an iterative denoising algorithm to denoise our image. The result
% is guaranteed to be atleast as good as the initially denoised image.

num_iters = 5;
y_img_array = zeros([size(x_img) num_iters]);
d_img_array = zeros([size(x_img) num_iters]);
r_img_array = d_img_array;
rd_img_array = d_img_array;
y_img_array(:,:,1) = y_img;
y_quality = zeros(num_iters, 1);
% y_quality(1) = quality(y_img, d_img, sigma2);
d_quality = zeros(num_iters, 1);

for iter = 2:num_iters
%     d_img_array(:,:,iter) = myBilateralFilter(y_img_array(:,:,iter-1), 6, 15, 20);
    d_img_array(:,:,iter) = myPCADenoising(y_img_array(:,:,iter-1));
    d_quality(iter) = quality(y_img, d_img_array(:,:,iter), sigma2);
    r_img_array(:,:,iter) = y_img - d_img_array(:,:,iter);
%     rd_img_array(:,:,iter) = myPCADenoising(r_img_array(:,:,iter));
    rd_img_array(:,:,iter) = myBilateralFilter(r_img_array(:,:,iter), 6, 15, 20);
    y_img_array(:,:,iter) = d_img_array(:,:,iter) + rd_img_array(:,:,iter);
    y_quality(iter) = quality(y_img, y_img_array(:,:,iter), sigma2);
    
    filler = 255*ones(size(d_img, 1), 10);
%     if(iter == 2)
%         rd_img_array(:,:,iter)
%     end
    rd_img = rd_img_array(:,:,iter); %*255.0/max(rd_img_array(:,:,iter), [], 'all');
    concat_img = [d_img_array(:,:,iter), filler, r_img_array(:,:,iter), ...
        filler, rd_img, filler, y_img_array(:,:,iter)];
    figure(iter+2);
    imshow(mat2gray(concat_img));
    
%     figure(8*iter+1);
%     imshow(mat2gray(d_img_array(:,:,iter)));
%     [pearsonsmatrix] =  pearsonscoeff(d_img_array(:,:,iter),y_img-d_img_array(:,:,iter));
%     figure(8*iter+2),
%     imshow(abs(pearsonsmatrix), [0,1.0]);
%     figure(8*iter+4),
%     imshow(y_img-d_img_array(:,:,iter), [-100,100]);
%     [kstestimgthresh] = kstestfun((y_img-d_img_array(:,:,iter))/20);
%     [autocorrimg] = autocorr(y_img-d_img_array(:,:,iter));
%     figure(8*iter+6),
%     imshow(kstestimgthresh, [0,1.0]);
%     figure(8*iter+7),
%     imshow(autocorrimg, [0,49.0]);
end

y_quality
d_quality

[y_qual_best, y_iter_max] = max(y_quality(2:end));
y_iter_max = y_iter_max + 1;
[d_qual_best, d_iter_max] = max(d_quality);

d_best = d_img_array(:,:,d_iter_max);

if (y_qual_best > d_qual_best)
    d_best = y_img_array(:,:,y_iter_max);
    d_qual_best = y_qual_best;
end

figure(num_iters+3);
imshow(mat2gray(d_best));

figure(num_iters+4);
imshow(mat2gray(d_img_array(:,:,num_iters)));

fprintf('Final quality value = %.4f\n\n', d_qual_best);



