
Gamma0 = diag([0.03, 0.05, 0.1, 0.3], 0);
Gamma0_G = diag([0.03, 0.05, 0.1, 0.3, 300, 40, 225], 0);
Gamma0_G = diag([0.6, 0.04, 0.03, 0.3, 300, 40, 225], 0);

% %PD Control
% sim('Robot_PD')
% figure(1)
% plotter2(u,qtilde,time,'PD Control')
% set(gcf,'color',col.white)

% %Exponential Decay
% Gamma=1*Gamma0;
% sim('Robot_Adptraj1')
% figure(2)
% plotter(u,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Exponential Decay \gamma=1')
% set(gcf,'color',col.white)
% Gamma=200*Gamma0;
% sim('Robot_Adptraj1')
% figure(3)
% plotter(u,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Exponential Decay \gamma=200')
% set(gcf,'color',col.white)
% gamma=0.1*Gamma0;
% sim('Robot_Adptraj1')
% figure(4)
% plotter(u,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Exponential Decay \gamma=0.1')
% set(gcf,'color',col.white)

% %Sinusoidal
% Gamma=1*Gamma0;
% sim('Robot_Adptraj2')
% figure(5)
% plotter(u,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Sinusoidal \gamma=1')
% set(gcf,'color',col.white)
% Gamma=200*Gamma0;
% sim('Robot_Adptraj2')
% figure(6)
% plotter(u,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Sinusoidal \gamma=200')
% set(gcf,'color',col.white)
% gamma=0.1*Gamma0;
% sim('Robot_Adptraj2')
% figure(7)
% plotter(u,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Sinusoidal \gamma=0.1')
% set(gcf,'color',col.white)
