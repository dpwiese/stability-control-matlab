%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Assigned: 2012-02-16
% Input: Rotation matrix
% Output: Euler angles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [eulr] = R2eulr(rot_mat)
    % The sequence of Euler angles is yaw, pitch, and roll
    psi     = atan2(rot_mat(2,1),rot_mat(1,1));
    theta   = -asin(rot_mat(3,1));
    phi     = atan2(rot_mat(3,2),rot_mat(3,3));

    % Build and return output
    eulr = [phi, theta, psi];
end
