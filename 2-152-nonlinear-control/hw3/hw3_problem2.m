%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 HW #3 Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
close all;

% This seems to work only if the 'save and run' button is pressed
this_mfile = dbstack('-completenames');
this_dir = fileparts(this_mfile.file);
plot_dir = this_dir;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial condition
startpt = [2;4];
xd = 1;
dotxd = 0;

% Simulation parameters
t_sim = 10;

% File names used
sim_mod = 'hw3_model';
lambda = 2 * pi;
eta = 1;
alpha2hat = 3;
alpha1hat = 7;

[tsim, simout] = sim(sim_mod);

figure(1)
subplot(1, 2, 1)
plot(tsim, simout(:,1))
subplot(1, 2, 2)
plot(tsim, simout(:,2))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
