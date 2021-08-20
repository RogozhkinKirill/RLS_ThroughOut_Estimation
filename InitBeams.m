function beam = InitBeams(info, N)
    size = min([info.nU, info.nV, N]);
    t_max = max(info.t_pulses);
    Hstep = info.Hstep;
    Hmin =  floor(info.Hmin./info.Hstep);
    Hmax =  info.nR;
    
    for j = 1:numel(info.t_pulses)
        tPulse = floor(info.t_pulses(j)./Hstep);
        
        for i = 1:size
            if i ~= 1
                patternLoss = 0.5./(i.^2);
            else
                patternLoss = 1;
            end
            lenMax = floor(info.nR.*...
                          ((info.t_pulses(j)./t_max).*...  
                            info.snr./info.snrThres.*...
                            patternLoss)^(0.25));
            
            if lenMax > Hmin && lenMax > tPulse
                tmp = zeros(info.nR, i, i);
                %tmp([end - min(lenMax, info.nR) + 1 : end - max(Hmin,t_pulse)],:,:) = 1;

                tmp(max(tPulse,Hmin)+1:min(lenMax,Hmax),:,:) = 1;
                tmp = tmp(end:-1:1,:,:);
                % imitate radiation time
                beam{i,j} = {tmp, tPulse};
            end
        end
    end
end

