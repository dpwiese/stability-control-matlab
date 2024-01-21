%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #1
%---------------------------------------------------------------------------------------------------
% BFGS solver
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [xpath, NI, NF] = bfgs(fhand, x0)

    % (1) Set initial guess for Hessian and initialize stuff
    [n, temp] = size(x0);
    H0 = eye(n,n);
    Hk = H0;
    xk = x0;
    xpath = [x0'];
    gtol = 10^-20;
    normg = 1;
    NI = 0;
    NF = 0;
    global ni nf
    ni = 0;
    nf = 0;

    while normg>gtol
        [~, gk] = fhand(xk);
        % nf=nf+1;

        % (2) At each k, set search direction
        dk = -inv(Hk)*gk;
        dk = dk/norm(dk,n);

        % (3) Do a line search along search direction
        [alphak, xk1, ~, gk1, nfinc] = linesearch(fhand, xk, dk);
        % nf=nf+1;

        % (4) Set sk change in x and yk change in gradient
        sk = alphak * dk;
        yk = gk1 - gk;

        % (5) Update our guess for the Hessian
        Hk1 = Hk + ((yk*yk')/(yk'*sk)) - ((Hk*sk*sk'*Hk)/(sk'*Hk*sk));

        % Set everything to updated values
        Hk = Hk1;
        xk = xk1;
        gk = gk1;

        % Calculate norm of gradient
        normg = norm(gk, 2);
        disp(normg)

        % Store current iteration of x value
        xpath = [xpath; xk(:)'];

        % Incremement iteration counter ni and output that as fval
        NI = NI + 1;
    end
    NF = nf;
end
