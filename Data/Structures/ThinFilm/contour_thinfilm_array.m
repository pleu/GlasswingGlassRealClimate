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
%
thetaValues = 0:2:80;
%phiValues = 0;

variableValues = {thetaValues};

%valueCombinations = VariableArray.value_combinations(variableValues)

variableNames = {'Theta'};
variableUnits = {'Deg'};

va1 = VariableArray(variableNames, variableUnits, thetaValues);
va2 = VariableArray(variableNames, variableUnits, thetaValues);
va1.create_filenames('GlassThinFilmt120', 'TE');
va2.create_filenames('GlassThinFilmt120', 'TM');

%MAKE SURE TO SET YOUR PROFILE NAME PROPERLY
percent = 1;
cd('TE')
sra1 = FDTDSimulationResultsArray.create(va1, 'wavelength', percent);

cd('../TM')
sra2 = FDTDSimulationResultsArray.create(va2, 'wavelength', percent);
cd('../')
sra1 = sra1.add_simulation_at_theta_90;
sra2 = sra2.add_simulation_at_theta_90;


ss = SolarSpectrum.direct_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 1200);
%idTE = IntegratedData(ss, sra1AvgPhi);
%idTM = IntegratedData(ss, sra2AvgPhi);

sraAvg = average_simulation_array(sra1, sra2);

id = IntegratedData.create_array(ss, sraAvg.Simulations);


figure(1);
clf;
%sraAvgPhi = sra.average_simulation_array_over_variable('Phi');
sra1 = sra1.mirror;
sra1.contour('Wavelength', 'Theta', 'Reflection',200,0, 'polar');
caxis([0 50]);
colorbar;
%caxis([0 100]);

figure(2);
clf;
%sraAvgPhi = sra.average_simulation_array_over_variable('Phi');
%sraAvgPhi = sraAvgPhi.mirror;
sra2 = sra2.mirror;
sra2.contour('Wavelength', 'Theta', 'Reflection',200,0, 'polar');
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
save('ThinFilmReflectionWavelength', 'thetaVec', 'lambdaVec', 'reflectionMat');




figure(4);

plot([thetaValues 90], [id.ReflectionIntegrated], 'r:');
xlabel('Theta (deg)');
ylabel('R_{solar} (%)');


data = [thetaValues 90; id.ReflectionIntegrated];
save('ThinFilmReflectionIntegrated', 'data');

figure(5);
clf;
sraAvg = average_simulation_array(sra1, sra2);

sraAvgWithPhi = sraAvg.symmetry360; % this should be corrected 
% varIndex = sraAvgWithPhi.VariableArray.get_variable_ind('Phi')
% sraAvgWithPhi = sraAvgWithPhi.symmetry45(varIndex); % this should be corrected 
% 
%id2 = IntegratedData.create_array(ss, sraAvgWithPhi.Simulations);

material = MaterialType.create('Si')
[scArrayWithPhi] = SolarCellArray.create(ss,...
  sraAvgWithPhi.Simulations, sraAvgWithPhi.VariableArray, material);
scArrayWithPhi.contour_solarCellArray('Theta', 'Phi', 'Reflection', 200, 0,...
  'polar', 'RadialTickSpacing', [30 60 90], 'PolarDirection', '180', 'RadLabels', 4, ...
  'radlabelcolor', 'white');
%scArrayWithPhi.contour_solarCellArray('Theta', 'Phi', 'Reflection', 200, 0, 'polar', 'RadialTickSpacing', [30 60 90]);

colorbar;
caxis([0 10]);




