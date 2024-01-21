%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.032 HW #4 Problem 1
% Fall 2013
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

J = [9, 4, 0; 4, 3, 0; 0, 0, 5];

[v, lambda] = eig(J);

% Decreasing eigenvalue
v1 = [2; 1; 0];
v2 = [0; 0; 1];
v3 = [1; -2; 0];

v1 = v1 / norm(v1, 2);
v2 = v2 / norm(v2, 2);
v3 = v3 / norm(v3, 2);

T = [v1, v2, v3];

T' * J * T
