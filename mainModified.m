clc, clear 'all', close 'all'

N = 100*(1:15);  
%N = 100*(22:27);
ITERATIONS = 50;
  
info = InfoUV()
beams = InitBeams(info, 10^10);

%% 
        
mnt =       zeros(1,numel(N));
mnctr =     zeros(1,numel(N));
dropedTar = zeros(1,numel(N));

dismnt = zeros(1,numel(N));
disctr = zeros(1,numel(N));

h = createfigure(N, mnt);

for ni=1:numel(N)
    %mode = ["horizontal"; "above"];
    mode = ["above"];
    resModel = zeros(ITERATIONS,4);

    for md = 1:numel(mode)
        tic
        parfor iter=1:ITERATIONS 
            All_targets = InitTargets(N(ni),info, [1,1],mode(md));
            space =   InitSpace(info, All_targets);
            timeLine = zeros(1, info.nR);


            targets = All_targets;
            nTar = sum(space, 'all');
            t = 0;
            counter = 0;
            %while (nTar ~= 0) && (t < info.t1/info.Hstep)
            while (nTar ~= 0)
                res = FindMaxInConv(space, beams);
                duration = beams{res(3),res(4)}{2};

                tar = FindTargetsInBeam(info.nR, targets, beams{res(3),res(4)}{1},res);
                [nR, nU, nV] = size(beams{res(3),res(4)}{1});
                indexDetected = find(rand(numel(tar),1) < pd(Propogation(targets(tar,1),...
                                                             targets(tar,7),...
                                                             info,...
                                                             min(info.t_pulses)*duration,...
                                                             PatternLoss(size(beams{res(3),res(4)}{1})),...
                                                             1),...
                                                             info.F, info.thres));

                % detected targets
                tmp = targets(tar,:);
                tarDetected = tmp(indexDetected,:);
                
                % remove detected targets
                detectedSpace = InitSpace(info, tarDetected);
                targets(tar(indexDetected),:) = 0;
                space = space - detectedSpace;

                % unique element of Rad of targets
                uniR = unique(tarDetected(:,4));
                
                maxDistance = max(targets(tar,4));
                if isempty(maxDistance)
                    t = t + duration;
                else
                    t = t + 2 * maxDistance(1,1) + duration;
                end

                
                
                counter = counter + 1;
                nTar = sum(space, 'all');
            end

            resModel(iter,:) = [iter,counter,t,nTar];
        end
        toc
        
        mnt(ni) =       info.Hstep./300.*mean(resModel(:,3));
        mnctr(ni) =     mean(resModel(:,2));
        dropedTar(ni) = mean(resModel(:,4));
        
        h.YData = mnt;
        drawnow;
    end
end

%%
createfigure(N, dropedTar, 'N, targets', 'dropped targets');
createfigure(N, mnt  ,     'N, targets', 'time, ms');
createfigure(N, mnctr,     'N, targets', 'iterations');
