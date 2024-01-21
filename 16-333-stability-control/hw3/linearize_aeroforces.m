%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #2
% Due: Thursday March 22, 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc;

xihatB = [...
    0,        0,   -0.0006,  8.2248;
    0,        0,   0,        0;
    0.0006,   0,   0,        0.4043;
    0,        0,   0,        0];

[fB, tauB, vel, aer] = aero_forces(geo, XYZ, xihatB, aer);
fB1 = fB;
tauB1 = tauB;

xihatB = [...
    0,        0,   -0.0006,  9.2248;
    0,        0,   0,        0;
    0.0006,   0,   0,        0.4043;
    0,        0,   0,        0];

[fB, tauB, vel, aer] = aero_forces_v1(geo, XYZ, xihatB, aer);
fB2 = fB;
tauB2 = tauB;

xihatB = [...
    0,        0,   -0.0006,  7.2248;
    0,        0,   0,        0;
    0.0006    0,   0,        0.4043;
    0,        0,   0,        0];

[fB, tauB, vel, aer] = aero_forces_v1(geo, XYZ, xihatB, aer);
fB3 = fB;
tauB3 = tauB;

dXdu1 = fB2(1)-fB1(1)
% dXdu2=fB3(1)-fB1(1)

dYdu1 = fB2(2)-fB1(2)
% dYdu2=fB3(2)-fB1(2)

dZdu1 = fB2(3)-fB1(3)
% dZdu2=fB3(3)-fB1(3)

dLdu1 = tauB2(1)-tauB1(1)
% dLdu2=tauB3(1)-tauB1(1)

dMdu1 = tauB2(2)-tauB1(2)
% dMdu2=tauB3(2)-tauB1(2)

dNdu1 = tauB2(3)-tauB1(3)
% dNdu2=tauB3(3)-tauB1(3)
