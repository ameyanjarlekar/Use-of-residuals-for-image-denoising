function [autocorrimg] = autocorr(residualimg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[p q] = size(residualimg);
autocorrimg = zeros(p-20,q-20);
for i = 11:p-10
    for j = 11:q-10
        residualref = residualimg(i-7:i+7,j-7:j+7);      
        count = 0;
        for x = -3:3
          for y = -3:3
        inputref = residualimg(i-7+x:i+7+x,j-7+y:j+7+y);
        xmean = mean(inputref,'all');
        ymean = mean(residualref,'all');
        sxy = mean( (inputref-xmean).*(residualref-ymean),'all');
        sx = sqrt(mean( (inputref-xmean).*(inputref-xmean),'all'));
        sy = sqrt(mean( (residualref-ymean).*(residualref-ymean),'all'));
        if (sxy./(sx.*sy) < 0.25) 
           count = count + 1;
        end
            end
         end
        autocorrimg(i-7,j-7)= count;
    end
end
end

