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

%% Find Canonicla Form
[n,d]=ss2tf(A,B,C,D,1);
[Ahat,Bhat]=tf2ss(n,d);

%% Find Controllability matrices
M_c = ctrb(sys.A, sys.B);
M_chat = ctrb(Ahat,Bhat);

%% Find the similarity Transform T
T = M_chat*inv(M_c);

%% Set Disired Pole
ev = [-2.0+0.0000i -5+0.0000i];
d_pole=poly(ev);
d_zero=[1];
[A_d,B_d,C_d,D_d]=tf2ss(d_zero,d_pole);

%% Find K_hat
K_hat=pinv(Bhat)*(Ahat-A_d);
disp(K_hat);

%% Find K
K=K_hat*T
disp(K);

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
sim('sim_statefeedback.slx');
%% Simulation Result
out = ans;

figure;
plot(out.time,out.config);
title('output'); xlabel('[sec]'); ylabel('[]');
legend('pos','vel');
grid on;