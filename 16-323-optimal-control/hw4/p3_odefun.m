%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #4
%---------------------------------------------------------------------------------------------------
% These are the differential equations for state and costate for problem 3: space launch vehicle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Ydot = p3_odefun(t, Y)

    global a g

    % State input
    x1 = Y(1);
    x2 = Y(2);
    x3 = Y(3);
    x4 = Y(4);

    % Costate input
    p1 = Y(5);
    p2 = Y(6);
    p3 = Y(7);
    p4 = Y(8);

    beta = atan2(-p2,-p1);

    % State equations
    xdot1 = a*cos(beta);
    xdot2 = a*sin(beta)-g;
    xdot3 = x1;
    xdot4 = x2;

    % Costate equations
    pdot1 = -p3;
    pdot2 = -p4;
    pdot3 = 0;
    pdot4 = 0;

    Ydot = [xdot1, xdot2, xdot3, xdot4, pdot1, pdot2, pdot3, pdot4]';

end
