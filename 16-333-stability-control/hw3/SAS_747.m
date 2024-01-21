%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #3
% Due: Tuesday April 24, 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

s = tf('s');

% This seems to work only if the 'save and run' button is pressed
this_mfile  = dbstack('-completenames');
this_dir    = fileparts(this_mfile.file);

% Longitudinal dimensional derivatives for Boeing 747-100
% case III: M=0.9, h=40,000ft

% Dimensional derivatives taken from NASA report

Mach    = 0.9;
weight  = 636600;   % lbs
u_eq    = 871;      % ft-s

% Moments of inertia [slug-ft^2]
Jxx = 1.82*10^7;
Jyy = 3.31*10^7;
Jzz = 4.97*10^7;
Jxz = 9.70*10^5;

Swing       = 5500;             % ft^2
lb2slug     = 0.0310809502;     % convert lbs to slugs
mass        = weight * lb2slug;
m           = mass;
gD          = 32.3;
gamma_eq    = 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following were taken from Etkin I think. They were listed as dimensional stability derivates,
% but had not been normalized by mass or moment of inertia.
% Longitudinal Stability "coefficients?"

% X
dXdu    = -3.954*10^2;
dXdw    = 3.144*10^2;
dXdq    = 0;
dXdwdot = 0;
dXdde   = 1.544*10^4;

% Z
dZdu    = -8.383*10^2;
dZdw    = -7.928*10^3;
dZdq    = -1.327*10^5;
dZdwdot = 1.214*10^2;
dZdde   = -3.677*10^5;

% M
dMdu    = -2.062*10^3;
dMdw    = -6.289*10^4;
dMdq    = -1.327*10^7;
dMdwdot = -5.296*10^3;
dMdde   = -4.038*10^7;

%Lateral Stability "coefficients?"
% Y
dYdv    = -1.198*10^3;
dYdp    = 0;
dYdr    = 0;
dYdda   = 0;
dYddr   = 7.990*10^4;

% L
dLdv    = -2.866*10^4;
dLdp    = -8.357*10^6;
dLdr    = 5.233*10^6;
dLdda   = -3.391*10^6;
dLddr   = 2.249*10^6;

% N
dNdv    = 5.688*10^4;
dNdp    = -5.864*10^5;
dNdr    = -7.279*10^6;
dNdda   = 4.841*10^5;
dNddr   = -2.206*10^7;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The following data was taken from NASA report
% Longitudinal Stability Derivatives

% X
Xu      = -0.0200;
Xw      = 0.0159;
Xq      = 0;
Xwdot   = 0;
XdT     = 0.505*10^-4;
Xde     = 0.781;

% Z
Zu      = -0.0424;
Zw      = -0.401;
Zq      = -6.71;
Zwdot   = 0.00614;
ZdT     = -0.220*10^-5;
Zde     = -18.6;

% M
Mu      = -0.623*10^-4;
Mw      = -0.00190;
Mq      = -0.401;
Mwdot   = -0.000160;
MdT     = 0.302*10^-6;
Mde     = -1.22;

% Lateral Stability Derivatives
% Y
Yv      = -0.0605; %matches NASA
Yp      = 0;
Yr      = 0;
Yda     = 0;
Ydr     = 4.0380;

% L
Lv      = -0.0016;
Lp      = -0.4592; % matches NASA
Lr      = 0.2875;
Lda     = -0.1863;
Ldr     = 0.1236;

% N
Nv      = 0.0011;
Np      = -0.0118;
Nr      = -0.1465; % close to NASA
Nda     = 0.0097;
Ndr     = -0.4439;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build A, B, C, D, E matrices

% Longitudinal
Along = [   Xu,     Xw,     Xq,         -gD*cos(gamma_eq);
            Zu,     Zw,     Zq+u_eq,    -gD*sin(gamma_eq);
            Mu,     Mw,     Mq,         0;
            0,      0,      1,          0];

Blong = [   XdT, Xde;
            ZdT, Zde;
            MdT, Mde;
            0, 0];

Elong = [   1,  0,          0,  0;
            0,  1 - Zwdot,  0,  0;
            0,  -Mwdot,     1,  0;
            0,  0,          0,  1];

Clong = eye(4,4);
Dlong = zeros(4,2);
Along = inv(Elong)*Along;
Blong = inv(Elong)*Blong;

% State space model and transfer function matrix
syslong=ss(Along,Blong,Clong,Dlong);
TFlong=tf(syslong);

% Lateral
Alatr = [   Yv,     Yp, Yr-u_eq,    -gD*cos(gamma_eq);
            Lv,     Lp, Lr,         0;
            Nv,     Np, Nr,         0;
            0,      1,  0,          0];

Blatr = [   Yda,    Ydr;
            Lda,    Ldr;
            Nda,    Ndr;
            0,      0];

Elatr = [   1,  0,          0,          0;
            0,  1,          -Jxz/Jxx,   0;
            0,  -Jxz/Jzz,   1,          0;
            0,  0,          0,          1];

Clatr = eye(4,4);
Dlatr = zeros(4,2);
Alatr = inv(Elatr)*Alatr;
Blatr = inv(Elatr)*Blatr;

