function out = createfigure(x1, y1, xlab, ylab, leg)
% Create figure
figure
hold on
grid on

if nargin >= 4 
    xlabel(xlab)
    ylabel(ylab)
end

out = plot(x1,y1);

if nargin >= 5
    legend(leg)
end
hold off
