%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16.31 HW #6
% Daniel Wiese
% Due: Fri 11/4/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #1 - Check answers

clc;
clear all;
close all;

rho = 1;
M = 1;

A = [0, 1; 0, 0];
B = [0;1/M];
Q = [1, 0; 0, 0];
R = rho^2;

K = lqr(A, B, Q, R)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #2a,b - LQR Controller Design

clc;
clear all;
close all;

Ra = 0.01;
QI = 100;
Rtild = Ra;

uncert = 0.1;
A = [1, 1; 1, 2];
B = [1; 0];
C = [1, 0];
Qa = [1, 0; 0, 1];
Qtild = [Qa, zeros(2,1); zeros(1,2), QI];
r = 1;
Aprime = [A, zeros(2,1); C, 0];
B1prime = [1; 0; 0];
B2prime = [0; 0; -1];

Ka = lqr(A, B, Qa, Ra);
x = inv(A-B*Ka)*-B*r;
K = Ka;

[tsim, simout] = sim('HW6prob2a');

figure(1)
plot(tsim, simout(:,1), '-b', 'linewidth', 2)
hold on
grid on

Nbarb = 0.5*(1-K(2))-(1-K(1));
Kb = Ka;
K = Kb;

[tsim, simout] = sim('HW6prob2b');

plot(tsim, simout(:,1), '--k', 'linewidth',2)

Kc = lqr(Aprime, B1prime, Qtild, Rtild);

[tsim, simout] = sim('HW6prob2c');

plot(tsim, simout(:,1), '-r', 'linewidth', 2)
legend('LQR', 'LQR Feed-Forward', 'LQR Servo');
title('Step Response Using Three Different Controllers: Actual Plant')
xlabel('time [s]')
ylabel('output (y)')
axis([0, 6, -0.6, 1.2])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #3a

clc;
clear all;
close all;
s = tf('s');

z1 = -2.8;
p1 = 75;

Ka = -50;

% Given plant
G = (s+3.5)/((s+1)*(s+2));
Gca = ((s+z1)/(s+p1));

A = [0, 1; -2, -3];
B = [0; 1];
C = [3.5, 1];
D = [0];

Mc = ctrb(A, B);
Kb = acker(A, B, [-4.0+4.0*i, -4.0-4.0*i]);
Mo = obsv(A, C);
L = acker(A', C', [-8.0+4.0*i,-8.0-4.0*i]).';

AC = A-B*Kb-L*C;
BC = L;
CC = Kb;
Gcb = CC*inv(s*eye(2,2)-AC)*BC;
minreal(Gcb)

Kb2 = 1;

[ya, ta] = step((Ka*Gca*G)/(1+Ka*Gca*G));
[yb, tb] = step((Kb2*Gcb*G)/(1+Kb2*Gcb*G));

figure(1)
plot(ta, ya, '--k')
title('Step Response for Classical (a) vs. DOFB (b)')
hold on
plot(tb, yb)
grid on
legend('a', 'b')
xlabel('Time (s)')
ylabel('output')

figure(2)
subplot(2, 2, 1)
rlocus(-G*Gca)
title('Root Locus a')
grid on % daspect([1, 1, 1])

subplot(2, 2, 3)
rlocus(G*Gcb)
title('Root Locus b')
grid on % daspect([1, 1, 1])

subplot(2, 2, 2)
bode(G*Gca)
title('Bode a')
grid on

subplot(2, 2, 4)
bode(G*Gcb)
title('Bode b')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
