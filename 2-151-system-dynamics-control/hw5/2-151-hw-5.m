%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.151 - HW #5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #2

clear all;
close all;
clc;
s = tf('s');

% Constants
rho = 62.4;     % [lb/ft^3]
% rho = 0.03715;  % [lb/in^3]
g = 32.2;       % [ft/s^2]

% Diameters of tube sections [in]
d1 = 1;
d2 = 1;
d3 = 1;
d4 = 3.75;
d5 = 3.75;

% Initial height of water in vertical tubes [in]
h1 = 7.5;
h2 = 7.5;
h3 = 7.5;

% Horizontal spacing of vertical tubes [in]
l4 = 9;
l5 = 9;

% Calculate cross-sectional tube areas [in^2]
A1 = pi * (d1^2) / 2;
A2 = pi * (d2^2) / 2;
A3 = pi * (d3^2) / 2;
A4 = pi * (d4^2) / 2;
A5 = pi * (d5^2) / 2;

I1 = (rho*h1) / A1;
I2 = (rho*h2) / A2;
I3 = (rho*h3) / A3;
I4 = (rho*l4) / A4;
I5 = (rho*l5) / A5;

M = [ -A1*(I1+I4),      A2*I2,          0;
                0,     -A2*I2, A3*(I3+I5);
               A1,         A2,         A3];

K = [   rho*g, -rho*g,      0;
            0,  rho*g, -rho*g;
            0,      0,      0];

F = [   1, -1;
        0,  1;
        0,  0];

A = [   zeros(max(size(M)), max(size(M))),   eye(max(size(M)), max(size(M)));
                                 inv(M)*K,  zeros(max(size(M)),max(size(M)))];
B = [zeros(3,2); inv(M)*F];
C = [   1, 0, 0, 0, 0, 0;
        0, 1, 0, 0, 0, 0];
D = 0;

[v, e] = eig(A);

G = C * inv(s*eye(6,6)-A) * B;

zpk(G)
pzmap(G)

figure(1)

subplot(2, 2, 1)
bode(G(1,1))
grid on
axis([0.5, 6, -270, 270])

subplot(2, 2, 2)
bode(G(2,1))
grid on
axis([0.5, 6, -270, 270])

subplot(2, 2, 3)
bode(G(1,2))
grid on
axis([0.5, 6, -270, 270])

subplot(2, 2, 4)
bode(G(2,2))
grid on
axis([0.5, 6, -270, 270])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #4 SYMBOLICALLY

clear all;
close all;
clc;

s       = sym('s');
wn1     = sym('wn1');
wn2     = sym('wn2');
zeta1   = sym('zeta1');
zeta2   = sym('zeta2');
z1      = sym('z1');
z2      = sym('z2');


L = (((1+s/z1)*(1+s/z2))/((s^2+2*zeta1*wn1*s+wn1^2)*(s^2+2*zeta2*wn2*s+wn2^2)))*(wn1^2*wn2^2);

num = ((1+s/z1)*(1+s/z2)*(wn1^2*wn2^2));
den = ((s^2+2*zeta1*wn1*s+wn1^2)*(s^2+2*zeta2*wn2*s+wn2^2));

[A, B, C, D] = tf2ss(num, den)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #4 NUMERICALLY

clear all;
close all;
clc;
s = tf('s');

wn1     = 3500;
wn2     = 11000;
zeta1   = 0.01;
zeta2   = 0.01;
wnz     = 7000;
zetaz   = 0.1;

num = (s^2+2*zetaz*wnz*s+wnz^2)*((wn1^2*wn2^2)/wnz^2);
den = (s^2+(2*zeta1*wn1*s)+wn1^2)*(s^2+(2*zeta2*wn2*s)+wn2^2);

term1 = (s^2+2*zetaz*wnz*s+wnz^2) / den;
term2 = (wn1^2*wn2^2) / wnz^2;

L = term1 * term2;

sys2 = ss(num/den);

A = sys2.a;
B = sys2.b;
C = sys2.c;
D = sys2.d;

rank(ctrb(A, B))
rank(obsv(A, C))

bode(L)
grid on
axis([10^3, 2*10^4, -60, 40])
axis([10^3, 2*10^4, -270, 90])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #4 TEST

clear all;
close all;
clc;
s = tf('s');

wn1     = 1;
wn2     = 10;
zeta1   = 0.5;
zeta2   = 0.5;
wnz     = 5;
zetaz   = 0.5;

num = (s^2+2*zetaz*wnz*s+wnz^2)*((wn1^2*wn2^2)/wnz^2);
den = (s^2+(2*zeta1*wn1*s)+wn1^2)*(s^2+(2*zeta2*wn2*s)+wn2^2);

sys2 = ss(num/den);

A = sys2.a;
B = sys2.b;
C = sys2.c;
D = sys2.d;

rank(ctrb(A, B))
rank(obsv(A, C))

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
