function [outputimg] = myPCADenoisingb(inputimg)

inputimg = padarray(inputimg,[6 6],0,'both');
[p q] = size(inputimg);
% actimage = zeros(49,1);
almostfinimage = zeros(p,q);

for i = 1:p-6
    for j = 1:q-6
                refimage = zeros(49,576);
                actimage = reshape(inputimg(i:i+6,j:j+6),[49,1]);
                l = 1;
                for s = max(1,i-15):min(p-6,i+8)
                    for t = max(1,j-15):min(q-6,j+8)
                        refimage(:,l) = reshape(inputimg(s:s+6,t:t+6),[49,1]);
                          l = l+1;
                    end
                end
                dist = sum((refimage-actimage).*(refimage-actimage));
                [~,Bsort]=sort(dist); %Get the order of B
                refimage=refimage(:,Bsort);
                reqdimg = refimage(:,1:200);
        mainimg = reqdimg*reqdimg';
        [V,D] = eig(mainimg);
        reqdeigval = actimage'*V;
%         factor = mean(eigval.*eigval)-400.0;
%         factor(factor<0) = 0;
%         factor = 1 + 400./factor;
        eigval = reqdimg'*V;
        factor = mean(eigval.*eigval)-400.0;
        factor(factor<0) = 0;
        factor = 1 + 400./factor;
        reqdeigval = reqdeigval./factor;
        newimg = V*reqdeigval';

         almostfinimage(i:i+6,j:j+6) =almostfinimage(i:i+6,j:j+6) + reshape(newimg,[7,7]);
    end
end
almostfinimage = almostfinimage/49.0;
outputimg = almostfinimage(7:end-6,7:end-6);
end

