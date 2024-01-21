%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Assigned: 2012-02-16
% input: rotation matrix rot_mat
% output: angular velocity vector omega, theta, w_hat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [w_hat, omega, theta] = R2eqax(rot_mat)
    theta = acos((trace(rot_mat)-1)/2);
    if theta == 0
        w_hat = zeros(3,3);
        omega = zeros(1,3);
    else
        w_hat = (theta/(2*sin(theta)))*(rot_mat-rot_mat');
        w = hat(w_hat);
        omega = w/theta;
    end
end
