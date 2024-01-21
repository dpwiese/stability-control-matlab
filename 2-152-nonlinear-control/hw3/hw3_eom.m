%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 HW #3 Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function xdot = hw3_eom(t, x, u)

    alpha1 = 2 * sin(t) + 7;
    alpha2 = sin(t) + 3;
    m = 1;
    d = 0;

    % Extract states
    x1 = x(1);
    x2 = x(2);

    % Non-Linear State equations
    alpha_term = - (alpha1 + alpha2 * cos(x2)^(2))

    x1dot = x2;
    x2dot = (1/m) * (alpha_term * abs(x2) * x2 + u + d);

    % Return the state derivatives to the ODE solver
    xdot = [x1dot; x2dot];

end
