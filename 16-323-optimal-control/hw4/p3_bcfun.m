%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #4
%---------------------------------------------------------------------------------------------------
% This is the boundary conditions for BVP4C solver for problem 3: space launch vehicle.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function res = p3_bcfun(Y0, Yf)

    global h

    % Initial Conditions
    x10 = Y0(1);
    x20 = Y0(2);
    x30 = Y0(3);
    x40 = Y0(4);
    p10 = Y0(5);
    p20 = Y0(6);
    p30 = Y0(7);
    p40 = Y0(8);

    % Final Conditions
    x1f = Yf(1);
    x2f = Yf(2);
    x3f = Yf(3);
    x4f = Yf(4);
    p1f = Yf(5);
    p2f = Yf(6);
    p3f = Yf(7);
    p4f = Yf(8);

    % Impose the necessary initial and final conditions
    res = [
        x10 - 0,
        x20 - 0,
        x30 - 0,
        x40 - 0,
        x2f - 0,
        x4f - h,
        p1f + 1,
        p3f - 0
    ];

end
