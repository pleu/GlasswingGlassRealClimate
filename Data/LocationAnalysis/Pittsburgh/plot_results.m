clear;
clf;
glass = readtable('Glass.csv', 'Delimiter', ';');
GRIN = readtable('GRIN.csv', 'Delimiter', ',');
thinFilm = readtable('ThinFilm.csv', 'Delimiter', ';');

figure(1);
clf;
%plot(glass.Tilt, glass.Azimuth, '-');
glass.Azimuth = glass.Azimuth + 180;
GRIN.Azimuth = GRIN.Azimuth + 180;
thinFilm.Azimuth = thinFilm.Azimuth + 180;
contour_plot(glass.Tilt, glass.Azimuth, glass.EArray);
colorbar;

figure(2);
clf;
contour_plot(thinFilm.Tilt, thinFilm.Azimuth, 100*(thinFilm.EArray-glass.EArray)./glass.EArray);
%caxis([0 0.05])
colorbar
caxis([3.5 9])

figure(3);
clf;
contour_plot(GRIN.Tilt, GRIN.Azimuth, 100*(GRIN.EArray-glass.EArray)./glass.EArray);
colorbar
caxis([3.5 9])
%caxis([0 0.09])
