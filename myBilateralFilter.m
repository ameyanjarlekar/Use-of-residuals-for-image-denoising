function result = myBilateralFilter(inp, kernelSize, spatial_var, intensity_var)
    
    Gs = fspecial('gaussian', [kernelSize,kernelSize], spatial_var);
    offset = floor(kernelSize/2);
    
    inp = padarray(inp, [offset, offset], 'replicate', 'both');
    
    result = zeros(size(inp));
    weights = zeros(size(inp));
    
    for row = 1 : (size(result, 1) - 2*offset)
        for col = 1 : (size(result, 2) - 2*offset)
            temp_inp = inp(row:row+kernelSize-1, col:col+kernelSize-1);
            Gr = normpdf(temp_inp, inp(row+offset, col+offset), intensity_var);
            result(row:row+kernelSize-1, col:col+kernelSize-1) = ...
                result(row:row+kernelSize-1, col:col+kernelSize-1) + ...
                inp(row+offset, col+offset) * Gs .* Gr;
            weights(row:row+kernelSize-1, col:col+kernelSize-1) = ...
                weights(row:row+kernelSize-1, col:col+kernelSize-1) + ...
                Gs .* Gr;
        end
    end
    result = result ./ weights;
    result = result(offset+1:end-offset, offset+1:end-offset);
end