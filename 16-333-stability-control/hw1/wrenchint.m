%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
% Input: t0 and tf; omega_B, v_B, and p_0 vectors in R3
% Output: path
% Solve: \dot{x}=Ax ==> \dot{p}=Ap
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [v_Bout, Delta_out, R_out] = wrenchint(t0, tf, dt, J_B, M,omega_B0, v_B0, tau_B0, f_B0, RIB0, gbar, DeltaIB0)

    % Convert vectors into column vectors
    [n,m]=size(omega_B0);
    if m>n
        omega_B0=omega_B0';
    else end
    [n,m]=size(v_B0);
    if m>n
        v_B0=v_B0';
    else end
    [n,m]=size(gbar);
    if m>n
        gbar=gbar';
    else end
    [n,m]=size(DeltaIB0);
    if m>n
        DeltaIB0=DeltaIB0';
    else end
    [n,m]=size(tau_B0);
    if m>n
        tau_B0=tau_B0';
    else end
    [n,m]=size(f_B0);
    if m>n
        f_B0=f_B0';
    else end

    % Step size
    n_int=((tf-t0)/dt)+1;

    % Initial velocity (translational and rotational)
    omega_B(:,1)=omega_B0;
    v_B(:,1)=v_B0;

    % Initial position and orientation
    R(:,:,1)=RIB0;
    Delta(:,:,1)=DeltaIB0;
    tau_B=tau_B0;
    f_B=f_B0;

    % Dissipative consant
    k_diss=0.0;

    % 4th Order Runge-Kutta
    for i = 1:n_int-1
        K1 = dt*inv(J_B)*(cross(-omega_B(:,i),J_B*omega_B(:,i))+tau_B);
        K2 = dt*inv(J_B)*(cross(-(omega_B(:,i)+0.5*K1),J_B*(omega_B(:,i)+0.5*K1))+tau_B);
        K3 = dt*inv(J_B)*(cross(-(omega_B(:,i)+0.5*K2),J_B*(omega_B(:,i)+0.5*K2))+tau_B);
        K4 = dt*inv(J_B)*(cross(-(omega_B(:,i)+K3),J_B*(omega_B(:,i)+K3))+tau_B);
        omega_B(:,i+1) = omega_B(:,i)+(1/6)*(K1+2*K2+2*K3+K4);

        K1 = dt*(cross(-omega_B(:,i),(v_B(:,i)))+R(:,:,i)'*gbar+(f_B/m));
        K2 = dt*(cross(-omega_B(:,i),(v_B(:,i)+0.5*K1))+R(:,:,i)'*gbar+(f_B/M));
        K3 = dt*(cross(-omega_B(:,i),(v_B(:,i)+0.5*K2))+R(:,:,i)'*gbar+(f_B/M));
        K4 = dt*(cross(-omega_B(:,i),(v_B(:,i)+K3))+R(:,:,i)'*gbar+(f_B/M));
        v_B(:,i+1) = v_B(:,i)+(1/6)*(K1+2*K2+2*K3+K4);

        K1 = dt*(R(:,:,i))*hat(omega_B(:,i));
        K2 = dt*(R(:,:,i)+0.5*K1)*hat(omega_B(:,i));
        K3 = dt*(R(:,:,i)+0.5*K2)*hat(omega_B(:,i));
        K4 = dt*(R(:,:,i)+K3)*hat(omega_B(:,i));
        R(:,:,i+1) = R(:,:,i)+(1/6)*(K1+2*K2+2*K3+K4);

        K1 = dt*R(:,:,i)*(v_B(:,i));
        K2 = dt*R(:,:,i)*(v_B(:,i)+0.5*K1);
        K3 = dt*R(:,:,i)*(v_B(:,i)+0.5*K1);
        K4 = dt*R(:,:,i)*(v_B(:,i)+K3);
        Delta(:,:,i+1) = Delta(:,:,i)+(1/6)*(K1+2*K2+2*K3+K4);

        tau_B = -k_diss*omega_B(:,i);
    end

    Delta_out = squeeze(Delta(:,:,:));
    R_out = squeeze(R(:,:,:));
    v_Bout = v_B(:,:);

end
