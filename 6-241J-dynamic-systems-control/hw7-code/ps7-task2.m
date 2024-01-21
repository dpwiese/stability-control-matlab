%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 6.241 Homework Assignment #7
% Task 2
% Due: Friday April 27, 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

s = tf('s');
a = -1;

P0 = (s-a)/(s^2);

[A,B,C,D] = tf2ss(P0.num{1},P0.den{1});

% G = (s-1)/(s+1);
G = (s-a)/(s^2+0.000001);

W1 = 1;
% W1 = 0.1*(s+100)/(100*s+1);
W2 = 1;
W3 = [];

P = augw(G,W1,W2,W3);
[K,CL,GAM,INFO] = hinfsyn(P,1,1);

sigma(CL,ss(GAM));

% [K,CL,GAM,INFO] = hinfsyn(P);
