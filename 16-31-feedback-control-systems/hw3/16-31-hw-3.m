%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.31 - HW #3
% Due: Friday 9/30/2011 11:00am
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clc;
clear all;
s = tf('s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #1

Klead = 1562;
zlead = 3.1;
plead = 15.7;

Klag = 1;
zlag = 0.1;
plag = 0.01;

Gp = 1/((s+1)*(s+4)*(s+10));
Glead = (Klead*(s+zlead))/(s+plead);
Glag = (Klag*(s+zlag))/(s+plag);

H = (Glead*Glag*Gp)/(1+Glead*Glag*Gp);

figure(1)
subplot(1,2,1)
bode(Gp*Glead*Glag)
grid on
subplot(1,2,2)
step(H)
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #2

close all;
clc;
clear all;
s = tf('s');

K = 67;
z = 0.2;
p = 0.017;

% Gc=67;
Gc = (K*(s+z))/(s+p);
Gp = 1/((s+1)*(s+4)*(s+4));

H = (Gp*Gc)/(1+Gp*Gc);

figure(1)
subplot(1, 2, 1)
bode(Gp*Gc)
grid on
subplot(1,2,2)
step(H)
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #3

close all;
clc;
clear all;
s = tf('s');

p = 27;
K = 96;
z = 100;

G = (K*(s/z+1))/(s*(s/p+1));

figure(1)
bode(G)
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #4

close all;
clc;
clear all;
s = tf('s');

T = 0.01;
Gp = (s+10)/((s+100)*(s^2+10*s+1600));
GTD = (1-0.5*T*s)/(1+0.5*T*s);
G = Gp*GTD;

x = 3;
y = 8;
K = 19e5;
p1 = 2;
z1 = 10;
p2 = 26;
z2 = 50;

Gc = (K*(s/z1+1)^x*(s/z2+1)^y)/((s/p1+1)^x*(s/p2+1)^y);

L = G*Gc;
H = (G*Gc)/(1+G*Gc);

figure(1)
bode(L)
grid on
title('Open-Loop Bode: L(s)')

figure(2)
bode(H)
grid on
title('Closed-Loop Bode: H(s)')

figure(3)
step(H)
title('Step Response for Closed-Loop System')
xlabel('time [s]')
ylabel('Output')
grid on

figure(4)
bode(G)
title('Uncompensated Open-Loop Bode')
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
