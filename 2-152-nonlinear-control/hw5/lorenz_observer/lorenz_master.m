%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152
% Observer for Lorenz System
%---------------------------------------------------------------------------------------------------
% This code simulates the system equations for a Lorenz system, with an observer to estimate the
% outputs y-hat and z-hat based on measurement of x. Within the function lorenz_equations, the
% nominal system parameters: sigma, beta, and rho can be changed to get a different response from
% the system (see wikipedia page for examples of some of the values). In addition, model error and
% noise can be turned on in the lorenz_equations function as well.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% Random initial values for all between 0 and 10
initval = 10 * rand(5, 1);
[t, out] = ode45(@lorenz_equations, 0:.01:10, initval);

% Grab the output
x = out(:,1);
y = out(:,2);
z = out(:,3);
yhat = out(:,4);
zhat = out(:,5);

% Plot the output
figure(1);

subplot(3, 1, 1);
    plot(t,x, '-', 'linewidth',1, 'color', 'red');
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('$x$', 'interpreter', 'latex', 'FontSize', 10);
    legend('$x$', 'Location', 'NorthEast');
    temphandle = legend;
    set(temphandle, 'interpreter', 'latex');

subplot(3, 1, 2);
    plot(t, y, '-', 'linewidth',1, 'color', 'red');
    hold on;
    plot(t, yhat, '--', 'linewidth',1, 'color', 'black');
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('$y$', 'interpreter', 'latex', 'FontSize', 10);
    legend('$y$', '$\hat{y}$', 'Location', 'NorthEast');
    temphandle = legend;
    set(temphandle, 'interpreter', 'latex');

subplot(3, 1, 3);
    plot(t, z, '-', 'linewidth',1, 'color', 'red');
    hold on;
    plot(t, zhat, '--', 'linewidth',1, 'color', 'black');
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('$z$', 'interpreter', 'latex', 'FontSize', 10);
    legend('$z$', '$\hat{z}$', 'Location', 'NorthEast');
    temphandle = legend;
    set(temphandle, 'interpreter', 'latex');

set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 10, 6]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1]);

print('-depsc', '-r600', 'lorenzres_v1.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
