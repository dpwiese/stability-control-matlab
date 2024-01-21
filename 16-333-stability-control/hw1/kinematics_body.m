%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
% Input: t0 and tf; omega_B, v_B, and p_0 vectors in R3
% Output: path
% Solve: \dot{x}=Ax ==> \dot{p}=Ap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [g_out, RIB_out, Delta_out] = KinematicsBody(t0, tf, omega_B, v_B, dt, RIB, Delta)

    % Convert vectors into column vectors
    [n,m]=size(omega_B);
    if m>n
        omega_B=omega_B';
    else end

    [n,m]=size(v_B);
    if m>n
        v_B=v_B';
    else end

    [n,m]=size(Delta);
    if m>n
        Delta=Delta';
    else end

    % Initial conditions
    n_int = ((tf-t0)/dt)+1;
    g = zeros(4,4);
    g(:,:,1) = [RIB, Delta; zeros(1,3) 0];

    % Calculate xihat
    xihatB = [hat(omega_B) v_B; zeros(1,3) 0];
    A = xihatB;

    % 4th Order Runge-Kutta
    for i = 1:n_int-1
        K1=dt*g(:,:,i)*A;
        K2=dt*(g(:,:,i)+0.5*K1)*A;
        K3=dt*(g(:,:,i)+0.5*K2)*A;
        K4=dt*(g(:,:,i)+K3)*A;
        g(:,:,i+1)=g(:,:,i)+(1/6)*(K1+2*K2+2*K3+K4);
    end

    % Build output
    g_out=g(:,:,:);
    RIB_out=squeeze(g_out(1:3,1:3,:));
    Delta_out=squeeze(g_out(1:3,4,:));

end
