clc, clear 'all', close 'all'

N = 1000;

info = InfoUV()
beams = InitBeams(info, 10^10);
space = info.InitSpaceProb(N);

%%
lst = InitBeamsList(info, beams);

%%
tic
for i=1:numel(lst)
    convn(space,lst{i}{1},'valid');
end
toc 
