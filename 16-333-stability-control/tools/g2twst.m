%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Problem 1.4
% Assigned: 2012-02-16
% Input: g
% Output: twist= omega, velocity
% Notes: Lecture 2, pg 10
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [omega, velocity] = g2twst(g)
    R = g(1:3,1:3);
    if R == eye(3,3)
        omega = zeros(3,1);
        velocity = g(1:3,4);
    else
        [~, omega, t] = R2eqax(R);
        [n, m] = size(omega);
        if m > n
            omega=omega';
        else end
        velocity = inv((eye(3,3)-R) * hat(omega) + (omega*omega')*t) * g(1:3,4);
    end
end
