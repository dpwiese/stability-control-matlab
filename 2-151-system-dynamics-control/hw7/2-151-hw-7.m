%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.151 - HW #7
% Due Mon. 11/28/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #1

clear all;
close all;
clc;
s = tf('s');

A = [0, 1; 31250, 0];
B = [0; 25];
C = eye(2,2);
D = [0; 0];

x0 = [200e-6; 0];
x1_max = 200e-6;
r_max = 3.5;

Q = diag([1/x1_max^2 0],0);
R = 1.2/r_max^2;
K = lqr(A, B, Q, R);

t_sim = 0.02;

line_width = 2;

Acl = A-B*K;
eig_val = eig(Acl);
omega_n = sqrt(real(eig_val(1))^2+imag(eig_val(1))^2);
zeta = abs(real(eig_val(1)))/omega_n;
omega_bw = omega_n*sqrt(1-2*zeta^2+sqrt(2-4*zeta^2+4*zeta^4));

[tsim, simout] = sim('problem1');

figure(1)
subplot(2,2,1)
plot(tsim, simout(:,1), 'linewidth', line_width)
title('output: x_1(t)');
xlabel('time (t) [s]');
ylabel('output [m]');
grid on
subplot(2,2,2)
plot(tsim, simout(:,2), 'linewidth', line_width)
title('output: x_2(t)');
xlabel('time (t) [s]');
ylabel('output [m/s]');
grid on
subplot(2,2,3)
plot(tsim, conteff, 'linewidth', line_width)
title('input: \deltai(t)');
xlabel('time (t) [s]');
ylabel('input [amp]');
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PROBLEM #2

clear all;
close all;
clc;
s = tf('s');

line_width = 2;

A = [0, 1; 12, -4];
B = [0; 2];
C = [20, 2];
D = 0;

Cfsfb = eye(2,2);
Dfsfb = [0; 0];

x0 = [0; 0.049];
r_max = 0.1;

Q = C'*C;
R = 1/r_max^2;
K = lqr(A, B, Q, R);

A_cl = A-B*K;
B_cl = [0; 0];

sys_ol = ss(A, B, C, D);
sys_cl = ss(A_cl, B_cl, C, D);

TF_ol = minreal(C*inv(s*eye(2,2)-A)*B);
TF_cl = C*inv(s*eye(2,2)-A_cl)*B_cl;

zpk_ol = zpk(sys_ol);
zpk_cl = zpk(sys_cl);

t_sim = 5;
[tsim, simout] = sim('problem2');

output = 20 * simout(:,1) + 2 * simout(:,2);

figure(1)
subplot(2, 1, 1)
plot(tsim, output, 'linewidth', line_width)
title('output: y(t)');
xlabel('time (t)');
ylabel('output');
grid on
subplot(2, 1, 2)
plot(tsim,conteff, 'linewidth', line_width)
title('input: u(t)');
xlabel('time (t)');
ylabel('input');
grid on

figure(2)
pzmap(sys_cl)
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
