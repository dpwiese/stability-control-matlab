%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #4
%---------------------------------------------------------------------------------------------------
% This is the master script which runs BVP4C to solve the state and costate  equations and determine
% the optimal control for a space launch vehicle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

global a g h

a = 2;
g = 0;
h = 5000;

options = bvpset('Stats', 'on', 'RelTol', 1e-1);
solinit = bvpinit(linspace(0,200), @p3_initfun);

sol1=bvp4c(@p3_odefun, @p3_bcfun, solinit);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sol = struct;
sol.t = sol1.x;
sol.x = sol1.y(1:4,:);
sol.p = sol1.y(5:8,:);
sol.u = atan2(-sol.p(2,:), -sol.p(1,:));

%---------------------------------------------------------------------------------------------------
%% Plot Results

sizefont = 14;
ticklabelfontsize = 12;

figure(1)
plot(sol.x(3,:), sol.x(4,:), 'color', [0, 0, 0], 'linewidth', 2, 'linestyle', '-');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])
ylim([0, 6000]);
xlabel('$x$ [meters]', 'interpreter', 'latex', 'FontSize', sizefont);
ylabel('$y$ [meters]', 'interpreter', 'latex', 'FontSize', sizefont);
set(gca, 'fontsize', ticklabelfontsize);
set(gca, 'fontname', 'times');
print('-depsc', '../Figures/prob3_traj.eps');

figure(2)
plot(sol.t, sol.u*180/pi, 'color', [0, 0, 0], 'linewidth', 2, 'linestyle', '-');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])
xlabel('$t$ [seconds]', 'interpreter', 'latex', 'FontSize', sizefont);
ylabel('$\beta$ [degrees]', 'interpreter', 'latex', 'FontSize', sizefont);
set(gca, 'fontsize', ticklabelfontsize);
set(gca, 'fontname', 'times');
print('-depsc', '../Figures/prob3_control.eps');

% figure(3)
% plot(sol.t, sol.x(1,:), 'color', [0, 0, 0], 'linewidth', 2)
% hold on
% plot(sol.t, sol.x(2,:), 'color',[0, 0, 0], 'linewidth', 2, 'linestyle', ':')
% plot(sol.t, sol.x(3,:), 'color',[0.6, 0.6, 0.6], 'linewidth', 2, 'linestyle', '-')
% plot(sol.t, sol.x(4,:), 'color',[0, 0, 0], 'linewidth',2, 'linestyle', '--')
% legend('$u$', '$v$', '$x$', '$y$', 'Location', 'NorthEast')
% temphandle = legend;
% set(temphandle, 'interpreter', 'latex', 'FontSize',sizefont, 'box', 'on')
% set(gcf, 'Units', 'pixels');
% set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
% set(gcf, 'PaperPositionMode', 'manual')
% set(gcf, 'InvertHardCopy', 'off');
% set(gcf, 'color', [1, 1, 1])
% xlabel('time [s]', 'interpreter', 'latex', 'FontSize', sizefont)
% ylabel('$\theta$, $\dot{\theta}$', 'interpreter', 'latex', 'FontSize', sizefont)
% set(gca, 'fontsize', ticklabelfontsize);
% set(gca, 'fontname', 'times');
% % print('-depsc', '../Figures/prob3_state.eps');
