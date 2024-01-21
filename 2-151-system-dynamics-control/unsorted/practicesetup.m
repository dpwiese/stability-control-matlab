% 2.151 Practice Session #x?
% LQR controller for Segway

close all;
clear all;
clc;
s = tf('s');

% Constants
m_w     = 8;
m       = 92;
b_m     = .1;
b_r     = .02;
r       = .15;
g       = 9.8;
l       = .8;
T_s     = 1;
B_damp  = [b_r+b_m -b_m;-b_m b_m];
I       = [(3*m_w/2+m).*r^2 m*r*l;m*r*l (4*m*l^2)/3];

% Set up system matrices
A = zeros(3);
A(1,:) = [ 0 0 1];
A(2:3,:) = [inv(I)*[0;m*g*l] -inv(I)*B_damp];
B = [0;inv(I)*[1;-1]];
C = [1 0 0;0 r l];
D = [0; 0];

stspcsys = ss(A,B,C,D);
zpksys = zpk(stspcsys);

OS_damp = sqrt((log(.02))^2/(pi^2+(log(.02))^2));
w = 4/(T_s*OS_damp);

C1  =  [1 0 0];  %output: angle from upright, theta
D1 = [0];
sys_1  =  ss(A,B,C1,D1);
zpksys1 = zpk(sys_1);
[p1,z1]  =  pzmap(sys_1);

C2  =  [0 r l];   %output: forward speed of platform & passenger % C2  =  [0 R 0];   %output: forward speed of wheels
D2 = [0];
sys_2  =  ss(A,B,C2,D2);
zpksys2 = zpk(sys_2);
[p2,z2]  =  pzmap(sys_2);

figure(1)
subplot(2,1,1), pzmap(sys_1);
title('Transfer function: torque input to angle from upright')
hold on
subplot(2,1,2), pzmap(sys_2);        % Note the unstable zero
title('Transfer function: torque input to forward speed')

%% Pole Placement
pdes(1) = z1;
% pdes(2) = p1(1);
% pdes(3) = p1(3);
pdes(2) = -10+10*1i;
pdes(3) = -10-10*1i;

Kpp = place(A,B,pdes);

Aclpp = A-B*Kpp;

clsyspp = ss(Aclpp,[0;0;0],C1,D1);

x0theta = 5*pi/180;
x0 = [x0theta;0;0];

figure(2)
initial(clsyspp,x0);

%% LQR Controller
q1 = 1; %theta (rod angle)
q2 = 1; %phi (wheel angle)
q3 = 1; %omega (wheel angular velocity)
r1 = 0.1;
Rlqr = diag([r1],0);
Qlqr = diag([q1 q2 q3],0);
Klqr = lqr(A,B,Qlqr,Rlqr);

Acllqr = A-B*Klqr;

clsyslqr = ss(Acllqr,[0;0;0],C1,D1);
clsyslqr2 = ss(Acllqr,B,C1,D1);

x0theta = 5*pi/180;
x0 = [x0theta;0;0];

[vlqr,elqr] = eig(Acllqr);

figure(3)
initial(clsyslqr,x0);

figure(4)
pzmap(clsyslqr2)

%% Observer
pdesLpp(1) = -1;
pdesLpp(2) = -10;
pdesLpp(3) = -11;

Lpp = place(A',C',pdesLpp).';
obssys = ss(A-Lpp*C,[0;0;0],C1,D1);

figure(5)
initial(obssys,x0);

figure(6)
pzmap(obssys)

% figure(7)
% step(obssys)
