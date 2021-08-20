function DrawResults(resModel)
    createfigure(resModel(:,1),resModel(:,2), 'iter', 'counter')    
    createfigure(resModel(:,1),resModel(:,3), 'iter', 'time')
    createfigure(resModel(:,2),resModel(:,3), 'counter', 'time')

    figure 
    histogram2(resModel(:,2),resModel(:,3),'FaceColor','flat')

    figure 
    histogram(resModel(:,2), 'all'))
    %%
    figure 
    histogram(resModel(:,3), 'all'))
end

