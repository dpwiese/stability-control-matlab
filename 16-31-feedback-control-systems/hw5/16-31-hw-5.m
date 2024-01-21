%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.31 HW #5
% Due: 10/28/11
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;
close all;
clear all;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #1a - Checking answers
% Controllability and Observability of given system

A = [-1, 3; 1, 6];
B = [1, 1; 0, 0];
C = [2, -1];
D = [1, 0];

Mc = [B, A*B];
Mo = [C; C*A];

rankMc = rank(Mc)
rankMo = rank(Mo)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #1b - Checking answers
% Controllability and Observability of given system

clc;
close all;
clear all;

A = [1, 2, 1; 1, -3, 0; -1, 0, -3];
B = [0; 1; 1];
C = [1, 0, 0];
D = [-1];

Mc = [B, A*B, A^2*B];
Mo = [C; C*A; C*A^2];

rankMc = rank(Mc)
rankMo = rank(Mo)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #2a

clc;
close all;
clear all;
s = tf('s');

% GIVEN TRANSFER FUNCTION MATRIX
% First input each element of the given transfer function matrix
% This data can be used to check my answers against later on
G11=7/(s+3);
G12=(7.5*s+15)/(s^2+7*s+10);
G21=(2*s+10)/(s^2+8*s+15);
G22=6/(s+2);
G=[G11, G12; G21, G22];

% Find minimum realization of given transfer function matrix and convert to state-space
minrz_1 = minreal(G);
ss_1 = ss(G);

A = ss_1.a;
B = ss_1.b;
C = ss_1.c;
D = ss_1.d;

rank_Mc = rank(ctrb(A,B))
rank_Mo = rank(obsv(A,C))

% PART A - MY STATE-SPACE MODEL
% Input my state-space model developed using technique at bottom of 8-5

A1 = [ -3,      0,      0,      0,      0,      0;
        0,      0,      1,      0,      0,      0;
        0,    -10,     -7,      0,      0,      0;
        0,      0,      0,      0,      1,      0;
        0,      0,      0,    -15,     -8,      0;
        0,      0,      0,      0,      0,     -2];

B1 = [  1,  0;
        0,  0;
        0,  1;
        0,  0;
        1,  0;
        0,  1];

C1 = [  7,     15,    7.5,      0,      0,      0;
        0,      0,      0,     10,      2,      6];

D1 = [  0,  0;
        0,  0];

% Convert my state-space model into transfer function matrix and find minimum realization
ss_2 = ss(A1, B1, C1, D1);
tf_2 = tf(ss_2);
minrz_2 = minreal(tf_2);

% PART B - MY STATE-SPACE MODEL: GILBERTS REALIZATION
Ag = diag([-3, -5, -2],0);
Bg = [  1, 0;
        0, 1;
        0, 1];
Cg = [  7, 7.5, 0;
        2, 0, 6];
Dg = [  0, 0;
        0, 0];

ss_g = ss(Ag,Bg,Cg,Dg);

% Dont need to put this in minimum realization form, because Gilberts Realization does that
% automatically
tf_g = tf(ss_g);

ctrb(Ag, Bg)
obsv(Ag, Cg)

rank_Mc_g = rank(ctrb(Ag, Bg))
rank_Mo_g = rank(obsv(Ag, Cg))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
