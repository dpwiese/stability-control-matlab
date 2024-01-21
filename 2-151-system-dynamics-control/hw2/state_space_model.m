function y = state_space_model(sel)
    % Return a function handle corresponding to either the nonlinear or linearized dynamics, as
    % given by sel: ["linear", "nonlinear"]

    function xdot = model(~, x)
        g       = 32.2;         % Acceleration due to gravity [ft/s^2]
        Beta    = 300000;       % Bulk Modulus [lbf/in^2]
        A       = 4*pi;         % Piston Area [in^2]
        m       = 3000/(g*12);  % Mass of the car [lbf-s^2/in]
        h0      = 80;           % Initial height of car [in]
        R       = 10.5;         % Viscous damping in cylinder [lbf-s/in^3]

        % Extract states
        x1 = x(1);
        x2 = x(2);

        % Linear State equations
        if sel == "linear"
            x1dot = x2;
            x2dot = -((A*Beta)/(m*h0)) * x1 - ((A*R)/m) * x2;
        end

        % Non-Linear State equations
        if sel == "nonlinear"
            x1dot = x2;
            x2dot = ((A*Beta)/m) * log((h0-x1)/h0) - ((A*R)/m) * x2;
        end

        % Return the state derivatives to the ODE solver
        xdot = [x1dot; x2dot];
    end

    y = @model;

end
