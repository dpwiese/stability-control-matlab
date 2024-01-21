%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Assigned: 2012-02-16
% Input: angular velocity vector omega, theta
% Output: rotation matrix rot_mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [rot_mat] = eqax2R(omega, theta)
    if norm(omega)==0
        rot_mat = eye(3,3)
    else
        first_term = sin(norm(omega,2)*theta)*(hat(omega)/norm(omega));
        second_term = (1-cos(norm(omega,2)*theta))*(hat(omega)^2/norm(omega,2)^2);
        rot_mat = eye(3,3) + first_term + second_term;
    end
end
