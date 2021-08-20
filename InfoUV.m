% Class contains main charactiristic of RLS
% NOTE! All times measure in km [1 km] = [c*T]

classdef InfoUV
    properties
        n = 1;                      % number of coherent pulses
        t0 = 0;                     % begin time in km
        t1 = 90000;                 % finish time in km = cT
        
        Hmin = 300;                 % minimum height in km
        Hmax = 3000;                % maximum height in km
        Hstep = 0;                  % step on R axis
        
        thetaXOY = 20/180*pi;       % maximum beam deviation from normal in XOY plane
        thetaXOZ = 20/180*pi;       % maximum beam deviation from normal in XOZ plane
        Umin = 0;                   % minimum U angle
        Umax = 0;                   % maximum U angle
        Vmin = 0;                   % minimum V angle
        Vmax = 0;                   % maximum V angle
        
        nU = 40;                    % number of resolution element by U
        nV = 40;                    % number of resolution element by V
        nR = 0;                     % number of resolution element by R
        
        F = 10^(-6);                % probability of false alarm
        snr = 1.5;                  % snr on maximum distance with maximum pulse duration (magnitude)
        snrThres = 20;              % snr on the bourder of detection zone
        t_pulses = [150,300,450,600,750,...    % duration of pulses used in RLS in km
            900,1150,1200,1350, 1500,...
            1800,2250,2700];        
        %t_pulses = [600, 3000];
        
        thres = 0;                 % threshold
        prob_thres = 0.95;         % probability threshold
        
        averRSC = 1;               % average targets' Radar Cross-Section
    end
   
    methods
        function obj = InfoUV()
            obj.Umax = sin(obj.thetaXOY)*cos(0);
            obj.Vmax = sin(obj.thetaXOZ)*sin(pi/2);
            
            obj.Umin = sin(obj.thetaXOY)*cos(pi);
            obj.Vmin = sin(obj.thetaXOZ)*sin(3*pi/2);
            
            obj.Hstep = min(obj.t_pulses);
            obj.nR = round(floor(obj.Hmax./obj.Hstep));
            
            f_t = @(x,n,F)(F-igamma(sqrt(n)-1, x/sqrt(n)));
            f_thres = @(x)f_t(x,obj.n,obj.F);

            % Computing threshold
            obj.thres = fzero(f_thres,15);
        end     
        
        function res = InitSpace(obj, tar)
            res = zeros(obj.nR, obj.nU, obj.nV);

            [C,ia,ic] = unique(tar(:,4:6), 'rows');
            a_counts = accumarray(ic,1);

            szC = size(C);    
            for i=1:szC(1)
                 res(C(i,1),C(i,2),C(i,3)) = a_counts(i);
            end
        end
        
        function space = InitSpaceProb(obj, N)
            n = 4;
            sz = n*obj.nU*obj.nV;
            space = zeros(obj.nR,obj.nU,obj.nV);
            space(3:3+n-1,:,:) = N./sz.*ones(n,obj.nU,obj.nV);
        end
        
    end
end

