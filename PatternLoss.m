function loss = PatternLoss(beam)
    [~,nU,nV] = size(beam);
    if nU ~= 1 && nV ~= 1
        loss = 0.5./(nU*nV);
    else
        loss = 1;
    end
end

