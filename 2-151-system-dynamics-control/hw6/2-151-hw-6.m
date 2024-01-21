%% PROBLEM #1
clear all; clc; close all;

A = [0 1; -10 -2];
B = [0;2];
C = [10 0];
D = [0];

Mo = obsv(A,C);
isitobsv = rank(Mo);

%% PROBLEM #2
clear all; clc; close all; s = tf('s');

A = [-5 0 0; 0 -1 1; 0 -3 -2];
B = [2; 2; 0];
C = [2 0 1];
D = [0];

K = place(A,B,[-5+5*1i -5-5*1i -20]);

sys = ss(A-B*K,[0;0;0],C,D);

G = C*inv(s*eye(3,3)-A+B*K)*B;
rlocus(G)

m = idss(A,B,C,D,'SSParameterization','Canonical')

%% PROBLEM #3
clear all; clc; close all; s = tf('s');

A = [-4 0; -1 -3];
B = [1; 0];
C = [1 2];
D = [0];

Ltrans = acker(A',C',[-50,-50]);
L = Ltrans'

%% PROBLEM #4
clear all; clc; close all; s = tf('s');

mr = 92; %mass of chassis and person [kg]
mw = 8; %wheel mass [kg]
R = 0.15; %wheel radius [m]
L = 0.8; %distance from axle to person CG [m]
g = 9.8; %gravity [m/s^2]
bm = 0.1; %motor damping [N-m/rad/s]
bw = 0.02; %wheel damping [N-m/rad/s]
Iw = (mw*R^2)/2; %calculate moment of inertia of wheel
Ir = (mr*(2*L)^2)/3; %calculate moment of inertia of person

B = [0; 0; 1/R; 0];
Cvel = [0 0 1 0];
Cang = [0 1 0 0];

M = [mw+(Iw/(R^2))+mr  -mr*L; -mr*L Ir+mr*L^2];
b = [(bm+bw)/R -bm; bm/R -bm];
Z = zeros(2,2);

MM = [eye(2,2) Z; Z M];
BB = [Z, -eye(2,2); Z b];

Afinal = -inv(MM)*BB
Bfinal = inv(MM)*B
D = 0;

sys = ss(Afinal,Bfinal,Cvel,D);

Gvel = Cvel*inv(s*eye(4,4)-Afinal)*Bfinal;
Gvel = minreal(Gvel);

TF = zpk(sys)

[v,e] = eig(Afinal)

pzmap(sys)
