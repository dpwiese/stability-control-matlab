%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #3
%---------------------------------------------------------------------------------------------------
% Problem 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% Plant parameters
A   = [0, 1; -6, -5];
B   = [0; 1];
Cz1 = [1, 1];
Cz2 = [1, -1];

% Weights
rho     = 0.01;
Rzz     = 1;
Rxx1    = Cz1'*Rzz*Cz1;
Rxx2    = Cz2'*Rzz*Cz2;
Ruu     = rho;

% Solve Riccati equation
[P1,~,F1] = care(A, B, Rxx1, Ruu, zeros(2,1), eye(2,2));
[P2,~,F2] = care(A, B, Rxx2, Ruu, zeros(2,1), eye(2,2));

% Calculate closed-loop matrices
Acl1 = A-B*F1;
Acl2 = A-B*F2;

% Define closed-loop systems
sys1 = ss(Acl1, B, Cz1, zeros(1,1));
sys2 = ss(Acl2, B, Cz2, zeros(1,1));

% Get initial condition response
[Y1, T1, X1] = initial(sys1, [1; 0], 10);
[Y2, T2, X2] = initial(sys2, [1; 0], 10);

% Calculate control effort
U1 = F1*X1';
U2 = F2*X2';

% Plot
figure(1)

subplot(2, 1, 1)
plot(T1, U1, '-', 'linewidth', 3, 'color', [0.6, 0.6, 0.6]);
hold on;
plot(T2, U2, '--', 'linewidth', 3, 'color', [0, 0, 0]);
xlabel('$t$', 'interpreter', 'latex', 'FontSize', 12);
ylabel('$u$', 'interpreter', 'latex', 'FontSize',12);
h = legend('Part 1', 'Part 2');
set(h, 'Interpreter', 'Latex', 'Location', 'NorthEast', 'Fontsize', 12);

subplot(2, 1, 2)
plot(T1, Y1, '-', 'linewidth', 3, 'color', [0.6, 0.6, 0.6]);
hold on;
plot(T2, Y2, '--', 'linewidth', 3, 'color', [0, 0, 0]);
xlabel('$t$', 'interpreter', 'latex', 'FontSize', 12);
ylabel('$z$', 'interpreter', 'latex', 'FontSize', 12);

set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 6, 4]);
set(gcf, 'PaperPositionMode', 'manual')
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1]);
set(gca, 'FontSize', 12);
set(gca, 'FontName', 'Times');
print('-depsc', '-r600', '../Figures/prob5.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
