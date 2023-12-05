%% Computation via Symbolic Expression
syms M;
syms B;
syms K;
syms s; %Laplace variable
syms Kp;
syms Kd;

%% Method 1: Transfer Function
Gs_TF = 1/(M*s^2 + B*s + K);
Ks_TF = Kp + Kd*s;

Ts_TF = (Gs_TF * Ks_TF)/(1+Gs_TF * Ks_TF);
Ts_TF = simplify(Ts_TF);
disp("Result of Method1:");
Ts_TF

%% Method 2: State-space Model
AMat = [0 1; -K/M -B/M];
BMat = [0; 1/M];
CMat = [1 0];
DMat = [0];

KMat = [Kp Kd];
GMat = BMat * KMat;
g1 = GMat(:,1);
g2 = GMat(:,2);

Ts_yr = CMat * inv(s*eye(2) - (AMat - BMat * KMat)) * g1; 
Ts_yrDot = CMat * inv(s*eye(2) - (AMat - BMat * KMat)) * g2;

Ts_SS = Ts_yr + s * Ts_yrDot;
Ts_SS = simplify(Ts_SS);
disp("Result of Method2:");
Ts_SS