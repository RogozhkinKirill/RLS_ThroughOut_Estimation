function t = FindTargetsInBeam(nR, targets, beam, res)
    [r, angle] = find(beam == 1);
    r = nR - r + 1;
    sz = size(beam);

    if numel(sz) == 1
        sz(2) = 1;
        sz(3) = 1;
    end
    if numel(sz) == 2
        sz(3) = 1;
    end
    
    t = find(targets(:,4)>=min(r) & targets(:,4)<=max(r) &...
             targets(:,5)>=res(6) & targets(:,5)<=res(6)+sz(2)-1 & ...
             targets(:,6)>=res(7) & targets(:,6)<=res(7)+sz(3)-1);
end

