function res = InitTargets(N,info,RSA_inter, pos)
    res = zeros(N, 7);
    rnd = rand(N, 4);

    
    dU = (info.Umax - info.Umin)/info.nU;
    dV = (info.Vmax - info.Vmin)/info.nV;
    dr = min(info.t_pulses);

    if nargin == 4
        if pos == "above"
            res(:,1) = info.Hmin + rnd(:,1).*(1000-info.Hmin);
        elseif pos == "horizontal"
            res(:,1) = info.Hmax/1.5 + rnd(:,1).*(info.Hmax-info.Hmax/1.5);
        else
            res(:,1) = info.Hmin + rnd(:,1).*(info.Hmax-info.Hmin);
        end
    else
        res(:,1) = info.Hmin + rnd(:,1).*(info.Hmax-info.Hmin);
    end

    res(:,2) = info.Umin + rnd(:,2).*(info.Umax-info.Umin);
    res(:,3) = info.Vmin + rnd(:,3).*(info.Vmax-info.Vmin); 

    res(:,4) = round(floor(res(:,1)./dr))+1;
    res(:,5) = round(floor((res(:,2)-info.Umin)./dU))+1;
    res(:,6) = round(floor((res(:,3)-info.Vmin)./dV))+1;

    if nargin == 3
        res(:,7) = RSA_inter(1) + rnd(:,4).*(RSA_inter(2)-RSA_inter(1));
    else
        res(:,7) = info.averRSC;
    end
       
end

