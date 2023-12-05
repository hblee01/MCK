%% Initialize
clc;
close all;
clear all;

%% Computation via Symbolic Expression
syms M;
syms B;
syms K;
syms s; %Laplace variable
syms Kp;
syms Kd;

% %% Method 1: Transfer Function
% Gs_TF = 1/(M*s^2 + B*s + K);
% Ks_TF = Kp + Kd*s;
% 
% Ts_TF = (Gs_TF * Ks_TF)/(1+Gs_TF * Ks_TF);
% Ts_TF = simplify(Ts_TF);
% disp("Result of Method1:");
% Ts_TF

%% Method 2: State-space Model
M = 5;
B = 2; 
K = 10;

AMat = [0 1; -K/M -B/M];
BMat = [0; 1/M];
CMat = [1 0];
DMat = [0];

sys = ss(AMat,BMat,CMat,DMat);
desiredEig = 4*[-2.0+0.0000i -5+0.0000i];

KMat = desiredEig2K(sys,desiredEig);
GMat = BMat * KMat;
g1 = GMat(:,1);
g2 = GMat(:,2);

Ts_yr = CMat * inv(s*eye(2) - (AMat - BMat * KMat)) * g1; 
Ts_yrDot = CMat * inv(s*eye(2) - (AMat - BMat * KMat)) * g2;

Ts_SS = Ts_yr + s * Ts_yrDot;
Ts_SS = simplify(Ts_SS);
Ts_TF = sym2tf(Ts_SS);

bode(Ts_TF)

function G = sym2tf(g)
[n,m]=size(g);
    for i=1:n
        for j=1:m
            [num,den]=numden(g(i,j));
            num_n=sym2poly(num);
            den_n=sym2poly(den);
            G(i,j)=tf(num_n,den_n);
        end
    end
end