clear;

%numThetaQuery = 91;
%load('InputVariables');

%thetaValues = 0:5:60;
thetaValues = 0:2:80;
%phiValues = 0:5:45;

variableValues = {thetaValues};

%valueCombinations = VariableArray.value_combinations(variableValues)

variableNames = {'Theta'};
variableUnits = {'Deg'};

va1 = VariableArray(variableNames, variableUnits, thetaValues);
va2 = VariableArray(variableNames, variableUnits, thetaValues);
va1.create_filenames('Glass', 'TE');
va2.create_filenames('Glass', 'TM');

percent = 1;
cd('TE')
sra1 = FDTDSimulationResultsArray.create(va1, 'wavelength', percent);

cd('../TM/')
sra2 = FDTDSimulationResultsArray.create(va2, 'wavelength', percent);
cd('../')
sra1 = sra1.add_simulation_at_theta_90;
sra2 = sra2.add_simulation_at_theta_90;

ss = SolarSpectrum.direct_AM1p5;
ss = ss.truncate_spectrum_wavelength(280, 1200);
ss.down_sample(100);
%idTE = IntegratedData(ss, sra1AvgPhi);
%idTM = IntegratedData(ss, sra2AvgPhi);

sraAvg = average_simulation_array(sra1, sra2);

%latitudes = [0 1 2:2:60];
gammas = 0;
betaFractionFlag = 0;
spectralFlag = 1;
days = linspace(0, 365, 30);
cd('../AnnualAnalysis/');
load('optimized_tilt_angles')
rb = RadiationBeam.empty(length(latitudes), 0);

for i = 1:length(latitudes)
  rb(i) = RadiationBeam(latitudes(i), days, betaOptimum(i), gamma, 'fixed', betaFractionFlag, spectralFlag, wavelengths);
end

% optimize tilt angle?
% minimize reflection from glass





