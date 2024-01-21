%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
% Input: twist= omega vector in R3, velocity vector in R3, time (scalar)
% Output: 4x4 rigid body transformation matrix g
% Note: Matrix operations are written for omega, v column vecotrs. If they are not, this code will
% transform them to column vecotrs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [g] = twst2g(omega, v, t)
    [n,m] = size(omega);
    if m>n
        omega = omega';
    else end

    [n,m] = size(v);
    if m>n
        v=v';
    else end

    if omega == 0
        g = [eye(3,3), v*t; zeros(1,3), 1];
    else
        R = eqax2R(omega,t);
        g = [R, ((eye(3,3)-R)*(hat(omega)*v))+(dot(omega, v)*omega*t); zeros(1,3), 1];
    end
end
