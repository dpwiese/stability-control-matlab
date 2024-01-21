%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #2
% Due: Thursday March 22, 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

% USER INPUTS
% Balsa glider geometry
b_wing  = 0.45;     % m (wingspan)
c_wing  = 0.075;    % m (wing chord)
b_htai  = 0.18;     % m (horizontal tail span)
c_htai  = 0.04;     % m (horitontal tail chord)
h_vtai  = 0.09;     % m (vertical tail height)
c_vtai  = 0.04;     % m (vertical tail chord)
rho     = 0.38;     % kg/m^2 (density of balsa per unit area)
m_tip   = 0.010;    % kg (weight at tip)
l_wing  = 0.025;    % m (distance from nose to LE of wing)
l_htai  = 0.23;     % m (distance from nose to LE of horizontal tail)
l_vtai  = 0.23;     % m (distance from nose to LE of vertical tail)

S_wing  = b_wing*c_wing;        % m^2 (wing planform area)
S_htai  = b_htai*c_htai;        % m^2 (horizontail tail area)
S_vtai  = h_vtai*c_vtai;        % m^2 (vertical tail area)
AR_wing = (b_wing)^2/S_wing;    % dimensionless (Aspect ratio of wing)
AR_htai = (b_htai)^2/S_htai;    %d imensionless (Aspect ratio of horizontal tail)

e_wing = 0.9; % dimensionless (oswald efficiency of wing)
e_htai = 0.9; % dimensionless (oswald efficiency of horizontal tail)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Calculate mass properties of glider
[m_totl, CG, J] = mass_prop(rho, m_tip, S_wing, S_htai, S_vtai, l_wing, l_htai, l_vtai, c_wing, c_htai, c_vtai, b_wing, b_htai, h_vtai);

omegaB0 = [0, 0, 0];
vB0     = [1, 0, 0];
q0      = [1, 0, 0, 0];
Delta0  = [1, 1, 1];

X0 = [omegaB0, vB0, q0, Delta0];

% [CL]=calcCL(AR_wing,alpha);
% [CD]=calcCD(AR_wing,CL,e);
% [alpha,beta,VT]=uvw2Valbe(u,v,w);
