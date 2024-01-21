%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #1
%---------------------------------------------------------------------------------------------------
% Tester script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all
clc;

% Make function handle for the Rosenbrock function
frosen = @(x1,x2) (1-x1)^2+100*(x2-x1^2)^2;

% xk is estimated location of minimum
% gk is gradient
% dk is search direction

xk = [3, -2]';
[f, g] = rosen(xk);
gk = g;
dk = [-1, 0]';
dk = dk / norm(dk, 2);

% frosen(1,2)

%---------------------------------------------------------------------------------------------------

% Plot the function
x1min = -4;
x1max = 4;
x2min = -4;
x2max = 4;

x1 = linspace(x1min, x1max, 100);
x2 = linspace(x2min, x2max, 100);

for ii = 1:length(x1)
    for jj = 1:length(x2)
        func(ii, jj) = frosen(x1(ii), x2(jj));
    end
end

figure(1)
contour(x1, x2, func', 100);
hold on;

%---------------------------------------------------------------------------------------------------

% Calculate and plot the line that is the arbitrary search direction
linex1 = [xk(1)-10*dk(1), xk(1)+10*dk(1)];
linex2 = [xk(2)-10*dk(2), xk(2)+10*dk(2)];

plot(xk(1), xk(2), '.', 'MarkerSize', 60, 'Color', [1, 0, 0]);
plot(linex1, linex2, '-', 'linewidth', 3, 'color', [1,0,0]);

%---------------------------------------------------------------------------------------------------

% Given a function, initial point and gradient at that point, and search direction, perform a line
% search along this direction to find the minimum.
[alpha, xk1, fk1, gk1, bracketend, a, lambdatilde] = linesearch(frosen, xk, gk, dk);

% Can plot the minimum found by doing a line search along an arbitrary direction
plot(a(1,:), a(2,:), 'o', 'MarkerSize', 8, 'Color', [0.5, 0.5, 0.5], 'linewidth', 2);
plot(bracketend(1,:), bracketend(2,:), 'o', 'MarkerSize', 13, 'Color', [1, 0, 0], 'linewidth', 2);
plot(lambdatilde(1), lambdatilde(2), '.', 'MarkerSize', 60, 'Color', [0, 0, 0]);
grid on;
text(bracketend(1,1)+0.2, bracketend(2,1), '$\lambda_{l}$', 'interpreter', 'latex', 'FontSize', 16);
text(bracketend(1,2)+0.2, bracketend(2,2), '$\lambda_{u}$', 'interpreter', 'latex', 'FontSize', 16);

figure(2)
surf(x1, x2, func');

%---------------------------------------------------------------------------------------------------
