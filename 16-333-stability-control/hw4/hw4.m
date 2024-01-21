%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #2
% Due: Thursday March 22, 2012

clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

this_mfile = dbstack('-completenames');
this_dir = fileparts(this_mfile.file);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initial conditions
x0 = [1, 1, 0, 5, 0, 0, 0, 0, 1]';
u0 = [-9.81, 0, 0];

% Wind
vwind = 0.0;

% Generate desired path and its derivatives
genpath;

% Generate feedback gain K
A   = [ zeros(3,3), eye(3,3), zeros(3,3);
        zeros(3,6), eye(3,3);
        zeros(3,9)];

B   = [ zeros(3,3);
        zeros(3,3);
        eye(3,3)];

Qwt = diag([10, 10, 10, 1, 1, 1, 1, 1, 1]);
Rwt = diag([0.001, 0.001, 0.001]);
K   = lqr(A, B, Qwt, Rwt);

%Integrate
for i = 1:length(T)-1;
    % At time step i, do:
    % Call the current value of the desired trajectory PD and its derivatives
    Pd          = PD(i+1,1:3)';
    Pd_dot      = PD_dot(i+1,1:3)';
    Pd_ddot     = PD_ddot(i+1,1:3)';
    Pd_dddot    = PD_dddot(i+1,1:3)';

    % Evaluate the aircrafts current acceleration \ddot{p} using the aircraft dynamics
    [dx] = CASairplane(x0,u0);
    p_ddot = dx(4:6);

    % Calculate control input based on p and PD, and generate control input
    u = autopilot(x0, u0, Pd, Pd_dot, Pd_ddot, Pd_dddot, p_ddot, K, T, i);

    % Integrate airplane dynamics based on current control input
    [t, x] = ode45(@(t,x)CASairplane(x, u), [T(i), T(i+1)], x0);
    x0 = x(end,:)';
    u0 = u;

    % Movement due to wind
    x0(1) = x0(1)-vwind*dt;

    % Store coordinates for plotting
    time(i)     = t(end);
    north(i)    = x(end,1);
    east(i)     = x(end,2);
    down(i)     = x(end,3);
end

% Plot
cd(plot_dir)

figure(1)
plot3(PD(:,1),PD(:,2),PD(:,3),'--k','linewidth',1)
set(gca,'YDir','reverse');
set(gca,'ZDir','reverse');
xlabel('North')
ylabel('East')
daspect([1 1 1])
grid on
hold on
plot3(north,east,down,'-b','linewidth',2)
% set(gcf, 'PaperUnits', 'inches')
% set(gcf, 'OuterPosition', [1, 1, 6, 4])
% set(gcf, 'PaperPositionMode', 'auto')
print('-depsc','-r600','temp.eps');

cd(this_dir)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
