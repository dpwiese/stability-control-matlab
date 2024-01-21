%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
% Run Kinematics.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

t0 = 0;
t1 = t0+2;
t2 = t1+(3*pi)/2;
t3 = t2+2;
t4 = t3+(3*pi)/2;
dt = 0.01;
RIB0 = eye(3,3);
Delta0 = [0, 0, 0];

omega_B1 = [0, 0, 0];
v_B1     = [1, 0, 0.2];
omega_B2 = [0, 0, 1];
v_B2     = [1, 0, 0];
omega_B3 = [0, 0, 0];
v_B3     = [1, 0, -0.2];
omega_B4 = [0, 0, -1];
v_B4     = [1, 0, 0];

[g_out1, RIB_out1, Delta_out1] = KinematicsBody(t0, t1, omega_B1, v_B1, dt, RIB0, Delta0);
[g_out2, RIB_out2, Delta_out2] = KinematicsBody(t1, t2, omega_B2, v_B2, dt, RIB_out1(:,:,end), Delta_out1(:,end));
[g_out3, RIB_out3, Delta_out3] = KinematicsBody(t2, t3, omega_B3, v_B3, dt, RIB_out2(:,:,end), Delta_out2(:,end));
[g_out4, RIB_out4, Delta_out4] = KinematicsBody(t3, t4, omega_B4, v_B4, dt, RIB_out3(:,:,end), Delta_out3(:,end));

Delta_plot = [Delta_out1, Delta_out2, Delta_out3, Delta_out4];

figure(1)
plot3(Delta_plot(1,:), Delta_plot(2,:), Delta_plot(3,:), '-', 'linewidth', 3)
grid on
xlim([-2, 2])
ylim([-2, 2])
zlim([0, 0.8])
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 5, 4])
set(gcf, 'PaperPositionMode', 'auto')
set(gcf, 'PaperUnits', 'inches')
% set(gcf, 'PaperSize', [16.5 14])
% print('-depsc','-r600','kinematics_v1.eps');
