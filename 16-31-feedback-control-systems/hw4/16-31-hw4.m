%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.31 - HW #4
% Last updated October 14th, 2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
clc;
s = tf('s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #1

A = [-0.0322, 0; -9.6144, -0.0542];
B = [0.1622; -0.3154];
C = [1,0; 0,1];
D = [0; 0];

ss_sys = ss(A, B, C, D);

[num, den] = ss2tf(A, B, C, D, 1);

gamman = tf(num(1,:), den);
vn = tf(num(2,:), den);

figure(1)
subplot(2, 1, 1)
rlocus(gamman)
title('Root Locus for n to \gamma')

subplot(2, 1, 2)
rlocus(vn)
title('Root Locus for n to v')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #3

close all;
clear all;
clc;
s = tf('s');

t = linspace(0,10,100);

A = [   0,      1,      0,      0;
        0,      0,      1,      0;
        0,      0,      0,      1;
      -27,    -36,    -12,     -4];
B = [0; 0; 0; 0];
C = [1, 0, 0, 0];
D = [0];

ANEW = A - [0; 0; 0; 1] * [0, 1, 8, 2];

sys = ss(ANEW, B, C, D);

[v, d] = eig(A);
[vnew, dnew] = eig(ANEW)

% % Eigenvectors for part B
% x0v1 = real(v(:,1)) + imag(v(:,1));
% x0v2 = real(v(:,2)) + imag(v(:,2));
% x0v3 = real(v(:,3)) + imag(v(:,3));
% x0v4 = real(v(:,4)) + imag(v(:,4));

% Eigenvectors for part C
x0v1 = real(vnew(:,1)) + imag(vnew(:,1));
x0v2 = real(vnew(:,2)) + imag(vnew(:,2));
x0v3 = real(vnew(:,3)) + imag(vnew(:,3));
x0v4 = real(vnew(:,4)) + imag(vnew(:,4));

% Simulate system from eigenvalue 1
[yv1, t, xv1] = lsim(sys, 0*t, t, x0v1);
[yv2, t, xv2] = lsim(sys, 0*t, t, x0v2);
[yv3, t, xv3] = lsim(sys, 0*t, t, x0v3);
[yv4, t, xv4] = lsim(sys, 0*t, t, x0v4);

figure(1)
subplot(2, 2, 1)
plot(t, xv1(:,1), '-b', 'linewidth', 2)
title('MODE 1 - Initial Condition: \lambda_1')
hold on
grid on
plot(t, xv1(:,2), '-k', 'linewidth', 2)
plot(t, xv1(:,3), '--r', 'linewidth', 2)
plot(t, xv1(:,4), '--g', 'linewidth', 2)
legend('x_1','x_2','x_3','x_4')
hold off

subplot(2, 2, 2)
plot(t,xv2(:,1),'-b','linewidth',2)
title('MODE 1 - Initial Condition: \lambda_2')
hold on
grid on
plot(t, xv2(:,2), '-k', 'linewidth', 2)
plot(t, xv2(:,3), '--r', 'linewidth', 2)
plot(t, xv2(:,4), '--g', 'linewidth', 2)
legend('x_1', 'x_2', 'x_3', 'x_4')
hold off

subplot(2, 2, 3)
plot(t, xv3(:,1), '-b', 'linewidth', 2)
title('MODE 2 - Initial Condition: \lambda_3')
hold on
grid on
plot(t, xv3(:,2), '-k', 'linewidth', 2)
plot(t, xv3(:,3), '--r', 'linewidth', 2)
plot(t, xv3(:,4), '--g', 'linewidth', 2)
legend('x_1', 'x_2', 'x_3', 'x_4')
hold off

subplot(2, 2, 4)
plot(t, xv4(:,1), '-b', 'linewidth', 2)
title('MODE 3 - Initial Condition: \lambda_4')
hold on
grid on
plot(t, xv4(:,2), '-k', 'linewidth', 2)
plot(t, xv4(:,3), '--r', 'linewidth', 2)
plot(t, xv4(:,4), '--g', 'linewidth', 2)
legend('x_1', 'x_2', 'x_3', 'x_4')
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #4

clc;
clear all;
close all;

A1 = [2, 3; 4, 5];
B1 = inv(A1);
A1*B1;
B1*A1;

expm(A1)*expm(B1)
expm((A1+B1))

A2 = [2, 3; 4, 5];
B2 = [3, 3; 5, 5];

expm(A2)*expm(B2)
expm(A2+B2)
A2*B2;
B2*A2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
