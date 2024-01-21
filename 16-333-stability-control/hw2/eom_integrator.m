%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #2
% Assigned: Due: 2012/3/23
% Integrates rigid body equations of motion. Input twist, configuration,
% wrench, geometric parameters, and more. Outputs new configuration and
% twist.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [g, xihatB] = eom_integrator(geo, xihatB, tauB, fB, gbar, g, dt)

    % Convert input xihat into omega and v
    omegaB  = hat(xihatB(1:3,1:3));
    v_B     = xihatB(1:3,4);
    RIB     = g(1:3,1:3);
    JB      = geo.totl.J;
    M       = geo.totl.m;

    % Convert vectors into column vectors for calculation
    [n,m] = size(omegaB);
    if m>n
        omegaB = omegaB';
    else end

    [n,m] = size(gbar);
    if m>n
        gbar = gbar';
    else end

    [n,m] = size(tauB);
    if m>n
        tauB = tauB';
    else end

    [n,m] = size(fB);
    if m>n
        fB = fB';
    else end

    % Calculate all the next time steps based on the previous
    % Omega
    K1 = dt*inv(JB)*(cross(-omegaB,JB*omegaB)+tauB);
    K2 = dt*inv(JB)*(cross(-(omegaB+0.5*K1),JB*(omegaB+0.5*K1))+tauB);
    K3 = dt*inv(JB)*(cross(-(omegaB+0.5*K2),JB*(omegaB+0.5*K2))+tauB);
    K4 = dt*inv(JB)*(cross(-(omegaB+K3),JB*(omegaB+K3))+tauB);
    omegaB=omegaB+(1/6)*(K1+2*K2+2*K3+K4);

    % Velocity
    K1 = dt*(cross(-omegaB,(v_B))+RIB'*gbar+(fB/M));
    K2 = dt*(cross(-omegaB,(v_B+0.5*K1))+RIB'*gbar+(fB/M));
    K3 = dt*(cross(-omegaB,(v_B+0.5*K2))+RIB'*gbar+(fB/M));
    K4 = dt*(cross(-omegaB,(v_B+K3))+RIB'*gbar+(fB/M));
    v_B = v_B+(1/6)*(K1+2*K2+2*K3+K4);

    % Configuration: g
    K1 = dt*g*xihatB;
    K2 = dt*(g+0.5*K1)*xihatB;
    K3 = dt*(g+0.5*K2)*xihatB;
    K4 = dt*(g+K3)*xihatB;
    g=g+(1/6)*(K1+2*K2+2*K3+K4);

    xihatB=[hat(omegaB) v_B; zeros(1,3) 0];

end
