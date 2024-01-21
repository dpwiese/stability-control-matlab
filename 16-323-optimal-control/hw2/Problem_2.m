%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #2
%---------------------------------------------------------------------------------------------------
% Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n = 2;

Ak = rand(n, n);
Bk = rand(n, 1);
Ck = rand(1, n);
Rk = rand(1, 1);

xf = zeros(n, 1);

% Step 1: Grid state space
% Number of points along x1 and x2 when gridding space
n1 = 21;
n2 = 21;
x1 = linspace(-10, 10, n1);
x2 = linspace(-10, 10, n2);

rk=1;
uk=0;

for ii = 1:length(x1)
    for jj = 1:length(x2)
        xk = [x1(ii); x2(jj)];
        JN(ii,jj) = (rk-Ck*xk)'*(rk-Ck*xk)+uk'*Rk*uk;
    end
end
