%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152
% Fitz-Hugh Nagumo
%---------------------------------------------------------------------------------------------------
% This code simulates 15 FitzHugh-Nagumo oscillators. In the fitzhugh_equations file, the system
% parameters: alpha, beta, gamma, and k can be changed. In addition I_{i} can be changed as well
% for part (a) and (b) of the homework.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% Initial values of v and w
initv = 5 * rand(15, 1);
initw = 5 * rand(15, 1);
initval = [initv; initw];

% Integrate equations
[t, out] = ode45(@fitzhugh_equations, 0:0.01:30, initval);

% Take v and w out of the output
vout = out(:, 1:15);
wout = out(:, 16:30);

% Plot
figure(1);

subplot(2, 1, 1);
    plot(t, vout);
    hold all;
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10)
    ylabel('$v$', 'interpreter', 'latex', 'FontSize', 10)
    xlim([0, 30]);
    ylim([-2, 8]);

subplot(2, 1, 2);
    plot(t, wout);
    hold all;
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10)
    ylabel('$w$', 'interpreter', 'latex', 'FontSize', 10)
    xlim([0, 30]);
    ylim([0, 40]);

set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 10, 6]);
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])

print('-depsc', '-r600', 'fitzres_v2.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
