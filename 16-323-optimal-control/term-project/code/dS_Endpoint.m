%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_Endpoint.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
%DYNAMIC SOARING: BOUNDARY CONDITIONS AND OBJECTIVE FUNCTION
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function output = dS_Endpoint(input)

    t0    = input.phase(1).initialtime;
    tf    = input.phase(1).finaltime;
    X0    = input.phase(1).initialstate;
    Xf    = input.phase(1).finalstate;
    beta  = input.parameter;

    %Take apart initial state
    x0      = X0(1);
    y0      = X0(2);
    h0      = X0(3);
    V0      = X0(4);
    gamma0  = X0(5);
    psi0    = X0(6);
    phi0    = X0(7);
    CL0     = X0(8);

    %Take apart final state
    xf      = Xf(1);
    yf      = Xf(2);
    hf      = Xf(3);
    Vf      = Xf(4);
    gammaf  = Xf(5);
    psif    = Xf(6);
    phif    = Xf(7);
    CLf     = Xf(8);

    %Enforce periodicity of albatross flight
    output.eventgroup(1).event = [phi0-phif hf-h0 Vf-V0 psi0-psif gamma0-gammaf CL0-CLf];

    %Maximize distance traveled upwind
    output.objective=-xf;

end
