%% check gain K flow when eigen value is far from origin
eig=[-2.0+0.0000i -5+0.0000i];
desiredEigs=[];
for i=1:1:10
    desiredEigs = vertcat(desiredEigs, i*eig);
end

Ks=[];
for i=1:1:10 
    Ks=vertcat(Ks,desiredEig2K(sys,desiredEigs(i,:)));
end
figure;
plot(Ks);
title('gain'); xlabel('[i]'); ylabel('[Gain]');
legend('Proportional Gain','Derivative Gain');
grid on;