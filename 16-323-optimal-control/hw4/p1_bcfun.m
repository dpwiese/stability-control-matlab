%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #4
%---------------------------------------------------------------------------------------------------
% This is the boundary conditions for BVP4C solver for pendulum problem.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = p1_bcfun(Y0,Yf)

    % Initial Conditions
    x10 = Y0(1);
    x20 = Y0(2);
    p10 = Y0(3);
    p20 = Y0(4);

    % Final Conditions
    x1f = Yf(1);
    x2f = Yf(2);
    p1f = Yf(3);
    p2f = Yf(4);

    % Impose the necessary initial and final conditions
    res = [ x10 - pi, x20 - 0, p1f - 0, p2f - 0 ];

end
