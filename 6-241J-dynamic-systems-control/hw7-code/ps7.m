%% 6.241 | PS#7
% Due: 4/27/2012

%% Task 7.1

clear classes;
clear all;
clc;

for T=1:1:10
    % T = 5; % L2 gain in range of [0,10]
    % a = 2; % L2 gain of phi(.)
    % [A,B,C,D] = linmod2('ps7p1mod');
    [A,B,C,D]=linmod2('q1_2_dan');
    E=[0 0 0;0 0 0 ;0 0 0];
    L1 = [zeros(1,length(A)) 1 0 0];
    L2 = [1 0 0]*[C D];
    L3 = [zeros(1,length(A)) 0 1 0];
    L4 = [0 1 0]*[C D];
    L5 = [zeros(1,length(A)) 0 0 1];
    L6 = [0 0 1]*[C D];
    % L7 = [A B];
    L7=[eye(3) E];
    % L8 = [eye(2) zeros(2,3)];
    L8 = [A B];
    P = sdpvar(2); % 2x2 symmetric matrix
    d0 = sdpvar(1); % scalar
    d1 = sdpvar(1); % scalar
    d2 = sdpvar(1); % scalar
    r = sdpvar(1); % scalar
    F = [P>=0,d0>0,d1>0,d2>0];
    %F=[P>=0,[-C'*C-P*A-A'*P -P*B-C'*D;-B'*P-D'*C r*eye(3)-D'*D]>=0]; % KYP LMI
    % F = [F,(r*d0*(L1'*L1)-(L2'*L2)+d1*(L3'*L3-L4'*L4)+d2*(L5'*L5-L6'*L6)-L8'*L7-L7'*L8)>=0];

    solvesdp(F,r);
    R=sqrt(double(r));
end

plot(R)

% %% Task 7.2
% clear classes; clear all; clc;
% epsilon = 0.01; % some small number
% s = tf('s');
% a = -5; % a in range of [-10,10], !=0
% P0 = (s-a)/s^2;
% T = c; % some constant where |S|<=100
% W = 1/T; % needs to be second order... but how if it's just constant...
% [A,B,C,D] = linmod2('ps7p2mod');
% K = hinfsyn(ss(A,B,C,D),1,1);
% %bode((1+P0*K)^(-1)) % check that K satisfies sensitivity requirement
%
% %% Task 7.3
% clear classes; clear all; clc;
% h = 1; % h in range of [0.1,10]
% % A = [0 1; 0 0];
% % B1 = [0 0; 1 0];
% % B2 = [0; 0];
% % C1 = [-1 0];
% % D11 = [0 0];
% % D12 = [1];
% % C2 = [1 0];
% % D21 = [0 h];
% % D22 = [0];
% % ctrb(A,B2) % :-(
% s = tf('s');
% F1 = 1/(s+1);
% F2 = s/(s+2);
% [A,B,C,D] = linmod2('ps7p3mod');
% msys = minreal(ss(A,B,C,D));
% K = h2syn(msys,1,1);
% %K = h2syn(ss(A,B,C,D),1,1);
% % plot H2 norm
