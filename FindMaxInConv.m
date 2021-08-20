% 
% res = [maximum, duration, i, j, iR, iU, iV] 
%
function res = FindMaxInConv(space, beams)
    conv = {};
    sz = size(beams);
    res = zeros(1,5);
    for i=1:sz(1)
        for j=1:sz(2)
            if ~isempty(beams{i,j}) 
                conv{i,j} = convn(space, beams{i,j}{1}, 'valid');

                [tmp, ind] = FindMax(conv{i,j});
                
                if numel(ind) == 2
                    ind = [ind 1];
                end
                
                if tmp > res(1,1) ||...
                   tmp == res(1,1) && (beams{i,j}{2} <= res(2) || res(2) == 0)
                    res = [tmp,beams{i,j}{2},i,j,ind];
                end
           end
        end
    end
end

