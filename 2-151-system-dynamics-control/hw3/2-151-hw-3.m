%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.151 - HW #3
% Last updated October 2nd, 2011
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #1

clear all;
clc;
close all;

A = [0, 1; -4, -1];
C = eye(2,2);

x01 = [1; 0];
x02 = [0; 1];

sys = ss(A, [], C, []);

[x1, t] = initial(sys, x01, 12);
[x2, t] = initial(sys, x02, 12);

figure(1)
subplot(2, 2, 1)
plot(t, x1(:,1))
title('State Variables versus Time: Initial Condition 1')
grid on
hold on
plot(t, x1(:,2), '--k')
legend('x_1', 'x_2')
xlabel('time')
ylabel('x')

subplot(2, 2, 3)
plot(t, x2(:,1))
title('State Variables versus Time: Initial Condition 2')
grid on
hold on
plot(t, x2(:,2), '--k')
legend('x_1', 'x_2')
xlabel('time')
ylabel('x')

subplot(1,2,2)
plot(x1(:,1), x1(:,2), '--k', 'linewidth',1)
hold on
plot(x2(:,1), x2(:,2), '-b', 'linewidth',1)
grid on
title('State Space Trajectories from Two Different Initial Conditions')
legend('IC - 1', 'IC - 2')
xlabel('x_1')
ylabel('x_2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% PROBLEM #2

clear all;
clc;
close all;

A = [   0,      0,      1,      0;
        0,      0,      0,      1;
       -2,      1,   -0.2,      1;
        1,     -1,    0.1,   -0.1];
C = [   1,      0,      0,      0;
        0,      1,      0,      0];

x01 = [1; 1; 0; 0];
x02 = [1; -1; 0; 0];

eig(A)

sys = ss(A, [], C, []);

[x1, t] = initial(sys, x01, 30);
[x2, t] = initial(sys, x02, 30);

figure(1)
subplot(2, 2, 1)
plot(t, x1(:,1))
title('State Variables versus Time: Initial Condition 1')
grid on
hold on
plot(t, x1(:,2), '--k')
legend('y_1', 'y_2')
xlabel('time')
ylabel('y')

subplot(2, 2, 3)
plot(t, x2(:,1))
title('State Variables versus Time: Initial Condition 2')
grid on
hold on
plot(t, x2(:,2),'--k')
legend('y_1', 'y_2')
xlabel('time')
ylabel('y')

subplot(1, 2, 2)
plot(x1(:,1), x1(:,2), '--k', 'linewidth', 1)
hold on
plot(x2(:,1), x2(:,2), '-b', 'linewidth', 1)
grid on
title('State Space Trajectories from Two Different Initial Conditions')
legend('IC - 1', 'IC - 2')
xlabel('y_1')
ylabel('y_2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #3

clear all;
clc;
close all;

V = [1, -2; -1, -1];
LAMBDA = [-2, 0; 0, -0.5];

a = V * LAMBDA * inv(V)

x01 = [1; -1];
x02 = [1; 1];
x03 = [1; 4];
x04 = [-2; -1];
x05 = [1; 3];

A = [-1, 1; 0.5, -1.5];
C = eye(2, 2);

sys=ss(A,[],C,[]);

[x1, t1] = initial(sys, x01, 4);
[x2, t2] = initial(sys, x02, 4);
[x3, t3] = initial(sys, x03, 4);
[x4, t4] = initial(sys, x04, 4);
[x5, t5] = initial(sys, x05, 4);

figure(1)
subplot(2, 2, 1)
plot(t1, x1(:,1))
title('State Variables versus Time: Test 1')
hold on
plot(t1, x1(:,2), '--k')
grid on
legend('x1', 'x2')

subplot(2, 2, 2)
plot(t2, x2(:,1))
title('State Variables versus Time: Test 2')
hold on
plot(t2, x2(:,2))
grid on
legend('x1', 'x2')

subplot(2, 2, 3)
plot(t3, x3(:,1))
title('State Variables versus Time: Test 3')
hold on
plot(t3, x3(:,2), '--k')
grid on
legend('x1', 'x2')

subplot(2, 2, 4)
plot(t4, x4(:,1))
title('State Variables versus Time: Test 4')
hold on
plot(t4, x4(:,2), '--k')
grid on
legend('x1', 'x2')

figure(2)
plot(t5, x5(:,1))
title('State Variables versus Time: Question 3')
hold on
plot(t5, x5(:,2), '--k')
grid on
legend('x1', 'x2')

figure(3)
plot(x5(:,1), x5(:,2))
daspect([1, 1, 1])
axis([-3, 3, -3, 3])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problem #4

clear all;
clc;
close all;

A = [0, -1, 1; 1, 0, 0; -1, 0, 0];
M = [0, 0, sqrt(2); 1, -1, 0; 1, 1, 0];
LAMBDA = inv(M) * A * M;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
