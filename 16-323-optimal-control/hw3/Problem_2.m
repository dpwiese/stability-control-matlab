%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #3
%---------------------------------------------------------------------------------------------------
% Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% Different numbers
A1 = -0.0393;
A2 = -2.617;
c2 = -2.636;
c1 = -2.597;
nu = -0.655;

% Make the terminal constraint line
lineofx1 = @(x1) (15-x1)/5;
x1 = linspace(-4, 4, 81);
x2 = lineofx1(x1);

% Generate the curve data
t = linspace(0, 2, 201);
x1oft = @(t) -A2*exp(-t)-c1*t-0.5*A1*exp(t)+c2;
x2oft = @(t) A2*exp(-t)-c1-0.5*A1*exp(t);
x1t = x1oft(t);
x2t = x2oft(t);

% Plot the constraint line and the curve
figure(1)
plot(x1, x2, '-', 'linewidth',2, 'color', [0.6, 0.6, 0.6]);
hold on;
plot(x1oft(2), x2oft(2), 'x', 'markersize', 14, 'linewidth', 3, 'color', [1, 0, 0])
xlim([-1, 4])
ylim([-1, 4])
daspect([1, 1, 1])
plot(0, 0, 'o', 'markersize', 14, 'linewidth', 3, 'color', [0, 0, 1])
plot(x1t, x2t, '-', 'linewidth', 2, 'color', [0, 0, 0]);
xlabel('$x_{1}$', 'interpreter', 'latex', 'FontSize', 18);
ylabel('$x_{2}$', 'interpreter', 'latex', 'FontSize', 18);
set(gcf, 'Units', 'pixels');
% set(gcf, 'PaperUnits', 'inches', 'PaperPosition',[0, 0, 7 5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])
set(gca, 'FontSize', 14);
set(gca, 'FontName', 'Times');
print('-depsc', '-r600', '../Figures/prob2.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
