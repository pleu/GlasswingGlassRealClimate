clear;
 hold on;
% N = NCRreflectionIntegrated(:,:);

figure(4);
clf;

load('./BareGlass/GlassReflectionIntegrated1100nm.mat');
dataBare = data;
%plot(dataBare(1,:), dataBare(2,:), 'Color', [0.4940 0.1840 0.5560], 'LineStyle', '-');
plot(dataBare(1,:), dataBare(2,:), 'b-');

hold on;
load('./ThinFilm/ThinFilmReflectionIntegrated1100nm.mat');
dataTF = data;
plot(dataTF(1,:), dataTF(2,:), 'g-.');

% hold on;
% load('./Nanowire/NWReflectionIntegrated.mat');
% dataNW = data;
% plot(dataNW(1,:), dataNW(2,:), 'g:');

hold on;
load('./Nanocone/NCReflectionIntegrated1100nm.mat');
dataNC = data;
plot(dataNC(1,:), dataNC(2,:), 'r--');


degrees = [0 65];
dataTotal = zeros(4, length(degrees));
for i = 1:length(degrees)
  dataTotal(1,i) = interp1(dataBare(1, :), dataBare(2, :), degrees(i));
  dataTotal(2,i) = interp1(dataTF(1, :), dataTF(2, :), degrees(i));
  % dataTotal(3,i) = interp1(dataNW(1, :), dataNW(2, :), degrees(i));
  dataTotal(4,i) = interp1(dataNC(1, :), dataNC(2, :), degrees(i));
end


xlabel('Incidence Angle (deg)');
ylabel('R_{solar} (%)');

%legend({'Bare Glass', 'Thin Film', 'Nanowire Array', 'Nanocone Array'}, 'Location', 'NorthWest');
legend({'Bare Glass', 'Thin Film', 'Graded Index of Refraction'}, 'Location', 'NorthWest');
legend boxoff;

axis([0 80 0 20]);


degreesInterp = 0:5:90;
reflectionData = [degreesInterp', interp1(dataBare(1,:), dataBare(2,:), degreesInterp)', interp1(dataTF(1,:), dataTF(2,:), degreesInterp)', interp1(dataNC(1,:), dataNC(2,:), degreesInterp)'];

csvwrite('reflectionData.csv', reflectionData);