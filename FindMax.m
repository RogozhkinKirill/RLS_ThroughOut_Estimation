% 
% out = [maximum, iR,iU,iV] 
%
function [maximum, ind] = FindMax(arr)
    sz = size(arr);
    dim = ndims(arr);
    
    [maximum,I] = max(arr(:));
    
    if dim == 1
        ind = ind2sub(sz,I);
    elseif dim == 2
        [ind1, ind2] = ind2sub(sz,I);
        ind = [ind1, ind2];
    else
        [ind1, ind2, ind3] = ind2sub(sz,I);
        ind = [ind1, ind2, ind3];
    end
end

