%% Initialize
clc;
close all;
clear all;

%% Set Up Parameters
mass = 5;
dampingCoeff = 2; 
springCoeff = 10;

initPos = 3;
initVel = 1;

%% State Space
A = [0 1;-(springCoeff/mass) -(dampingCoeff/mass)];
B = [0;(1/mass)];
C = [1 0];
D = 0;
%% Transfer function
sys = ss(A,B,C,D);

%% Select Simulation Mode
simOption.noise = 'on';                 % on or off
simOption.disturbance = 'on';       % on or off

%% Set Up Simulation
TSim = 10;               
if simOption.noise == 'on'
    powerNoise = 0.00001;
else
    powerNoise = 0;
end

if simOption.disturbance == 'on'
    magDist = 5;
    phaseDist = 0;
    freqDist = 1;
else
    magDist = 0;
    phaseDist = 0;
    freqDist = 1;
end

%% Open Simulink File
cd '../sim';
open('sim.slx');