%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #1
%---------------------------------------------------------------------------------------------------
% Problem 6 Master Script. This script sets up the various constraints for a constrained
% minimization problem, defines an initial guess, and then runs fmincon.m to solve the problem. The
% objective function and inequality constraints are stored in separate files and called using
% function handles.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all
clc;

fhand = @problem6_function;
conhand = @problem6_constraints;

A   = [];
B   = [];
Aeq = [];
Beq = [];
LB  = [];
UB  = [];

X0  = [3, 3];
[X, FVAL, EXITFLAG, OUTPUT] = fmincon(fhand, X0, A, B, Aeq, Beq, LB, UB, conhand);

% X=[7/16, 9/16];
% [f, ~] = fhand(X)
% bb = roots([4, -6, -4, -24]);
% x = bb(1);
% y = 4-(x-2)^2;
% X = [x, y];
% [f, ~] = fhand(X)
% lambda1 = 5 + 6 * x - 2 * y
% xx = (5+sqrt(21))/2
% X1 = [4.7912, -3.7913];
% X2 = [4.7912, 0.7913];
% X3 = [0.2087, -3.7913];
% X4 = [0.2087, 0.7913];
% [f, ~] = fhand(X4)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
