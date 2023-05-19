% Analyzes the results from a several FDTD simulations
% filename = [filenamePrefix, variableArray, variableStringArray,
% variableUnitsArray, filenameSuffix];
% Change the filename in order to obtain different results
% 
% Copyright 2011
% Paul W. Leu 
% LAMP, University of Pittsburgh
clear;

%numThetaQuery = 91;
%load('InputVariables');

%thetaValues = 0:2:10;
thetaValues = 0:2:80;
%thetaValues = 65;
phiValues = 0:5:45;

variableValues = {thetaValues, phiValues};

valueCombinations = VariableArray.value_combinations(variableValues);

variableNames = {'Theta' 'Phi'};
variableUnits = {'Deg' 'Deg'};
va1 = VariableArray(variableNames, variableUnits, valueCombinations);
va2 = VariableArray(variableNames, variableUnits, valueCombinations);
va1.create_filenames('GlassNWd290a390h150', 'TE');
va2.create_filenames('GlassNWd290a390h150', 'TM');

percent = 1;
cd('TE');
sra1 = FDTDSimulationResultsArray.create(va1, 'wavelength', percent);
cd('../TM/');
sra2 = FDTDSimulationResultsArray.create(va2, 'wavelength', percent);
sra1 = sra1.add_simulation_at_theta_90;
sra2 = sra2.add_simulation_at_theta_90;

cd('../');
sra1AvgPhi = sra1.average_simulation_array_over_variable('Phi');
sra2AvgPhi = sra2.average_simulation_array_over_variable('Phi');
% sraAvgPhi = sra.average_simulation_array_over_variable('Phi');
% sraAvgPhi = sraAvgPhi.mirror;

ss = SolarSpectrum.direct_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 1200);
%idTE = IntegratedData(ss, sra1AvgPhi);
%idTM = IntegratedData(ss, sra2AvgPhi);

sraAvg = average_simulation_array(sra1AvgPhi, sra2AvgPhi);
id = IntegratedData.create_array(ss, sraAvg.Simulations);


figure(1);
clf;
%sraAvgPhi = sra.average_simulation_array_over_variable('Phi');
%sraAvgPhi = sraAvgPhi.mirror;
sra1AvgPhi.contour('Wavelength', 'Theta', 'Reflection',200,0, 'polar');
caxis([0 50]);
colorbar;
%caxis([0 100]);

figure(2);
clf;
%sraAvgPhi = sra.average_simulation_array_over_variable('Phi');
%sraAvgPhi = sraAvgPhi.mirror;
sra2AvgPhi.contour('Wavelength', 'Theta', 'Reflection',200,0, 'polar');
caxis([0 50]);
colorbar;
%caxis([0 100]);

figure(3);
clf;
sraAvg = sraAvg.mirror;
sraAvg.contour('Wavelength', 'Theta', 'Reflection',200,0, 'polar');
caxis([0 10]);
colorbar;

reflectionMat = zeros(sraAvg.VariableArray.NumValues, sraAvg.Simulations(1).ReflectionResults.NumFrequency);
for i = 1:sraAvg.VariableArray.NumValues
  reflectionMat(i, :) = sraAvg.Simulations(i).ReflectionResults.Data;
end
thetaVec = sraAvg.VariableArray.Values;
lambdaVec = sraAvg.Simulations(1).ReflectionResults.Wavelength;
save('NWReflectionWavelength', 'thetaVec', 'lambdaVec', 'reflectionMat');


%axes('Color','none','YColor','none');

% reflection = zeros(length(sraAvg.VariableArray.Values), 1);
% for j = 1:length(sraAvg.VariableArray.Values)
%   reflection(j) = SolarCell.calculate_integrated_data(ss,...
%     sraAvg.Simulations(j).ReflectionResults.Energy,...
%     sraAvg.Simulations(j).ReflectionResults.Data);
% end

figure(4);
clf;
plot([thetaValues 90], [id.ReflectionIntegrated], 'r:');
xlabel('Theta (deg)');
ylabel('R_{solar} (%)');
% check
%hold on;
%plot(sraAvg.VariableArray.Values, reflection, 'g:');

data = [thetaValues 90; id.ReflectionIntegrated];
save('NWReflectionIntegrated', 'data');

% 
figure(5);
clf;
sraAvgWithPhi = average_simulation_array(sra1, sra2);
varIndex = sraAvgWithPhi.VariableArray.get_variable_ind('Phi')
sraAvgWithPhi = sraAvgWithPhi.symmetry45(varIndex); % this should be corrected 

material = MaterialType.create('Si')
[scArrayWithPhi] = SolarCellArray.create(ss,...
      sraAvgWithPhi.Simulations, sraAvgWithPhi.VariableArray, material);
scArrayWithPhi.contour_solarCellArray('Theta', 'Phi', 'Reflection', 200, 0,...
  'polar', 'RadialTickSpacing', [30 60 90], 'PolarDirection', '180', 'RadLabels', 4, ...
  'radlabelcolor', 'white');

colorbar;
caxis([0 10]);
% 
%sra1.contour('Theta', 'Phi', 'Reflection',200,0, 'polar');


