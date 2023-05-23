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

polarplot3d(Z', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', deg2rad([yUnique(1) yUnique(end)]), 'radialrange', [xUnique(1) xUnique(end)],...
 'ColorData', Z', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw', 'tickspacing', 45);
set(gca, 'XAxisLocation','top',...
  'yaxislocation', 'left');

%       polarplot3d(zValues(:, ind)', 'plottype','contourf','ContourLines', numContourLines, 'angularrange', y'*pi/180, 'radialrange', [200 1000],...
%         'ColorData', zValues', 'interpmethod', 'nearest', 'polargrid',{9 18}, 'polardirection', 'cw');
%
%set(gca,axprop{:});
%xlabel(xLabel);

%polarplot3d(obj(i).NormalizedIntensity, 'plottype','surfcn','angularrange', theta, 'radialrange', phi,...
%  'ColorData', log(obj(i).NormalizedIntensity), 'interpmethod', 'nearest', 'polargrid',{9 9});

end


