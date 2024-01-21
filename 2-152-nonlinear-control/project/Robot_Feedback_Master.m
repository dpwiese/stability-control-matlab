%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 Nonlinear Control
% 2-Link Robot Manipulator Vertical
%--------------------------------------------------------------------------
% This code simulates a controller for the 2-Link robot holding an uncertain
% mass in the vertical plane.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;
close all;
clc;

% Plant parameters (Known and Unknown)
M1      = 1;
L1      = 1;
I1      = 0.12;
Lc1     = 0.5;
Me0     = 1;
Me      = 5;
de0     = 0;
de      = 30*pi/180;
Ie0     = 0.12;
Ie      = 0.25;
Lce0    = 0.5;
Lce     = 0.6;
mu10    = 0*0.2;
mu1     = 0*0.1;
mu20    = 0*0.2;
mu2     = 0*0.1;
g       = 9.81;
F       = [mu1, 0; 0, mu2];
F0      = [mu10, 0; 0, mu20];

% Nominal parameter values
theta10 = I1+M1*Lc1^2+Ie0+Me0*Lce0^2+Me0*L1^2;
theta20 = Ie0+Me0*Lce0^2;
theta30 = Me0*L1*Lce0*cos(de0);
theta40 = Me0*L1*Lce0*sin(de0);
theta50 = (M1*Lc1+Me0*L1)*g;
theta60 = Me0*Lce0*g;
theta70 = Me0*Lce0*g*tan(de0);
theta80 = mu10;
theta90 = mu20;

% Actual parameter values
theta1 = I1+M1*Lc1^2+Ie+Me*Lce^2+Me*L1^2;
theta2 = Ie+Me*Lce^2;
theta3 = Me*L1*Lce*cos(de);
theta4 = Me*L1*Lce*sin(de);
theta5 = (M1*Lc1+Me*L1)*g;
theta6 = Me*Lce*g;
theta7 = Me*Lce*g*tan(de);
theta8 = mu1;
theta9 = mu2;

% Assemble these into vector
theta = [theta1, theta2, theta3, theta4, theta5, theta6, theta7, theta8, theta9];
theta0 = [theta10, theta20, theta30, theta40, theta50, theta60, theta70, theta80, theta90];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CONTROLLER PARAMETERS
Gamma0 = 1*diag([1, 1, 1, 1, 1, 1, 1, 1, 1], 0);
% Gamma0 = 10*diag([1, 0.1, 0.1, 0.1, 1, 1, 1, 1, 1], 0);
%--------------------------------------------------------------------------
% PD UPDATE MODIFICATION: SEE pg193 SLOTINE LI NEW PERSPECTIVE
Gamma1 = 0.0*diag([1, 1, 1, 1, 1, 1, 1, 1, 1], 0);
% With this modification off, the state error oscillates more, and the
% parameters converge to much larger values. When on, control activity is
% much higher frequency, parameters converge to much lower values, but with
% a lot more high frequency activity.
% A little bit of this works well with saturation protection.
%--------------------------------------------------------------------------
% Regular Adaptive Controller (Slotine, Li pg 404)
Lambda  = 10*eye(2, 2);
KD      = 1000*eye(2, 2);
lambda  = 0;
lambdaf = 0;
R       = 0 * eye(2, 2);
%--------------------------------------------------------------------------
% % Ym Modified Adaptive Controller: Time Yarying KD (Slotine, Li pg 411)
% % Results in critically damped error dynamics
% % KD only affects saturation protection dynamics
% % Tune PD part with lambda
% lambda  = 10;
% Lambda  = lambda * eye(2, 2);
% KD      = 1 * eye(2, 2);
% lambdaf = 0;
% R       = 0 * eye(2, 2);
% % DOESNT WORK WITH SATURATION PROTECTION!
% % Faster convergence of the state error than regular. lambda = 10 vs. KD = 1000
% % Even with a large KD, regular controller doesn't converge state error as
% % well. Parameter converge of both controllers about the same.
%--------------------------------------------------------------------------
% For composite adaptive controller
Lambda  = 10 * eye(2, 2);
KD      = 100 * eye(2, 2);
lambda  = 0;
lambdaf = 100;
R       = 0 * eye(2, 2);
%--------------------------------------------------------------------------
GammaW = 1 * eye(4, 4);
% Projection
thetamax = 40;
thetaeps = 10;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initial conditions [rad]
initial_pos     = 1*[-3; -3];
initial_vel     = 1*[-6; 6];
initial_theta   = 0*theta';

% Simulation parameters
simtime     = 10;
sim_model   = 'Robot_Protected_Model';

% Actuators
tau1lim = 500;
tau2lim = 250;

% Sinusoidal with uncertain mass simulations
% Gamma = 1 * Gamma0;
sim(sim_model)

%%

% Make actual parameter values plotable
thetaplot = [theta; theta; theta; theta];
thetaplottime = linspace(0,simtime,4);

figure(1)
subplot(3,1,1)
    plot(qd.time,qd.signals.values*180/pi,'linestyle','--')
    hold on
    plot(q.time,q.signals.values*180/pi,'linestyle','-')
    ylabel('Track $q$','interpreter','latex','FontSize',12)
