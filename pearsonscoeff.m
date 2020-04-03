function [corrmat] = pearsonscoeff(inputimg,residualimg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[p q] = size(inputimg);
corrmat = zeros(p-14,q-14);
for i = 8:p-7
    for j = 8:q-7
        inputref = inputimg(i-7:i+7,j-7:j+7);
        residualref = residualimg(i-7:i+7,j-7:j+7);
        xmean = mean(inputref,'all');
        ymean = mean(residualref,'all');
        sxy = mean( (inputref-xmean).*(residualref-ymean),'all');
        sx = sqrt(mean( (inputref-xmean).*(inputref-xmean),'all'));
        sy = sqrt(mean( (residualref-ymean).*(residualref-ymean),'all'));
        %sxy./(sx.*sy)
        corrmat(i-7,j-7)= sxy./(sx.*sy);
    end
end
end

