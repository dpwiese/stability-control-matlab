% Daniel Wiese
% 2.151 HW #2
% Time-integrate state equations

clear all;
close all;
clc;

% Starting state
x10 = 0.5;  % Position compressed downward 0.5 inches
x20 = 0;    % Starting with zero initial velocity

% Nominal simulation time
tsim = 1;

% Define the simulation frequency and corresponding time vector
sfrq = 10000;
tvec = (0:1:sfrq*tsim)/sfrq;

% Initial state vector
x0 = [x10; x20];

% Use ode45 to integrate the state equations
[tl, xl] = ode45(state_space_model("linear"), tvec, x0);
[tn, xn] = ode45(state_space_model("nonlinear"), tvec, x0);

% Plot position of the car versus time
figure(1)
subplot(2, 1, 1)
plot(tl, xl(:,1))
xlabel('time [s]')
ylabel('Height Perturbation from h_0 [in] (positive downward)')
grid on
title('Plot of Vehicle Displacement from Equlibrium versus time')
hold on
plot(tn, xn(:,1), '-r')
legend('Linear', 'Nonlinear')
hold off

% Plot state-space trajectory
subplot(2, 1, 2)
plot(xl(:,1), xl(:,2))
xlabel('x_1: displacement from h_o [in]')
ylabel('x_2: velocity [in/s]')
title('State-Space Trajectory')
grid on
hold on
plot(xn(:,1), xn(:,2), '-r')
legend('Linear', 'Nonlinear')
hold off
