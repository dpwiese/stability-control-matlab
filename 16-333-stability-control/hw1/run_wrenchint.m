%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
% Run Kinematics.m
% Is g vector expressed in inertial axes?
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

% Simulation times
t0 = 0;
tf = 20;
dt = 0.01;
nt = (tf-t0)/dt+1;
time = linspace(t0,tf,nt);

% Constants
J_B = [1, 0, 0; 0, 2, 0; 0, 0, 2];
M = 1;
gbar = [0, 0, 0];

% Initial velocity (translational and rotational)
omega_B0 = [1, 0, 0.2];
v_B0 = [0, 0, 0];

% Wrench acting on rigid body
tau_B0 = [0, 0, 0];
f_B0 = [0, 0, 0];

% Initial position and orientation of rigid body
RIB0 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
DeltaIB0 = [0, 0, 0];

% Run integrator
[v_Bout, Delta_out, R_out] = wrenchint(t0, tf, dt, J_B, M, omega_B0, v_B0, tau_B0, f_B0, RIB0, gbar, DeltaIB0);

% Format data
h = Delta_out(3,:);
for i = 1:length(R_out)
    eulr(:,i) = R2eulr(R_out(:,:,i));
end
delta_and_eulr.signals.values = [Delta_out; eulr]';
delta_and_eulr.time = time';

phi = eulr(1,:);
theta = eulr(2,:);
psi = eulr(3,:);

% Plot
figure(1)
plot3(Delta_out(1,:),Delta_out(2,:),Delta_out(3,:),'-','linewidth',3)
grid on
% xlim([-2 2])
% ylim([-2 2])
% zlim([0 0.8])
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 5, 4])
set(gcf, 'PaperPositionMode', 'auto')
set(gcf, 'PaperUnits', 'inches')
% set(gcf, 'PaperSize', [16.5 14])
% print('-depsc','-r600','wrench_v1.eps');

figure(2)
plot(time,phi,'-k')
hold on
plot(time,theta,'-b')
plot(time,psi,'-r')
grid on
xlabel('time [s]')
ylabel('Angle [rad]')
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6, 3])
set(gcf, 'PaperPositionMode', 'auto')
set(gcf, 'PaperUnits', 'inches')
legend('Roll','Pitch','Yaw')
% set(gcf, 'PaperSize', [16.5 14])
% print('-depsc','-r600','wrench_eulr_v4.eps');

% Run flightgear
sim('flightgear')
