function contour_plot(x, y, zValues)

numContourLines = 200;
xUnique = unique(x);
yUnique = unique(y);
[X,Y] = meshgrid(xUnique,yUnique);
Z = reshape(zValues', length(xUnique), length(yUnique))';
%Z = reshape(zValues, [length(xUnique), length(yUnique)]);
%       polarplot3d(Z, 'plottype','contourf','ContourLines', numContourLines, 'angularrange', deg2rad([yUnique(1) yUnique(end)]), 'radialrange', [xUnique(1) xUnique(end)],...
%         'ColorData', Z, 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw', varargin{:});

% [C, h] = contourf(X, Y, Z, numContourLines);
% shading flat;
% set(h, 'edgecolor', 'none');

polarplot3d(Z', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', deg2rad([yUnique(1) yUnique(end)]), 'radialrange', [0 90],...
 'ColorData', Z', 'radlabels', 7, 'compass', 'yes', 'radlabellocation', {180 180}, 'radlabelcolor', 'k', 'gridcolor', 'k', 'interpmethod', 'nearest', 'polargrid',{8 16}, 'polardirection', 'cw', 'tickspacing', 45, 'radialtickspacing', [15, 30, 45, 60, 75]);
%set(gca, 'XAxisLocation','top',...
%  'yaxislocation', 'left');
%set(gca,'XTick',[])
h = gca; h.XAxis.Visible = 'off'; h.YAxis.Visible = 'off';
%set(gca, 'XTick', [-90 -60 -30 0 30 60 90])
%set(gca, 'XTickLabel', {'', '', '', '0', '30', '60', '90'})
ax = get(gca);
ax.XAxis.MinorTickValues = -90:10:90;
set(gca, 'XLim', [-110 110]);

%set(gca, 'XAxis.MinorTickValues', -90:10:90);
%ax.XAxis.MinorTickValues

%       polarplot3d(zValues(:, ind)', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', y'*pi/180, 'radialrange', [200 1000],...
%         'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw');
%
%set(gca,axprop{:});
%xlabel(xLabel);

%polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
%  'ColorData', log(obj(i).NormalizedIntensity), 'interpmethod', 'nearest', 'polargrid',{9 9});

end


