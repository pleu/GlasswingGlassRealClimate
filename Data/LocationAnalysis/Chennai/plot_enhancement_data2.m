clear;
clf;
load Chennai.csv
azimuth = [90 135 180 225 270]*2*pi/360;

filmAR = Chennai(1,:);
GRINAR = Chennai(2,:);

radialrange = [0 10];
radialtickspacing = 0:1:10;
polarplot2d(azimuth, filmAR, 'angularrange', [90 270]/360*2*pi, 'polardirection', 'cw', 'radlabels', 4, 'radlabellocation', {180 180}, 'radialrange', radialrange, 'radialtickspacing', radialtickspacing, 'linecolor', 'g');
hold on;
polarplot2d(azimuth, GRINAR, 'angularrange', [90 270]/360*2*pi, 'polardirection', 'cw', 'radlabels', 4, 'radlabellocation', {180 180}, 'radialrange', radialrange, 'radialtickspacing', radialtickspacing, 'linecolor', 'b');

%ax.YLim = [-4 0]
set(gca, 'YLim', [-10.2 0])
set(gca, 'XLim', [-10.2 10.2])

xlabel('% Improvement');

%p = get(gca, 'children')
%%legend([p(2), p(3)], 'Film', 'GRIN', 'Location', 'Best');
%h = findobj(gca,'Type','line');


blueLine = findobj(gca,'Color',[0 0 1]);
greenLine = findobj(gca,'Color',[0 1 0]);

legend([greenLine, blueLine], 'Film', 'GRIN', 'Location', 'Best');
legend boxoff;