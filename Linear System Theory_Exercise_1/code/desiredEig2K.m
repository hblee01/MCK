function K=desiredEig2K(sys,ev)
%% Find Canonicla Form
[n,d]=ss2tf(sys.A,sys.B,sys.C,sys.D,1);
[Ahat,Bhat]=tf2ss(n,d);

%% Find Controllability matrices
M_c = ctrb(sys.A,sys.B);
M_chat = ctrb(Ahat,Bhat);

%% Find the similarity Transform T
T = M_chat*inv(M_c);

%% Set Disired Pole
d_pole=poly(ev);
d_zero=[1];
[A_d,B_d,C_d,D_d]=tf2ss(d_zero,d_pole);

%% Find K_hat
K_hat=pinv(Bhat)*(Ahat-A_d);
disp(K_hat);

%% Find K
K=K_hat*T
disp(K);
end