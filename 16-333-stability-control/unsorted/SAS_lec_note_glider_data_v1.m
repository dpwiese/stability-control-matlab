%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.333 Homework Assignment #3
% Due: Tuesday April 24, 2012

clear all; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
addpath('Code Tools');
plot_dir=sprintf('%s','latex');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%USER INPUTS
%simulation times
t0=0;
tfin=11.5;
dt=0.001;
nt=(tfin-t0)/dt+1;
time=linspace(t0,tfin,nt);
n_int=((tfin-t0)/dt)+1;

s=tf('s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SET UP 'A' AND 'B' MATRICES FOR LONGITUDINAL
%'A' and 'B' matrices from lecture 12 - Longitudinal (5 m/s trim condition)
%as given in notes (state vector x=[q u w theta] u=[delta_e]
A1=[-15.58, 4.71, -38.72, 0;
    -0.526, -0.0166, 2.35, -9.78;
    4.40, -1.53, -18.16, -0.704;
    0.997, 0, 0, 0];
B1=[-421.2; 1.323; -17.38; 0];

%rearranged so state x=[u w q theta] u=[delta_e]
Along=[ -0.0166, 2.35, -0.526, -9.78;
    -1.53, -18.16, 4.40, -0.704;
    4.71, -38.72, -15.58, 0;
    0, 0, 0.997, 0];
Blong=[1.323; -17.38; -421.2; 0];
Clong=eye(4,4);
Dlong=zeros(4,1);

Ashrt=Along(2:3,2:3);
Bshrt=Blong(2:3,1);
Cshrt=Clong(2:3,2:3);
Dshrt=Dlong(2:3,1);

Aphug=Along([1 4],[1 4]);
Bphug=Blong([1 4],1);
Cphug=Clong([1 4],[1 4]);
Dphug=Dlong([1 4],1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%SET UP 'A' AND 'B' MATRICES FOR LATERAL
%'A' and 'B' matrices from lecture 13 - Lateral (5 m/s trim condition)
A2=[-22.33, 3.16, -4.42, 0;
    -1.61, -2.66, 14.30, 0;
    0.561, -4.73, -3.15, 9.78;
    0.997, 0.0718, 0, 0];

B2=[967.8, 25.16;
    33.40, -61.8;
    0, 5.58;
    0, 0];

 %rearranged so state x=[v p r phi] u=[delta_a, delta_r]
 Alatr=[-3.15, 0.561, -4.73, 9.78;
     -4.42, -22.33, 3.16, 0;
     14.30, -1.61, -2.66, 0;
     0, 0.997, 0.0718, 0];
 Blatr=[0, 5.58;
     967.8, 25.2;
     33.40, -61.8;
     0, 0];
 Clatr=eye(4,4);
 Dlatr=zeros(4,2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRANSFER FUNCTIONS FOR LONGITUDINAL
% ss_long=ss(Along,Blong,Clong,Dlong);
Gp_long=minreal(Clong*(s*eye(4,4)-Along)^-1*Blong+Dlong);
Gp_shrt=minreal(Cshrt*(s*eye(2,2)-Ashrt)^-1*Bshrt+Dshrt);
Gp_phug=minreal(Cphug*(s*eye(2,2)-Aphug)^-1*Bphug+Dphug);
%Short Period TFs: x=[w q]
Gp_spw=-Gp_shrt(1); %from delta_e to w
Gp_spq=-Gp_shrt(2); %from delta_e to q
%Phugoid TFs: x=[u theta]
Gp_phu=-Gp_phug(1); %from delta_e to u
Gp_phth=-Gp_phug(2); %from delta_e to theta

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%TRANSFER FUNCTIONS FOR LATERAL
Gp_latr=minreal(Clatr*(s*eye(4,4)-Alatr)^-1*Blatr+Dlatr);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% figure(1)
% rlocus(Gp_phu)

% figure(2)
% rlocus(Gp_long(1))

figure(3)
rlocus(-Gp_latr(3,2))

%open loop elevator step response
figure(2)
step(Gp_long,1200)
