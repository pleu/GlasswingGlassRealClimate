clear;

theta_i = linspace(0, 90);
b_0 = 0.05;

F_IAM = 1 - b_0*(1./cosd(theta_i) - 1);


figure(1);
clf;
plot(theta_i, F_IAM);

legend('Ashrae, b = 0.05', 'Location', 'Southwest');

% Frsnel reflection; 

n_1 = 1;
n_2 = 1.5;
theta_t = n_1*sin(theta_i)./n_2; 
R_s = abs((n_1*cosd(theta_i)-n_2*cosd(theta_t))./(n_1*cosd(theta_i) + n_2*cosd(theta_t))).^2;
R_p = abs((n_1*cosd(theta_t)-n_2*cosd(theta_i))./(n_1*cosd(theta_t) + n_2*cosd(theta_i))).^2;

R = (R_s+R_p)./2;
hold on;
plot(theta_i, (1 - R)./(1 - R(1)));

axis([0 90 0.6 1]);