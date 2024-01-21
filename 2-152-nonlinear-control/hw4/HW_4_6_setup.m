%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 Nonlinear Control
% HW #4 Problem 3
% 2012-11-06
%---------------------------------------------------------------------------------------------------
% Code.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

col.white = [1, 1, 1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PD Control

sim('prob6');
figure(1);
clf;
plotter2(u, qtilde, time, 'PD Control');
set(gcf, 'color', col.white);
print('-depsc', '-r600', 'partA.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Exponential Decay

a1 = 3.3;
a2 = 0.97;
a3 = 1.04;
a4 = 0.6;

gamma = 1;
sim('prob6_ad1');
figure(2);
clf;
plotter(u, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Exponential Decay \gamma=1');
set(gcf, 'color', col.white);
print('-depsc', '-r600', 'partB_1.eps');

gamma = 200;
sim('prob6_ad1');
figure(3);
clf;
plotter(u, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Exponential Decay \gamma=200');
set(gcf, 'color', col.white);
print('-depsc', '-r600', 'partB_2.eps');

gamma = 0.1;
sim('prob6_ad1');
figure(4);
clf;
plotter(u, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Exponential Decay \gamma=0.1');
set(gcf,'color', col.white);
print('-depsc', '-r600', 'partB_3.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sinusoidal

a1 = 3.3;
a2 = 0.97;
a3 = 1.04;
a4 = 0.6;

gamma = 1;
sim('prob6_ad2');
figure(5);
clf;
plotter(u, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Sinusoidal \gamma=1');
set(gcf,'color', col.white);
print('-depsc', '-r600', 'partC_1.eps');

gamma = 200;
sim('prob6_ad2');
figure(6);
clf;
plotter(u, qtilde, time, ahat, a1, a2, a3, a4, 'Adaptive Sinusoidal \gamma=200');
set(gcf,'color', col.white);
print('-depsc', '-r600', 'partC_2.eps');

gamma = 0.1;
sim('prob6_ad2');
figure(7);
clf;
plotter(u, qtilde, time, ahat, a1, a2, a3, a4,'Adaptive Sinusoidal \gamma=0.1');
set(gcf,'color', col.white);
print('-depsc', '-r600', 'partC_3.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Sinusoidal with uncertain mass term

gamma = 1;
sim('prob6_ad3');
figure(8);
clf;
plotter2(u, qtilde, time, 'Adaptive Sinusoidal with gravity \gamma=1');

gamma = 200;
sim('prob6_ad3');
figure(9);
clf;
plotter2(u, qtilde, time, 'Adaptive Sinusoidal with gravity \gamma=200');

gamma = 0.1;
sim('prob6_ad3');
figure(10);
clf;
plotter2(u, qtilde, time, 'Adaptive Sinusoidal with gravity \gamma=0.1');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
