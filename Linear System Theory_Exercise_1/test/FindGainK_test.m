clear all;
clc;
A=[-1 -2; 1 -0.4];
B=[1;-2];C=[3 4];D=0;

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

%% Set Desured Pole
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

disp(sprintf('eig(Ahat-Bhat*Kbar): %f\n',eig(Ahat-Bhat*K_hat)));
disp(sprintf('eig(A-B*K): %f\n',eig(A-B*K)));