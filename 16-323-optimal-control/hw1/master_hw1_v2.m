%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #1
%---------------------------------------------------------------------------------------------------
% This script defines the function handles for the different minimization problems, and contains
% the desired starting point. The BFGS solver bfgs.m is called by passing it a function handle and
% initial guess. The state history, number of iterations, and number of function calls are returned
% and plotted.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all
clc;

% Make function handle for the desired function
fhand = @functionpart1_rosen;

% fhand = @functionpart2_objective;
% fhand = @functionpart3_multiple;

% Initial starting point
x0 = [-1.9, 2]';
% x0 = [-2, 0]';

% Call the BFGS solver which will return the points leading up to the minimum
[x, ni, nf] = bfgs(fhand, x0);
disp(nf)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PLOT THE RESULTS: STATE HISTORIES

% Define plot limits
x1min = -2;
x1max = 2;
x2min = -1;
x2max = 3;

% Generate linspace over which to plot
x1 = linspace(x1min, x1max, 100);
x2 = linspace(x2min, x2max, 100);

% Evaluate the function value over plot space
for ii = 1:length(x1)
    for jj = 1:length(x2)
        [func(ii,jj), ~] = fhand([x1(ii), x2(jj)]);
    end
end

% Make plot vector from path
% xplot = [x0'; x];
xplot = x;

figure(1);
contour(x1, x2, func', 200);
hold on
plot(xplot(:,1), xplot(:,2), 'linewidth',3, 'color', [1, 0, 0]);
plot(xplot(end,1), xplot(end,2), '.', 'MarkerSize', 60, 'Color', [0, 0, 0]);
xlim([x1min, x1max]);
ylim([x2min, x2max]);
xlabel('$x_{1}$', 'interpreter', 'latex', 'FontSize', 14);
ylabel('$x_{2}$', 'interpreter', 'latex', 'FontSize', 14);
set(gca, 'fontsize', 12);
set(gca, 'fontname', 'times');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition',[0, 0, 5, 5]);
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color',[1, 1, 1]);
daspect([1, 1, 1]);
% print('-depsc', '../Figures/part1_rosen_state.eps');
% print('-depsc', '../Figures/part2_objective_state.eps');
% print('-depsc', '../Figures/part3_multiple_state_ic2.eps');

%% PLOT THE RESULTS: CONVERGENCE HISTORIES

xstarrosen=[1,1];
for jj = 1:length(x)
    errorrosen(jj) = norm(x(jj,:)-xstarrosen, 2);
end

xstarobjective2=[0,0];
for jj = 1:length(x)
    errorobjective2(jj) = norm(x(jj,:)-xstarobjective2, 2);
end

% figure(2);
% semilogy(errorrosen, 'o-');
% xlabel('Iteration Number', 'interpreter', 'latex', 'FontSize', 14);
% ylabel('$\|x_{k}-x^{*}\|_{2}$', 'interpreter', 'latex', 'FontSize', 14);
% set(gca, 'fontsize',12);
% set(gca, 'fontname', 'times');
% set(gcf, 'Units', 'pixels');
% set(gcf, 'PaperUnits', 'inches', 'PaperPosition',[0, 0, 5, 3]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'InvertHardCopy', 'off');
% set(gcf, 'color', [1, 1, 1])
% print('-depsc', '../Figures/part1_rosen_convergence.eps');

% figure(2);
% semilogy(errorobjective2, 'o-');
% xlabel('Iteration Number', 'interpreter', 'latex', 'FontSize', 14);
% ylabel('$\|x_{k}-x^{*}\|_{2}$', 'interpreter', 'latex', 'FontSize', 14);
% set(gca, 'fontsize',12);
% set(gca, 'fontname', 'times');
% set(gcf, 'Units', 'pixels');
% set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 5, 3]);
% set(gcf, 'PaperPositionMode', 'manual');
% set(gcf, 'InvertHardCopy', 'off');
% set(gcf, 'color', [1, 1, 1])
% print('-depsc', '../Figures/part2_objective2_convergence.eps');

% figure(3);
% surf(x1,x2,func');
% hold on;
% plot(x(:,1),x(:,2));

%% EVAULUATE SOME STUFF

% [theminimimum, ~] = fhand(x(end,:)');
% [X, FVAL, exitflag, output] = fminunc(fhand, x0);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
