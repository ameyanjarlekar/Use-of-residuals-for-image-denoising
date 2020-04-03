%% MyMainScript

tic;
%% Part a: stream
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\stream.png');
inputimg = double(inputimg);
inputimg1 = inputimg +randn(size(inputimg))*20.0;
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoising(inputimg1);
figure(2),
imshow(output, [0,255.0]);
error_now = sum(sum((output-inputimg).*(output-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
%% Part a: barbara
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\barbara256.png');
inputimg = double(inputimg);
sigma2 = 400.0;
inputimg1 = inputimg +randn(size(inputimg))*sqrt(sigma2);
figure(1), 
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoising(inputimg1);
% figure(2),
% imshow(output, [0,255.0]);
% [pearsonsmatrix] =  pearsonscoeff(output,inputimg1-output);
% figure(3),
% imshow(abs(pearsonsmatrix), [0,1.0]);
% figure(4),
% imshow(inputimg1-output, [-100,100]);
% [kstestimgthresh] = kstestfun((inputimg1-output)/20);
% [autocorrimg] = autocorr(inputimg1-output);
% 
% figure(6),
% imshow(kstestimgthresh, [0,1.0]);
% figure(7),
% imshow(autocorrimg, [0,49.0]);
error_now = sum(sum((output-inputimg).*(output-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
[psnr_strength] = my_psnr(inputimg1-output,inputimg1,sigma2)
out = psnr(uint8(output),uint8(inputimg))
%% Part b: barbara
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\barbara256.png');
inputimg = double(inputimg);
sigma2 = 400.0;
inputimg1 = inputimg +randn(size(inputimg))*sqrt(sigma2);
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoisingb(inputimg1);
% figure(2),
% imshow(output, [0,255.0]);
% [pearsonsmatrix] =  pearsonscoeff(output,inputimg1-output);
% figure(3),
% imshow(abs(pearsonsmatrix), [0,1.0]);
% figure(4),
% imshow(inputimg1-output, [-100,100]);
% [kstestimgthresh] = kstestfun((inputimg1-output)/20);
% [autocorrimg] = autocorr(inputimg1-output);
% 
% figure(6),
% imshow(kstestimgthresh, [0,1.0]);
% figure(7),
% imshow(autocorrimg, [0,49.0]);
error_now = sum(sum((output-inputimg).*(output-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
[psnr_strength] = my_psnr(inputimg1-output,inputimg1,sigma2)
out = psnr(uint8(output),uint8(inputimg))
%%  Part b: stream
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\stream.png');
inputimg = double(inputimg);
inputimg1 = inputimg +randn(size(inputimg))*20.0;
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoisingb(inputimg1);
figure(2),
imshow(output, [0,255.0]);
error_now = sum(sum((output-inputimg).*(output-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
%% barbara with bilateral filtering
% thus observing the RMSE, PCA based approach is better than bilateral
% filtering approach in terms of better quality of image
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\stream.png');
inputimg = double(inputimg);
sigma2 = 400.0;
inputimg1 = inputimg +randn(size(inputimg))*sqrt(sigma2);
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myBilateralFilter(inputimg1, 6, 45, 35);
output(1:10,1:10)
figure(2),
imshow(output, [0,255.0]);
% [pearsonsmatrix] =  pearsonscoeff(output,inputimg1-output);
% [autocorrimg] = autocorr(inputimg1-output);
% figure(3),
% imshow(abs(pearsonsmatrix), [0,1.0]);
% figure(4),
% imshow(inputimg1-output, [-100,100]);
% [kstestimgthresh] = kstestfun((inputimg1-output)/20);
% figure(6),
% imshow(kstestimgthresh, [0,1.0]);
% figure(7),
% imshow(autocorrimg, [0,49.0]);
error_now = sum(sum((output-inputimg).*(output-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
[psnr_strength] = my_psnr(inputimg1-output,inputimg1,sigma2)
out = psnr(uint8(output),uint8(inputimg))
[ssimarray,ssimval] = ssim_fun(inputimg1,output,sigma2,5);
ssimval
[theirssimval theirssimarray] = ssim(output,inputimg);
theirssimval
figure(8),
imshow(ssimarray, [-10.0,10.0]);
figure(9),
imshow(theirssimarray, [-10,10.0]);
%% barbara with poisson 
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\barbara256.png');
inputimg = double(inputimg);
inputimg1 = poissrnd(inputimg);
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoisingb(sqrt(inputimg1+0.375));
finoutput = output.*output - 0.375;
figure(2),
imshow(finoutput, [0,255.0]);
error_now = sum(sum((finoutput-inputimg).*(finoutput-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
%% stream with poisson 
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\stream.png');
inputimg = double(inputimg);
inputimg1 = poissrnd(inputimg);
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoisingb(sqrt(inputimg1+0.375));
finoutput = output.*output - 0.375;
figure(2),
imshow(finoutput, [0,255.0]);
error_now = sum(sum((finoutput-inputimg).*(finoutput-inputimg)))/sum(sum(inputimg.*inputimg))
error_prev = sum(sum((inputimg1-inputimg).*(inputimg1-inputimg)))/sum(sum(inputimg.*inputimg))
%% barbara with poisson low intensity
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\barbara256.png');
inputimg = double(inputimg/20.0);
inputimg1 = poissrnd(inputimg);
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoisingb(sqrt(inputimg1+0.375));
finoutput = output.*output - 0.375;
figure(2),
imshow(finoutput, [0,255.0]);
error_now = sum(sum((finoutput-inputimg).*(finoutput-inputimg)))/sum(sum(inputimg.*inputimg))
%% stream with poisson low intensity
% RMSE is higher in case of low intensity. This is because the ratio of
% signal intensity to noise intensity has decreased hence noise would
% affect the quality of image more in 2nd case
inputimg = imread('C:\Users\Ameya\Desktop\cs 663 dip\HW5\stream.png');
inputimg = double(inputimg/20.0);
inputimg1 = poissrnd(inputimg);
figure(1),
imshow(inputimg1, [0,255.0]);
[output] = myPCADenoisingb(sqrt(inputimg1+0.375));
finoutput = output.*output - 0.375;
figure(2),
imshow(finoutput, [0,255.0]);
error_now = sum(sum((finoutput-inputimg).*(finoutput-inputimg)))/sum(sum(inputimg.*inputimg))
% part e answer is in the scanned documents
%%
toc;