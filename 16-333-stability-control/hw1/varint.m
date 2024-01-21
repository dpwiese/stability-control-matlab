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

% Simulation times
t0 = 0;
tf = 20;
dt = 0.01;
nt = (tf-t0)/dt+1;
time = linspace(t0,tf,nt);

% Constants
J_B = [1, 0, 0; 0, 2, 0; 0, 0, 5];
M = 1;
gbar = [0, 0, 1];

% Initial velocity (translational and rotational)
omega_B0 = [1, 0, 0.2];
v_B0 = [1, 0, 0];

% Wrench acting on rigid body
tau_B0 = [0, 0, 0];
f_B0 = [0, 0, 0];

% Initial position and orientation of rigid body
RIB0 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
DeltaIB0 = [0, 0, 0];

% Another name for the initial R and Delta
R1 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
Delta1 = [0, 0, 0]';

% Run RK integrator to find R2 and Delta2
[Delta, R] = wrenchint_v3(t0, t0+dt, dt, J_B, M, omega_B0, v_B0, tau_B0, f_B0, RIB0, gbar, DeltaIB0);
Delta2 = Delta(:,2);
R2 = R(:,:,2);
S1 = inv(R1)*R2;
S(:,:,1) = S1;

% Run variational integrator to find rest of steps
for i = 1:nt
    S(:,:,i+1) = inv(J_B)*S(:,:,i)*J_B;
    Delta(:,i+2) = 2*Delta(:,i+1)-Delta(:,i)+dt^2*gbar';
end

% Plot
figure(1)
plot3(Delta(1,:),Delta(2,:),Delta(3,:),'-','linewidth',3)
xlabel('x-axis')
ylabel('y-axis')
zlabel('z-axis')
grid on
