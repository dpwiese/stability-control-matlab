%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 16.31 - HW #2
% Daniel Wiese
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #1 - Designing a compensator to meet specifications

clc;
clear all;
close all;

s = tf('s');
% z = 2;
% p = 4*z;
% K = 27.2;

z = 2.84;
p = 10*z;
K = 56;

GP = 1/(s^2+2*s+2);
GC = (s+z)/(s+p);

F = GC*GP;

figure(1)
rlocus(F)
daspect([1, 1, 1])
grid on
axis([-30, 0, -15, 15])

H = (K*GC*GP)/(1+K*GC*GP);
% [y,t]=step(H,5);
figure(2)
% plot(t,y)
step(H)

% H2=(GP)/(1+K*GC*GP); %controller in feedback loop
% [y,t]=step(H2,5);
% figure(3)
% plot(t,y)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #2a - Bode and Nyquist Plots

clc;
clear all;
close all;

s = tf('s');

G = (60*(s+1))/((s+0.1)*(s+10)*(s-2));

figure(1)
Bode(G)
grid on

figure(2)
Nyquist(G)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #2b - Bode and Nyquist Plots

clc;
clear all;
close all;

s = tf('s');

G = (60*(s+1))/((s+0.1)*(s^2-4));

figure(1)
Bode(G)
grid on

figure(2)
Nyquist(G)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #2c - Bode and Nyquist Plots

clc;
clear all;
close all;

s = tf('s');

G = (60*(s+1))/((s+0.1)*(s^2+6*s+25));

figure(1)
Bode(G)
grid on

figure(2)
Nyquist(G)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #3

% clc;
% clear all;
% close all;

s = tf('s');
K = 0.398;
p = 40;
G = (10*s+1)/((s+1)*(s/sqrt(10)+1)^2*(s/p+1));

% figure(1)
% bode(G)
% grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #3 - Inputs for SISOTOOL

close all
clc
clear all

s = tf('s');
K = 1;
p = 10;

CC = K/(s/p+1);
GG = (10*s+1)/((s+1)*(s/sqrt(10)+1)^2);

L = 100/((s/5+1)^2);

bode(L)
grid on

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
