%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152
% Observer for Lorenz System
%---------------------------------------------------------------------------------------------------
% Description
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dout = lorenz_equations(t, in)

    % Preallocate output
    dout = zeros(5,1);

    % Grab the input
    x = in(1);
    y = in(2);
    z = in(3);
    yhat = in(4);
    zhat = in(5);

    % Noise and Bounded Model Errors
    noisesw = 0;
    modersw = 0;
    noise = 10 * (rand(1, 1)-0.5) * noisesw;
    moder = 2 * (rand(1, 1)-0.5) * modersw;

    % Plant Parameters
    sigma0 = 10;
    beta0 = 8/3;
    rho0 = 8;

    % Add model errors
    sigma = sigma0 + moder;
    beta = beta0 + moder;
    rho = rho0 + moder;

    % System equations
    dx = sigma * (y-x);
    dy = rho * x - y - x * z;
    dz = -beta * z + x * y;

    % Estimates
    dyhat = rho0 * (x+noise) - yhat - (x+noise) * zhat;
    dzhat = -beta0 * zhat + (x+noise) * yhat;

    % Output
    dout = [dx; dy; dz; dyhat; dzhat];
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
