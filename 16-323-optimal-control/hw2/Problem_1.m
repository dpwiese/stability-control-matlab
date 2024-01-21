%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #2
%---------------------------------------------------------------------------------------------------
% Pendulum master script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

tf = 10;
dt = 0.1;
rho = 10;
x0 = [pi; 0];
u = ones(tf/dt+1,1);
t = 0:dt:tf;

options = optimset('GradObj', 'on', 'Hessian', 'off');

[U, Jmin, exitflag, output, grad, hessian] = fminunc(@pendulum_b, u, options);

[~, ~, xcl] = pendulum_b(U);

sizefont = 14;
ticklabelfontsize = 12;

figure(1)
plot(t,U, 'color', [0, 0, 0], 'linewidth', 2);
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1]);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', sizefont);
ylabel('$u^{*}(t)$', 'interpreter', 'latex', 'FontSize', sizefont);
set(gca, 'fontsize', ticklabelfontsize);
set(gca, 'fontname', 'times');
print('-depsc', '../Figures/prob1_control.eps');

figure(2)
plot(t,xcl(:,1), 'color', [0, 0, 0], 'linewidth', 2);
hold on;
plot(t,xcl(:,2), 'color', [0, 0, 0], 'linewidth', 2, 'linestyle', '--');
legend('$\theta$', '$\dot{\theta}$', 'Location', 'NorthEast');
temphandle = legend;
set(temphandle, 'interpreter', 'latex', 'FontSize', sizefont, 'box', 'on');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1]);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', sizefont);
ylabel('$\theta$, $\dot{\theta}$', 'interpreter', 'latex', 'FontSize', sizefont);
set(gca, 'fontsize', ticklabelfontsize);
set(gca, 'fontname', 'times');
print('-depsc', '../Figures/prob1_state.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
