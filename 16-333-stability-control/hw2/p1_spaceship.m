%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #2
% Problem 1
% Due: 2012/3/23
% P1_spaceship.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

linearize_spaceship='P1_linspaceship_eulr_v2';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Simulation times
t0      = 0;
tf      = 15;
dt      = 0.001;
nt      = (tf-t0)/dt+1;
time    = linspace(t0,tf,nt);
n_int   = ((tf-t0)/dt)+1;

% Spaceship mass parameters, and other constants
geo.totl.J  = diag([1 2 5],0);
geo.totl.m  = 1;
gbar        = [0, 0, 0];

% Equilibrium condition around which to linearize and design controller
R_eq        = eye(3,3);
omegaB_eq   = [0, 0, 0];
U_eq        = [0, 0, 0];

% Given initial conditions: configuration and twist
k = 1;
g0 = [expm(hat([0 0 (k*pi)/6])), zeros(3,1); zeros(1,3) 1];
xihatB0 = [inv(g0(1:3,1:3))*hat([1,0,0])*g0(1:3,1:3)+hat([0.5,0,0]), zeros(3,1) ; zeros(1,4)];

% Pull out initial conditions in terms of: velcity, angular velocity, translation, rotation
R0      = g0(1:3,1:3);
Delta0  = g0(1:3,4);
vB0     = xihatB0(1:3,4);
omegaB0 = hat(xihatB0(1:3,1:3));
eulr0   = R2eulr(R0);
X0      = [eulr0 omegaB0];

% Calculate other equilibrium parameters from equilibrium condition above to use for linearization
eulr_eq     = R2eulr(R_eq);
omegaB_eq   = [0, 0, 0];
X_eq        = [eulr_eq omegaB_eq];
omegad      = omegaB_eq';

% Initial wrench acting on rigid body
tauB0   = [0, 0, 0];
fB0     = [0, 0, 0];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Linearize model
[A, B, ~, ~] = linmod(linearize_spaceship, X_eq, U_eq);

% Find gain K
K   = lqr(A,B,eye(6,6),eye(3,3));
Kp  = K(:,1:3);
Kv  = K(:,4:6);
Rd  = R_eq;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INTEGRATE NONLINEAR CONTROLLER ON NONLINEAR EQUATIONS

% Initialize integrator
tauB    = tauB0;
fB      = fB0;
g       = g0;
xihatB  = xihatB0;
eulr0   = R2eulr(g0(1:3,1:3));

% Run integrator
for i=1:n_int-1
    [g, xihatB] = eom_integrator(geo, xihatB, tauB, fB, gbar, g, dt);
    eulr(:,i) = R2eulr(g(1:3,1:3));
    R = g(1:3,1:3);
    omega = (hat(xihatB(1:3,1:3)))';
    tauB = -(hat(Kp*Rd'*R))'-Kv*(omega-R*Rd'*omegad);
    i=i+1;
end

phi_non     = [eulr0(1), eulr(1,:)];
theta_non   = [eulr0(2), eulr(2,:)];
psi_non     = [eulr0(3), eulr(3,:)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INTEGRATE LINEAR LQR CONTROLLER ON NONLINEAR EQUATIONS

% Initialize integrator
tauB    = tauB0;
fB      = fB0;
g       = g0;
xihatB  = xihatB0;
eulr0   = R2eulr(g0(1:3,1:3));

% Run integrator
for i = 1:n_int-1
    [g, xihatB] = eom_integrator(geo, xihatB, tauB, fB, gbar, g, dt);
    eulr(:,i) = R2eulr(g(1:3,1:3));
    R = g(1:3,1:3);
    omega = (hat(xihatB(1:3,1:3)))';
    tauB = -Kp*eulr(:,i)-Kv*omega;
    i = i+1;
end

phi_lqr     = [eulr0(1), eulr(1,:)];
theta_lqr   = [eulr0(2), eulr(2,:)];
psi_lqr     = [eulr0(3), eulr(3,:)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT

% cd(plot_dir);

figure(1)
plot(time,phi_non,'-k','linewidth',1)
hold on
plot(time,theta_non,'-b','linewidth',1)
plot(time,psi_non,'-r','linewidth',1)
plot(time,phi_lqr,':k','linewidth',1)
plot(time,theta_lqr,':b','linewidth',1)
plot(time,psi_lqr,':r','linewidth',1)
grid off
box off
h = hline(0,'k');
xlabel('time [s]')
ylabel('Angle [rad]')
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 5, 3])
set(gcf, 'PaperPositionMode', 'auto')
set(gcf, 'PaperUnits', 'inches')
legend('Roll','Pitch','Yaw')
ylim([-1 2])
plot_title1=strcat('Controller Comparison: k=',sprintf('%0.0f',k));
title(plot_title1)
% print('-depsc','-r600','p1_cont_k1_v2.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
