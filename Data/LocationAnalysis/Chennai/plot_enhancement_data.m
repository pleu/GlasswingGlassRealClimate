clear;
clf;
load Chennai.csv
azimuth = [-90 -45 0 45 90]*2*pi/360;

filmAR = Chennai(1,:);
GRINAR = Chennai(2,:);

polarplot(azimuth, filmAR, '-x');
hold on;
polarplot(azimuth, GRINAR, '-o');
legend('thin film', 'GRIN', 'location', 'best');
legend box off;
ax = gca;
ax.FontSize = 18;
ax.GridColorMode = 'manual';
ax.GridLineStyle = '--'
ax.GridColor = [0 0 0];
ax.GridAlpha = [1];
ax.GridAlphaMode = 'manual';
ax.ThetaZeroLocation = 'bottom';
ax.ThetaDir = 'clockwise';
ax.ThetaLim = [-90 90];
ax.RMinorTick = 'on';
ax.RColor = [0 0 0];


rMax = max(ax.RTick)*1.05;
%thetaMax = max(ax.ThetaTick);
%thetaMin = min(ax.ThetaTick);

%theta = linspace(thetaMin, thetaMax);
%xa = rMax*cos(theta);
%ya = rMax*cos(theta);
xa = linspace(-rMax, rMax);
ya = zeros(1,length(xa));

%line(xa,ya,'Color','g','LineWidth',1);


%ax.ThetaLim = [90 
%[xFilm, yFilm] = pol2cart(azimuth, filmAR);
%[xGRIN, yGRIN] = pol2cart(azimuth, filmAR);

%plot(xFilm, yFilm);