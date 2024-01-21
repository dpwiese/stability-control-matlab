%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
clear all;
close all;

t0 = 0;
t1 = t0+2;
t2 = t1+(3*pi)/2;
t3 = t2+2;
t4 = t3+(3*pi)/2;

omega_B1 = [0, 0, 0];
v_B1     = [1, 0, 0.2];
omega_B2 = [0, 0, 1];
v_B2     = [1, 0, 0];
omega_B3 = [0, 0, 0];
v_B3     = [1, 0, -0.2];
omega_B4 = [0, 0, -1];
v_B4     = [1, 0, 0];

p0I = eye(4,4)
g1  = twst2g(omega_B1, v_B1, t1);
p1I = g1*p0I
g2  = twst2g(omega_B2, v_B2, t2-t1);
p2I = g2*p1I
g3  = twst2g(omega_B3, v_B3, t3-t2);
p3I = g3*p2I
g4  = twst2g(omega_B4, v_B4, t4-t3);
p4I = g4*p3I
