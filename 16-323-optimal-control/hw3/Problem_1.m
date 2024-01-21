%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #3
%---------------------------------------------------------------------------------------------------
% Problem 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

A2 = (5-2*exp(2))/(exp(-2)-exp(2));
A1 = 2 - A2;

xoft = @(t) -1 + A1 * exp(2*t) + A2 * exp(-2*t);

t = linspace(0, 1, 101);

x = xoft(t);

figure(1)
plot(t, x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
