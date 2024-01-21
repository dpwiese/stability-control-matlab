%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Assigned: 2012-02-16
% Input: Euler angles
% Output: Rotation matrix
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [rot_mat] = eulr2R(eulr)
    % Pull roll, pitch, and yaw Euler angles from input
    phi     = eulr(1);
    theta   = eulr(2);
    psi     = eulr(3);

    % First row
    r11 = cos(psi)*cos(theta);
    r12 = cos(psi)*sin(phi)*sin(theta)-cos(phi)*sin(psi);
    r13 = sin(phi)*sin(psi)+cos(phi)*cos(psi)*sin(theta);

    % Second row
    r21 = cos(theta)*sin(psi);
    r22 = cos(phi)*cos(psi)+sin(phi)*sin(psi)*sin(theta);
    r23 = cos(phi)*sin(psi)*sin(theta)-cos(psi)*sin(phi);

    % Third row
    r31 = -sin(theta);
    r32 = cos(theta)*sin(phi);
    r33 = cos(phi)*cos(theta);

    % Build and return rotation matrix
    rot_mat = [ r11, r12, r12;
                r21, r22, r23;
                r31, r32, r33];
end
