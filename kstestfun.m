function [kstestimgthresh] = kstestfun(residualimg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[p q] = size(residualimg);
kstestimg = zeros(p-14,q-14);
kstestimgthresh = zeros(p-14,q-14);

for i = 8:p-7
    for j = 8:q-7
        residualref = residualimg(i-7:i+7,j-7:j+7);
        kstestimgthresh(i-7,j-7)= kstest(residualref);
    end
end
end

