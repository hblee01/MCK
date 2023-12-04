%% Initialize
clear all
clc
close all

%% Set Up Parameters
mass = 5;
dampingCoeff = 2; 
springCoeff = 10;

initPos = 3;
initVel = 1;

%% Select Simulation Mode
simOption.noise = "off";                 % on or off
simOption.disturbance = "off";       % on or off

%% State space
A = [0 1;-(springCoeff/mass) -(dampingCoeff/mass)];
B = [0;(1/mass)];
C = [1 0];
D = 0;

sys = ss(A,B,C,D);
disp(sprintf('Eigen values of A: %f\n',eig(sys.A)));

desiredEig = [-2.0+0.0000i -5+0.0000i];

K=desiredEig2K(sys,desiredEig);


%% Set Up Simulation
TSim = 10;               
if simOption.noise == "on"
    powerNoise = 0.00001;
else
    powerNoise = 0;
end

if simOption.disturbance == "on"
    magDist = 5;
    phaseDist = 0;
    freqDist = 1;
else
    magDist = 0;
    phaseDist = 0;
    freqDist = 1;
end

%% Run Simulink File
cd ..\sim\;
sim('sim_statefeedback.slx');
cd ..\code\;
%% Plot Result
out = ans;

figure;
plot(out.time,out.config);
title('output'); xlabel('[sec]'); ylabel('[]');
legend('pos','vel');
grid on;

%% check gain K flow when eigen value is far from origin
plotK;




