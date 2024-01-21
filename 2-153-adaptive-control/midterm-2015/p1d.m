clear all;
close all;

B = [-1, -3; 0, -1];

syms('t');
expm(B*t);
Omega = [0, -1; 1, 0];
expm(Omega*t);

OmegaB = Omega + B;
[V, D] = eig(OmegaB);
expm((Omega+B)*t);
