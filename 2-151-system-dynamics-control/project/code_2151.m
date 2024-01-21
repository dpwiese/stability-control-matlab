%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.31 Project
% Prof. How
% TA Brandon Luders
% 11/12/01
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%This code contains the 6 state linearized state-space model of the Quanser
%helicopter,and the 2 state linearized motor dynamics. These are combined
%into an 8th order state-space model for which a DOFB feed-forward
%controller is designed.
%This state-space model takes as its inputthe vector signal:
%               [theta_C, psi_C, phi, theta, psi]^(T)
%And generates output voltages:
%                     [V_coll, V_cyc]^(T)
%TODO@dpwiese:
% * Consider incorporation of degree/radian conversions so that the model can
%   be directly inputted into LabView without further conversions. This may
%   already be done in LabView, and may not be necessary.
% * Consider implementation of DOFB-servo

clc; clear all; close all; s=tf('s');
cd('Presentation')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUTS

% Simulation Model to use
model = sprintf('%s','model_2151_3DOF');

% Simulation Parameters
t_sim       = 30;
t_theta     = 2;
t_psi       = 10;
r_theta     = 40*pi/180;
r_psi       = 170*pi/180;
noise_var   = 0;
t_noise     = 0.1;

% Controller and estimator weights
QK_int = diag([0.01 20 5 0.05 300 0.01 1e-11 1e-11 0.7 50],0);
RK_int = diag([1e-9 1e-9],0);
QL = diag([1 1 1 1 1 1 1 1],0);
RL = diag([0.01 0.01 0.01],0);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%System Parameters (Given)
m = 600; % kg
M = 1200; % kg
m_cw = M-m; % kg
l_boom = 9; % m
l_phi = 0.2; % m %Pick this based on hinge location
l_theta = 4; % m %pick this
l_h = 1.2; % m
l_cw=(m*l_boom-l_theta*M)/m_cw;
Ixx = (m*(2*l_h)^2)/12; % Nm -rotor assembly uniform bar
Iyy = (m*l_boom^2)+(m_cw*l_cw^2); % Nm
Izz = (m*l_boom^2)+(m_cw*l_cw^2); % Nm
K_T = 0.9; % N/s
g = 9.81; % m/s^2
Lp = 0.02; % value in range
Mq = 0.02; % value in range
V_sat=4160;

%MUX Dynamics
A = [0 1 0 0 0 0;
    -m*g*l_phi/Ixx -Lp/Ixx 0 0 0 0;
    0 0 0 1 0 0;
    0 0 0 -Mq/Iyy 0 0;
    0 0 0 0 0 1;
    M*g*l_theta/Izz 0 0 0 0 0];
B = [0 0;
    0 K_T*l_h/Ixx;
    0 0;
    K_T*l_boom/Iyy 0;
    0 0;
    0 0];
C = [1 0 0 0 0 0;
    0 0 1 0 0 0;
    0 0 0 0 1 0];
D = 0;

maxmotorrpm = 2400; % rpm
maxmotorrpm = maxmotorrpm*((2*pi)/60);
maxmotorvoltage = V_sat; % Volts
DCgain = maxmotorrpm/maxmotorvoltage;
tau = 0.1; % sec

% Motor Dynamics
Am = [-1/tau 0; 0 -1/tau];
Bm = [DCgain/tau 0; 0 DCgain/tau];
Cm = [1 0; 0 1];
Dm = 0;

% Augmented Plant Dynamics: Quanser + Motor dynamics
Aq = [A B*Cm; zeros(2,6) Am];
Bq = [zeros(6,2); Bm];
Cq = [C zeros(3,2)];
Dq = zeros(3,2);

A_int=[Aq, zeros(8,2); [0 0 -1 0 0 0 0 0 0 0; 0 0 0 0 -1 0 0 0 0 0]];
B_int=[Bq;zeros(2,2)];
B_int_2=[zeros(8,2);eye(2,2)];
C_int=[Cq, zeros(3,2)];

% Controller and estimator gains
K_lqr_int=lqr(A_int, B_int, QK_int, RK_int);
L_lqe=lqr(Aq',Cq',QL,RL)';

% K_lqr_int(:,1:2)=zeros(2,2); %no feedback on roll
K_lqr_int(:,7:8)=zeros(2,2); %no feedback on motor speed

% Full compensator: r is top input, y is bottom input, u is output Lec. 17-7
A_COMP = [Aq-Bq*K_lqr_int(:,1:8)-L_lqe*Cq, -Bq*K_lqr_int(:,9:10);
        zeros(2,10)];
B_COMP = [zeros(8,2), L_lqe; [1 0; 0 1], [0 -1 0; 0 0 -1]];
C_COMP = -K_lqr_int;
D_COMP = [zeros(2,5)];

% Simulate Model, condition and plot results
[tsim,simout]=sim(model);

out_time = output.time;
theta_ref_deg = output.signals.values(:,1)*180/pi;
psi_ref_deg = output.signals.values(:,2)*180/pi;
phi_out_deg = output.signals.values(:,3)*180/pi;
theta_out_deg = output.signals.values(:,4)*180/pi;
psi_out_deg = output.signals.values(:,5)*180/pi;

cont_time = conteff.time;
V_coll = conteff.signals.values(:,1);
V_cyc = conteff.signals.values(:,2);

figure(1)
subplot(2,2,1)
    plot(out_time,phi_out_deg)
    title('Roll Angle: \phi')
    grid on
    xlabel('time [s]')
    ylabel('angle [\circ]')
subplot(2,2,2)
    plot(out_time,theta_ref_deg,'-b')
    hold on
    plot(out_time,theta_out_deg,'-r')
    title('Pitch Angle: \theta')
    grid on
    xlabel('time [s]')
    ylabel('angle [\circ]')
    legend('Reference','Simulation');
subplot(2,2,3:4)
    plot(out_time,psi_ref_deg,'-b')
    hold on
    plot(out_time,psi_out_deg,'-r')
    title('Travel: \psi')
    grid on
    xlabel('time [s]')
    ylabel('angle [\circ]')
    legend('Reference','Simulation');
print('-depsc','-r600','response1.eps')

figure(2)
subplot(1,2,1)
plot(cont_time,V_coll)
title('Pitch Voltage: V_{coll}')
grid on
xlabel('time [s]')
ylabel('angle [\circ]')
subplot(1,2,2)
plot(cont_time,V_cyc)
title('Roll Voltage: V_{cyc}')
grid on
xlabel('time [s]')
ylabel('angle [\circ]')
print('-depsc','-r600','conteff1.eps')

% figure(3)
% pzmap(Aq,Bq,Cq,Dq)
