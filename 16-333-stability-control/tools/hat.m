%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #1
% Assigned: 2012-02-16
% Takes as input either a vector in R3, or 3x3 "hat" matrix.
% Output: "hat" matrix corresponding or vector in R3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [hat_out] = hat(hat_in)
    % Get dimensions of input
    [m,n] = size(hat_in);

    % Check input is square
    if m==n
        % Check input is skew symmetric
        for i=1:n
            if hat_in(i,i)==0
            else
                error('not skew-symmetric')
            end
            i=i+1;
        end
        % With skew-symmetric matrix, build output vector
        % hat_out=[0.5*(hat_in(3,2)-hat_in(2,3)), 0.5*(-hat_in(3,1)+hat_in(1,3)), 0.5*(hat_in(2,1)-hat_in(1,2))];
        hat_out=[hat_in(n,n-1), -hat_in(n,n-2), hat_in(n-1,n-2)];
    else
        hat_out=[0 -hat_in(3) hat_in(2); hat_in(3) 0 -hat_in(1); -hat_in(2) hat_in(1) 0];
    end
end