subplot(3,1,2)
    plot(q_tilde.time,q_tilde.signals.values*180/pi)
    ylabel('Tracking Error $\tilde{q}$','interpreter','latex','FontSize',12)
subplot(3,1,3)
    plot(taua.time,taua.signals.values)
    ylim([-1200 1200])
    legend('\tau_{1}','\tau_{2}')
    set(gca,'color',[1 1 1])
    ylabel('Input $\tau_{a}$','interpreter','latex','FontSize',12)
xlabel('Time [s]','interpreter','latex','FontSize',12)
set(gcf,'Units','pixels');
% set(gcf, 'OuterPosition', [50, 50, 700, 900]) %1520x980
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
print('-depsc','-r600','wopdtrack_x.eps');

figure(2)
subplot(3,1,1)
    plot(sDelta.time,sDelta.signals.values)
    ylabel('$s_{\Delta}$','interpreter','latex','FontSize',12)
subplot(3,1,2)
    plot(su.time,su.signals.values)
    ylabel('$s_{u}$','interpreter','latex','FontSize',12)
    ylim([-4 4])
subplot(3,1,3)
    plot(s.time,s.signals.values)
    ylabel('$s$','interpreter','latex','FontSize',12)
    legend('s_{1}','s_{2}')
xlabel('Time [s]','interpreter','latex','FontSize',12)
set(gcf,'Units','pixels');
% set(gcf, 'OuterPosition', [50, 50, 700, 900]) %1520x980
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
print('-depsc','-r600','wopderr_x.eps');

figure(3)
plot(theta_hat.time,theta_hat.signals.values)
hold on
plot(thetaplottime,thetaplot,'--')
ylim([-60 60])
ylabel('$\hat{\theta}$','interpreter','latex','FontSize',12)
xlabel('Time [s]','interpreter','latex','FontSize',12)
legend('1','2','3','4','5','6','7','8','9')
ylim([-40 40])
set(gcf,'Units','pixels');
% set(gcf, 'OuterPosition', [50, 50, 700, 900]) %1520x980
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
print('-depsc','-r600','wopdparam_x.eps');

figure(4)
plot(V.time,V.signals.values)

figure(5)
plot(tau_ad.time,tau_ad.signals.values)

figure(6)
plot(tau_nom.time,tau_nom.signals.values)

%%

% figure(4)
% plot(Wtheta.time,Wtheta.signals.values)
%
% figure(5)
% plot(Wthetahat.time,Wthetahat.signals.values)
%
% W1plot = squeeze(W.signals.values(1,:,:));
% W2plot = squeeze(W.signals.values(2,:,:));
%
% figure(6)
% plot(W1plot(1,:))
% hold on
% plot(W1plot(2,:))
% plot(W1plot(3,:))
% plot(W1plot(4,:))
% plot(W2plot(1,:))
% plot(W2plot(2,:))
% plot(W2plot(3,:))
% plot(W2plot(4,:))
%
% figure(7)
% plot(xi.time,xi.signals.values)
% legend('1','2','3','4')
%
% figure(8)
% plot(e.time,e.signals.values)
%
% figure(9)
% plot(e2.time,e2.signals.values)

%%
% %--------------------------------------------------------------------------
% Gamma = 1*Gamma0_G;
% sim(sim_model)
% figure(8)
% % plotter2(tau,qtilde,time,'Adaptive Sinusoidal with gravity \gamma = 1')
% plotter(tau,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Sinusoidal with gravity \gamma = 1')
% set(gcf,'Units','pixels');
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 6]);
% set(gcf,'PaperPositionMode','manual')
% set(gcf,'InvertHardCopy','off');
% set(gcf,'color',[1 1 1])
% print('-depsc','-r600','partC_G1.eps');
% % %--------------------------------------------------------------------------
% Gamma = 200*Gamma0_G;
% sim(sim_model)
% figure(9)
% % plotter2(tau,qtilde,time,'Adaptive Sinusoidal with gravity \gamma = 200')
% plotter(tau,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Sinusoidal with gravity \gamma = 200')
% set(gcf,'Units','pixels');
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 6]);
% set(gcf,'PaperPositionMode','manual')
% set(gcf,'InvertHardCopy','off');
% set(gcf,'color',[1 1 1])
% print('-depsc','-r600','partC_G2.eps');
% %--------------------------------------------------------------------------
% gamma = 0.1*Gamma0_G;
% sim(sim_model)
% figure(10)
% % plotter2(tau,qtilde,time,'Adaptive Sinusoidal with gravity \gamma = 0.1')
% plotter(tau,qtilde,time,ahat,a1,a2,a3,a4,'Adaptive Sinusoidal with gravity \gamma = 0.1')
% set(gcf,'Units','pixels');
% set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 6]);
% set(gcf,'PaperPositionMode','manual')
% set(gcf,'InvertHardCopy','off');
% set(gcf,'color',[1 1 1])
% print('-depsc','-r600','partC_G3.eps');
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
