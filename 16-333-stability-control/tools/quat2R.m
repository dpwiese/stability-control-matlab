%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Assigned: 2012-02-16
% Input: Rotation matrix
% Output: Euler angles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [rot_mat] = quat2R(quat)
    % Parse input: scalar-first quaternion
    q0 = quat(1);
    q1 = quat(2);
    q2 = quat(3);
    q3 = quat(4);

    theta = 2*acos(q0);

    if theta==0
        omega = zeros(1,3);
    else
        omega = quat(2:4)/(sin(theta/2));
    end
    rot_mat = eqax2R(omega,theta);
end
