function list = InitBeamsList(info, beams)  
    sz = size(beams);
    list = {};
    
    ctr = 1;
    for i=1:sz(1)
        for j=1:sz(2)
            if ~isempty(beams{i,j})
                bsz = size(beams{i,j}{1});
                
                if numel(bsz) == 2
                    bsz(3) = 1;
                end

                for k=1:info.nU-bsz(2)+1
                    for l=1:info.nV-bsz(3)+1
                        sp = zeros(info.nR,info.nU,info.nV);
                        sp(:,k:k+bsz(2)-1,l:l+bsz(3)-1) = beams{i,j}{1};
                        
                        list{ctr} = {sp, beams{i,j}{2}};
                        ctr = ctr+1;
                    end
                end
            end
        end    
    end
end