% State space model and transfer function matrix
syslatr = ss(Alatr,Blatr,Clatr,Dlatr);
TFlatr  = tf(syslatr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Asp = Along([2 3],[2 3]);
Bsp = Blong([2 3],[1 2]);
Csp = eye(2,2);
Dsp = zeros(2,2);

syssp = ss(Asp,Bsp,Csp,Dsp);
TFsp  = tf(syssp);

TFdeq = minreal(-TFsp(2,2)); %transfer function (out,in): (q,de)

cd(plot_dir)

figure(1)
rlocus(TFdeq);
% daspect([1 1 1])
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','rl_1.eps');

figure(2)
rlocus(TFdeq*(1/s));
% daspect([1 1 1])
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','rl_2.eps');

cd(this_dir)

% Looking at structure of root locus plots, pitch rate (q) feedback changes mostly damping ratio,
% while keeping natural frequency more or less constant. because short period natural frequency of
% the 747 is 1.35, and we would like it to be 3.14, gain feedback on (q) will not be enough to get
% the desired pole locations. since pitch angle (theta) gain feedback changes natural frequency
% while leaving damping ratio about constant, we will use theta to get the desired natural
% frequency, and then use pitch rate feedback to get the desired damping ratio.

K_theta = -6.80; % gives omega_n=3.14

Aspaug          = [Asp, zeros(2,1); 0, 1, 0];               % augment SS description with integrator to get theta
Bspaug          = [Bsp; 0, 0];
Athetacl        = Aspaug-Bspaug*[0, 0, 0; 0, 0, K_theta];   % close the model with K_theta feedback gain in place
thetaclsys      = ss(Athetacl,Bspaug,[0, 1, 0],0);          % new partially closed system with K_theta loop only
TFdeqthetacl    = tf(thetaclsys);                           % partially closed system TF from de to q

cd(plot_dir)

figure(3)
rlocus(-TFdeqthetacl(2)) %output: q input: de (second input)
% daspect([1 1 1])
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','rl_3.eps');

cd(this_dir)

K_q = -3.18; % gives zeta=0.707

Ksp = [0, 0, 0; 0, K_q, K_theta];
ACLsp = Aspaug-Bspaug*Ksp;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%close entire loop, and check phugoid pole locations

Klong       = [ 0, 0, 0,    0;
                0, 0, K_q,  K_theta];
ACLlong     = Along-Blong*Klong;
sysCLlong   = ss(ACLlong,Blong,Clong,Dlong);
TFCLlong    = tf(sysCLlong);

% Now the short period eigenvalues are in the right spot. phugoid eigenvalues are: -0.0224 and
% -0.2979 military spec says damping should be more than 0.04, but I didnt see any other spec on
% phugoid... so these eigenvalues are fine??

% PITCH DAMPER DESIGN COMPLETE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LATERAL-DIRECTIONAL SAS DESIGN

% Feedback from yaw rate r to rudder dr to increase dutch roll damping. This will cause the spiral
% mode to become unstable though.

cd(plot_dir)

figure(4)
rlocus(-TFlatr(3,2))
% daspect([1 1 1])
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','rl_4.eps');

cd(this_dir)

K_rr = -1.6;

Klatr = [   0, 0, 0,    0;
            0, 0, K_rr, 0];

Aydlatr=Alatr-Blatr*Klatr;
ssydlatr=ss(Aydlatr,Blatr,Clatr,Dlatr);
TFydlatr=tf(ssydlatr);

% Now design roll damper to slow down unstable spiral mode: feedback from roll rate p to aileron
% deflection d_a

cd(plot_dir)

figure(5)
rlocus(-TFydlatr(2,1))
% daspect([1 1 1])
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','rl_5.eps');

cd(this_dir)

% Gain K_p of 7 gives spiral pole location of 0.0161, doubling time of 43 seconds making the
% handling qualities level 1.

K_pa = -7;

Klatr = [   0, K_pa,    0,      0;
            0, 0,       K_rr,   0];

ACLlatr     = Alatr-Blatr*Klatr;
sysCLlatr   = ss(ACLlatr,Blatr,Clatr,Dlatr);
TFCLlatr    = tf(sysCLlatr);

%STABILITY AUGMENTATION SYSTEM DESIGN COMPLETE

% Checking simulation responses, aircraft is hard to turn. Need washout filter.
% Start with washout filter design on yaw damper.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Need to design washout filters now using rltool

Gwo_r = (9*s)/(1+3*s);

[a, b, c, d] = linmod2('lateral_747');

syswo_r = ss(a, b, c, d);
tfwo_r  = tf(syswo_r);

cd(plot_dir)

figure(6)
initial(syslong,[0 0 0.2 0]',10);
hold on
initial(sysCLlong,[0 0 0.2 0]',10);
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','ic_1.eps');

figure(7)
initial(syslong,[100 0 0 0]',300);
hold on
initial(sysCLlong,[100 0 0 0]',300);
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','ic_2.eps');

figure(8)
initial(syslatr,[10 0 0 0]',20);
hold on
initial(syswo_r,[10 0 0 0 0]',30)
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','ic_3.eps');

figure(9)
impulse(syswo_r,30)
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','imp_1.eps');

cd(this_dir)

close all

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[ah, bh, ch, dh] = linmod2('hinf_747a');
syshinf = ss(ah, bh, ch, dh);

[Kinf, ~, ~, ~] = hinfsyn(syshinf, 2, 2);
[K2, ~, ~, ~]   = h2syn(syshinf, 2, 2);

[ahinf, bhinf, chinf, dhinf] = linmod2('hinf_747b');
syshinf = ss(ahinf, bhinf, chinf, dhinf);

[ah2, bh2, ch2, dh2] = linmod2('hinf_747c');
sysh2 = ss(ah2, bh2, ch2, dh2);

open_system('hinf_747a')
open_system('hinf_747b')

cd(plot_dir)

figure(10)
step(syshinf,10)
grid on
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','hinf_1.eps');

figure(11)
step(sysh2,10)
grid on
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6.5, 5])
set(gcf, 'PaperPositionMode', 'auto')
% print('-depsc','-r600','h2_1.eps');

% saveas(get_param('hinf_747a','Handle'),'block747_v1.eps');
% saveas(get_param('hinf_747b','Handle'),'block747_v2.eps');

cd(this_dir)

close_system('hinf_747a')
close_system('hinf_747b')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
