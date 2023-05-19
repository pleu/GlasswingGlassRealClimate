clear;
 hold on;
% N = NCRreflectionIntegrated(:,:);

figure(4);
clf;

load('./BareGlass/GlassReflectionIntegrated.mat');
dataBare = data;
plot(dataBare(1,:), dataBare(2,:), 'Color', [0.4940 0.1840 0.5560], 'LineStyle', '-');

hold on;
load('./ThinFilm/ThinFilmReflectionIntegrated.mat');
dataTF = data;
plot(dataTF(1,:), dataTF(2,:), 'b-.');

hold on;
load('./Nanowire/NWReflectionIntegrated.mat');
dataNW = data;
plot(dataNW(1,:), dataNW(2,:), 'g:');

hold on;
load('./Nanocone/NCReflectionIntegrated.mat');
dataNC = data;
plot(dataNC(1,:), dataNC(2,:), 'r--');


degrees = [0 65];
dataTotal = zeros(4, length(degrees));
for i = 1:length(degrees)
  dataTotal(1,i) = interp1(dataBare(1, :), dataBare(2, :), degrees(i));
  dataTotal(2,i) = interp1(dataTF(1, :), dataTF(2, :), degrees(i));
  dataTotal(3,i) = interp1(dataNW(1, :), dataNW(2, :), degrees(i));
  dataTotal(4,i) = interp1(dataNC(1, :), dataNC(2, :), degrees(i));
end


xlabel('Theta (deg)');
ylabel('R_{solar} (%)');

legend({'Bare Glass', 'Thin Film', 'Nanowire Array', 'Nanocone Array'}, 'Location', 'NorthWest');
legend boxoff;

axis([0 80 0 20]);