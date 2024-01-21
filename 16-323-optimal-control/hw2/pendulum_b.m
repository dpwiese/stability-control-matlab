%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #2
%---------------------------------------------------------------------------------------------------
% Pendulum dynamics forward code and adjoint method reverse code. This function takes as an input
% the vector u, the control input for the entire time interval.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [cost, ub, x] = pendulum_b(u)

    % Read in initial condition, delta t, and weight rho from workspace
    x0 = evalin('base','x0');
    dt = evalin('base','dt');
    rho = evalin('base','rho');

    % Total length of time vector
    n = length(u);

    % Preallocate the vector x
    x1 = zeros(n, 1);
    x2 = zeros(n, 1);

    % Overwrite the first entry of x1 and x2 vector with initial condition
    x1(1) = x0(1);
    x2(1) = x0(2);
    J = zeros(n, 1);

    % Preallocate ks
    k11 = 0;
    k12 = 0;
    k21 = 0;
    k22 = 0;

    % Preallocate kbs
    k11b = 0;
    k12b = 0;
    k21b = 0;
    k22b = 0;

    % Preallocate more stuff
    Jb = ones(n, 1);
    ub = zeros(n, 1);
    x1b = zeros(n, 1);
    x2b = zeros(n, 1);

    %-----------------------------------------------------------------------------------------------
    % FORWARD CODE

    % This code uses RK4 to integrate forward the state x in time, as well as the cost at each
    % moment in time.
    for ii=1:n-1;
        k11 = dt*x2(ii);
        k12 = dt*(sin(x1(ii))+u(ii));
        k21 = dt*(x2(ii)+0.5*k12);
        k22 = dt*(sin(x1(ii)+0.5* k11)+(u(ii)+u(ii+1))/2);
        x1(ii+1) = x1(ii)+k21;
        x2(ii+1) = x2(ii)+k22;
        J(ii+1) = J(ii)+(x1(ii)^2+x1(ii+1)^2)*dt/2+rho*(u(ii)^2+u(ii+1)^2)*dt/2;
    end
    x = [x1, x2];

    %-----------------------------------------------------------------------------------------------
    % REVERSE CODE

    for ii=n-1:-1:1
        % LINE 7: J(ii+1) = J(ii)+(x1(ii)^2+x1(ii+1)^2)*dt/2+rho*(u(ii)^2+u(ii+1)^2)*dt/2;
        x1b(ii) = x1b(ii)+x1(ii)*dt*Jb(ii+1);
        x1b(ii+1) = x1b(ii+1)+x1(ii+1)*dt*Jb(ii+1);
        ub(ii) = ub(ii)+rho*u(ii)*dt*Jb(ii+1);
        ub(ii+1) = ub(ii+1)+rho*u(ii+1)*dt*Jb(ii+1);
        Jb(ii) = 1;

        % LINE 6: x2(ii+1) = x2(ii) + k22;
        x2b(ii) = x2b(ii)+x2b(ii+1);
        k22b = k22b+x2b(ii+1);

        % LINE 5: x1(ii+1) = x1(ii) + k21;
        x1b(ii) = x1b(ii)+x1b(ii+1);
        k21b = k21b+x1b(ii+1);

        % Clear variables
        x2b(ii+1) = 0;
        x1b(ii+1) = 0;

        % LINE 4: k22 = dt*(sin(x1(ii)+0.5* k11)+(u(ii)+u(ii+1))/2);
        x1b(ii) = x1b(ii)+cos(x1(ii)+0.5*k11)*dt*k22b;
        k11b = k11b + cos(x1(ii)+0.5*k11)*0.5*dt*k22b;
        ub(ii) = ub(ii)+0.5*dt*k22b;
        ub(ii+1) = ub(ii+1)+0.5*dt*k22b;

        % Clear variables
        k22b = 0;

        % LINE 3: k21 = dt*(x2(ii)+0.5*k12);
        x2b(ii) = x2b(ii)+dt*k21b;
        k12b = k12b+0.5*dt*k21b;

        % Clear variables
        k21b = 0;

        % LINE 2: k12 = dt*(sin(x1(ii))+u(ii));
        x1b(ii) = x1b(ii)+cos(x1(ii))*dt*k12b;
        ub(ii) = ub(ii)+dt*k12b;

        % Clear variables
        k12b = 0;

        % LINE 1: k11 = dt*x2(ii);
        x2b(ii) = x2b(ii)+dt*k11b;

        % Clear variables
        k11b = 0;
    end

    cost = J(end);

end
