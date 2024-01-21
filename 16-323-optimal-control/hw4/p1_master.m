%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #4
%---------------------------------------------------------------------------------------------------
% This is the master script which runs BVP4C to solve the state and costate  equations and determine
% the optimal control for a pendulum.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

global rho
rho = 10;

options = bvpset('Stats', 'on', 'RelTol', 1e-1);
solinit = bvpinit(linspace(0,10), @p1_initfun);

sol1 = bvp4c(@p1_odefun, @p1_bcfun, solinit);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sol = struct;
sol.t = sol1.x;
sol.x = sol1.y(1:2,:);
sol.p = sol1.y(3:4,:);
sol.u = -sol.p(2,:)/(2*rho);

%---------------------------------------------------------------------------------------------------
%% Plot Results

sizefont = 14;
ticklabelfontsize = 12;

figure(1)
plot(sol.t, sol.u, 'color', [0, 0, 0], 'linewidth', 2);
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1]);
xlabel('time [s]', 'interpreter', 'latex', 'FontSize',sizefont);
ylabel('$u^{*}(t)$', 'interpreter', 'latex', 'FontSize',sizefont);
set(gca, 'fontsize',ticklabelfontsize);
set(gca, 'fontname', 'times');
print('-depsc', '../Figures/prob1_control.eps');

figure(2)
plot(sol.t, sol.x(1,:), 'color', [0, 0, 0], 'linewidth', 2);
hold on;
plot(sol.t, sol.x(2,:), 'color', [0, 0, 0], 'linewidth', 2, 'linestyle', '--');
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
