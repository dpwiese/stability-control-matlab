%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_Continuous.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
% DYNAMIC SOARING: EQUATIONS OF MOTION
% This function contains the equations of motion for the albatross to be used with
% GPOPS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function phaseout = dS_Continuous(input)
    %Take out the time, state, control, and parameter from input structure
    t          = input.phase(1).time;
    X          = input.phase(1).state;
    u          = input.phase(1).control;
    param      = input.phase(1).parameter;

    %Take out the auxiliary data include atmospheric and albatross properties
    rho        = input.auxdata.rho;
    S          = input.auxdata.S;
    CD0        = input.auxdata.CD0;
    g          = input.auxdata.g;
    k          = input.auxdata.k;
    m          = input.auxdata.m;
    Emax       = input.auxdata.Emax;

    %Define the individual state variables from the state vector
    x          = X(:,1);
    y          = X(:,2);
    z          = X(:,3);
    V          = X(:,4);
    gamma      = X(:,5);
    psi        = X(:,6);
    phi        = X(:,7);
    CLa        = X(:,8);

    CLcmd      = u(:,1);
    p          = u(:,2);
    beta       = param(:,1);

    %Calculate some stuff
    singamma   = sin(gamma);
    cosgamma   = cos(gamma);
    sinpsi     = sin(psi);
    cospsi     = cos(psi);
    sinphi     = sin(phi);
    cosphi     = cos(phi);
    vcosgamma  = V.*cosgamma;

    % %BOUNDARY LAYER PROFILE (LINEAR)
    % W0            = input.auxdata.W0;
    % Wx            = -(beta.*z+W0);
    % dWxdz         = -beta;
    % dWxdt         = dWxdz.*V.*singamma;

    %BOUNDARY LAYER PROFILE (LOGARITHMIC)
    Wxref      = -11;
    zref       = 10;
    z0         = 0.15; %0.05-0.15 Sukumar, Selig, or 0.03sachs
    Const      = (Wxref/log(zref/z0));
    Wx         = Const*log((z+z0)/z0);
    dWxdz      = Const*(1./(z+z0));
    dWxdt      = dWxdz.*V.*singamma;

    % %BOUNDARY LAYER PROFILE (POWER-LAW)
    % Wxref      = -11;
    % zref       = 10;
    % a          = 3;
    % Wx         = (Wxref/(1-exp(-a)))*(1-exp(-a*(z/zref)));
    % dWxdz      = (a/zref)*(Wxref/(1-exp(-a)))*exp(-a*(z./zref));
    % dWxdt      = dWxdz.*V.*singamma;

    %Dynamic Soaring Thrust
    dWxdtsinpsi   = dWxdt.*sinpsi;

    %Calculate some stuff
    CLsq       = CLa.^2;
    vsq        = V.^2;
    L          = 0.5*rho*S*CLa.*vsq;
    D          = 0.5*(rho*S)*(CD0+k*CLsq).*vsq;

    %Equations of Motion
    xdot       = vcosgamma.*sinpsi+Wx;
    ydot       = vcosgamma.*cospsi;
    zdot       = V.*singamma;
    Vdot       = -(1/m)*D-(g*singamma)-(dWxdtsinpsi.*cosgamma);
    gammadot   = (cosphi./(m*V)).*L-(g*cosgamma./V)+(dWxdtsinpsi.*singamma./V);
    psidot     = (sinphi./(m*V.*cosgamma)).*L-(dWxdt.*cospsi)./(V.*cosgamma);
    phidot     = p;
    CLadot     = -3*CLa+3*CLcmd;

    %Calculate path
    ngconstant    = (0.5*rho*S/m/g);
    ng            = (0.5*rho*S/m/g).*CLcmd.*V.^2;

    phaseout.dynamics  = [xdot, ydot, zdot, Vdot, gammadot, psidot, phidot, CLadot];
    phaseout.path = ng;

end
