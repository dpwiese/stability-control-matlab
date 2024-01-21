%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 HW #2
% 2012-06-05
%---------------------------------------------------------------------------------------------------
% Description here
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;

restoredefaultpath;
addpath('tools');

thefontname = 'Times';
someotherfontsize = 10;
axislabelfontsize = 10;
titlefontsize = 10;
paperwidthinch = 5;
paperheightinch = 4;

%%

plot_circle(0, 0, 1)

xlim([-1.5, 1.5]);
ylim([-1.5, 1.5]);
daspect([1, 1, 1]);
grid on
hold on

plot_ellipse(0, 0, 1)

line([1, 0], [0, 1], 'linewidth', 2, 'linestyle', ':')
line([1, 1], [-1, 1], 'Linewidth', 2, 'Color', [0, 0.7, 0], 'linestyle', '--')
legend('(i)', '(ii)', '(iii)', '(iv)');
line([0, -1], [1, 0], 'linewidth', 2, 'linestyle', ':')
line([-1, 0],[0, -1], 'linewidth', 2, 'linestyle', ':')
line([0, 1], [-1, 0], 'linewidth', 2, 'linestyle', ':')
line([1, -1], [1, 1], 'Linewidth', 2, 'Color', [0, 0.7, 0], 'linestyle', '--')
line([-1, -1], [1 -1], 'Linewidth', 2, 'Color', [0, 0.7, 0], 'linestyle', '--')
line([-1, 1], [-1, -1], 'Linewidth', 2, 'Color', [0, 0.7, 0], 'linestyle', '--')

plot_axes;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

set(gca, 'FontName', thefontname);
set(gca, 'FontSize', someotherfontsize);
set(gca, 'XMinorGrid', 'off')
set(gca, 'YMinorGrid', 'off')
set(gca, 'MinorGridLineStyle', ':')
set(gca, 'GridLineStyle', ':')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Make plot look pretty
set(gcf, 'Units', 'pixels');
% set(gcf, 'OuterPosition', [50, 50, 600, 600]) %1520x980
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, paperwidthinch, paperheightinch]);
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', col.white)
titl = {'Different Unit Norms'};
title(titl,'interpreter','latex','FontSize',titlefontsize)
xlabel('$x_{1}$', 'interpreter', 'latex', 'FontSize', axislabelfontsize)
ylabel('$x_{2}$', 'interpreter', 'latex', 'FontSize', axislabelfontsize)
print('-depsc', '-r600', 'prob1_fig1.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%

x = linspace(-5, 5, 1000);

for i=1:length(x)
    y1(i) = -x(i)^3;
    y2(i) = (sin(x(i))^4);
    y3(i) = -2*x(i)^4+(sin(x(i)))^4;
    y4(i) = x(i)^2;
    y5(i) = sin(x(i))^2;
    y6(i) = x(i)^7;
    y7(i) = x(i)^2*(sin(x(i)))^8*(cos(3*x(i)))^2;
    y8(i) = x(i)^2;
    y9(i) = sin(x(i))^3;
end

figure(1)
plot(x, y1);
hold on
plot(x, y2);
ylim([-2, 2]);

figure(2)
plot(x, y3);
ylim([-2, 2]);

figure(3)
plot(x, y4);
hold on
plot(x, y5);
ylim([-2, 2]);

figure(4)
plot(x, y6);
hold on
plot(x, y7);
ylim([-2, 2]);

figure(5)
plot(x, y8);
hold on
plot(x, y9);
ylim([-2, 2]);

P = lyap([-2, 0; -3, -4]', [1, 0; 0, 1])

% fzero(@(x)x-1,0)
%f=-x^3+(sin(x))^4;

x0 = 0;

% % options=optimset('Display','iter');
% X=fsolve(sqr,x0);
%
%
% %function F = myfhand(x)
% sqr = @(x) -x^3+(sin(x))^4;
% %return

% sqr(5)

x = fzero(@(x)[-x^3+(sin(x))^4], x0)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
