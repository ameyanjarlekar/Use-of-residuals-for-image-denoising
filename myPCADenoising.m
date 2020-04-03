function [outputimg] = myPCADenoising(inputimg)

inputimg = padarray(inputimg,[6 6],0,'both');
[p q] = size(inputimg);
refimage = zeros(49,(p-6)*(q-6));
almostfinimage = zeros(p,q);

l = 1;
for i = 1:p-6
    for j = 1:q-6
        refimage(:,l) = reshape(inputimg(i:i+6,j:j+6),[49,1]);
        l = l+1;
    end
end
mainimg = refimage*refimage';
[V,D] = eig(mainimg);
eigval = refimage'*V;
factor = mean(eigval.*eigval)-400.0;
factor(factor<0) = 0;
factor = 1 + 400./factor;
factor;
eigval = eigval./factor;
newimg = V*eigval';

l = 1;
for i = 1:p-6
    for j = 1:q-6
         almostfinimage(i:i+6,j:j+6) =almostfinimage(i:i+6,j:j+6) + reshape(newimg(:,l),[7,7]);
        l = l+1;
    end
end
almostfinimage = almostfinimage/49.0;
outputimg = almostfinimage(7:end-6,7:end-6);
end

