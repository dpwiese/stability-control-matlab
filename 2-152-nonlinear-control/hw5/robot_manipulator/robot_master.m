%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 Nonlinear Control
% 2-Link Robot Manipulator Vertical
%---------------------------------------------------------------------------------------------------
% This code simulates a controller for the 2-Link robot holding an uncertain mass in the vertical
% plane.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% Parameters
Gamma0_G = diag([0.03, 0.05, 0.1, 0.3, 100, 100, 100], 0);
Gamma0_G = diag([0.5, 1, 0.1, 0.3, 10, 10, 10], 0);
Lambda = 20 * eye(2, 2);
simtime = 10;

% Nominal values
a1 = 3.3;
a2 = 0.97;
a3 = 1.04;
a4 = 0.6;

% Sinusoidal with uncertain mass simulations
%---------------------------------------------------------------------------------------------------

Gamma = 1 * Gamma0_G;
sim('Robot_AdpG');
figure(8);
% plotter2(tau,qtilde,time, 'Adaptive Sinusoidal with gravity \gamma=1')
plotter(tau, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Sinusoidal with gravity \gamma=1');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 10, 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])
print('-depsc', '-r600', 'partC_G1.eps');

%---------------------------------------------------------------------------------------------------

Gamma = 200 * Gamma0_G;
sim('Robot_AdpG');
figure(9);
% plotter2(tau,qtilde,time, 'Adaptive Sinusoidal with gravity \gamma=200')
plotter(tau, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Sinusoidal with gravity \gamma=200');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 10, 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])
print('-depsc', '-r600', 'partC_G2.eps');

%---------------------------------------------------------------------------------------------------

gamma = 0.1 * Gamma0_G;
sim('Robot_AdpG');
figure(10);
% plotter2(tau,qtilde,time, 'Adaptive Sinusoidal with gravity \gamma=0.1')
plotter(tau, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Sinusoidal with gravity \gamma=0.1');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 10, 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])
print('-depsc', '-r600', 'partC_G3.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
