%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.333 Homework Assignment #2
% Problem 2
% Due: Thursday March 22, 2012
% P2_glider.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% USER INPUTS

% Simulation times
t0      = 0;
tf      = 115;
dt      = 0.001;
nt      = (tf-t0)/dt+1;
time    = linspace(t0,tf,nt);
n_int   = ((tf-t0)/dt)+1;

% Input surface dimensions (span and chords)
geo.wing.b = 0.45;  % m (wingspan)
geo.wing.c = 0.075; % m (wing chord)
geo.htai.b = 0.18;  % m (horizontal tail span)
geo.htai.c = 0.04;  % m (horitontal tail chord)
geo.vtai.h = 0.09;  % m (vertical tail height)
geo.vtai.c = 0.04;  % m (vertical tail chord)

% Calculate surface areas and aspect ratios
geo.wing.S  = geo.wing.b*geo.wing.c;        % m^2 (wing planform area)
geo.htai.S  = geo.htai.b*geo.htai.c;        % m^2 (horizontail tail area)
geo.vtai.S  = geo.vtai.h*geo.vtai.c;        % m^2 (vertical tail area)
geo.wing.AR = (geo.wing.b)^2/geo.wing.S;    % dimensionless (Aspect ratio of wing)
geo.htai.AR = (geo.htai.b)^2/geo.htai.S;    % dimensionless (Aspect ratio of horizontal tail)
geo.vtai.AR = (geo.vtai.h)^2/geo.vtai.S;    % dimensionless (Aspect ratio of horizontal tail)

% Input masses, densities, gravity, unit conversions
geo.tipm.m      = 0.010;        % kg (weight at tip)
geo.dens.bal    = 0.38;         % kg/m^2 (density of balsa per unit area)
geo.dens.air    = 1.204;        % kg/m^3 (density of air) 1.1644
gbar            = [0, 0, 9.8];  % kg-m/s^2 gravity in inertial axes: defined z_{I} positive down
deg2rad         = pi/180;
rad2deg         = 180/pi;

% Input distances in xyz coordinates
xyz.wing.xdle   = -0.025;   % m (distance from nose to LE of wing)
xyz.htai.xdle   = -0.23;    % m (distance from nose to LE of horizontal tail)
xyz.vtai.xdle   = -0.23;    % m (distance from nose to LE of vertical tail)
xyz.tipm.xd     = 0;        % m (distance from nose to tip mass)

% Input aerodynamic efficiencies
aer.wing.e = 0.9; %dimensionless (oswald efficiency of wing)
aer.htai.e = 0.9; %dimensionless (oswald efficiency of horizontal tail)
aer.vtai.e = 0.9; %dimensionless (oswald efficiency of vertical tail)

% Calculate mass properties of glider
[geo, xyz, XYZ] = mass_prop(geo, xyz);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Control surface deflections in radians
aer.delt.e = deltae_deg*deg2rad;
aer.delt.a = deltaa_deg*deg2rad;
aer.delt.r = deltar_deg*deg2rad;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INTEGRATE

% Initialize integrator
g = g0;
xihatB = xihatB0;

% Run integrator
for i = 1:n_int-1
    [fB, tauB, vel, aer] = aero_forces(geo, XYZ, xihatB, aer);
    [g, xihatB] = eom_integrator(geo, xihatB, tauB, fB, gbar, g, dt);

    % Save the output in a format for plotting
    Deltao(1,i) = g(1,4);
    Deltao(2,i) = g(2,4);
    Deltao(3,i) = g(3,4);
    R           = g(1:3,1:3);
    eulr(:,i)   = R2eulr(R);
    vely(1,i)   = xihatB(1,4);
    vely(2,i)   = xihatB(2,4);
    vely(3,i)   = xihatB(3,4);
    OMEGA       = hat(xihatB(1:3,1:3));
    omega(1,i)  = OMEGA(1);
    omega(2,i)  = OMEGA(2);
    omega(3,i)  = OMEGA(3);

    % Bank angle hold for descending spiral
    aer.delt.a = (60*deg2rad-eulr(1,i))*0.01;
    % aer.delt.e=aer.delt.e+((0.0032*deg2rad-eulr(2,i))*-0.1);

    % Pitch stabilizer for straight descent
   % aer.delt.e=aer.delt.e+((pitchdes*deg2rad-eulr(2,i))*-0.001)+((0-omega(2,i))*-0.001);

    % Lower pitch controller gains
    % aer.delt.e=aer.delt.e+((pitchdes*deg2rad-eulr(2,i))*-0.001)+((0-omega(2,i))*-0.001);

    i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FORMAT OUTPUTS FOR PLOTTING

phi     = [eulr0(1), eulr(1,:)];
theta   = [eulr0(2), eulr(2,:)];
psi     = [eulr0(3), eulr(3,:)];

omega_out1 = [0 omega(1,:)];
omega_out2 = [0 omega(2,:)];
omega_out3 = [0 omega(3,:)];

vel_out1 = [vB0(1) vely(1,:)];
vel_out2 = [vB0(2) vely(2,:)];
vel_out3 = [vB0(3) vely(3,:)];

Delta_out1 = [Delta0(1) Deltao(1,:)];
Delta_out2 = [Delta0(2) Deltao(2,:)];
Delta_out3 = [Delta0(3) Deltao(3,:)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT

% cd(plot_dir);

figure(1)

subplot(2,2,1)
    plot(time,omega_out1*rad2deg,'-k','linewidth',1)
    hold on
    plot(time,omega_out2*rad2deg,'-b','linewidth',1)
    plot(time,omega_out3*rad2deg,'-r','linewidth',1)
    grid off
    box off
    h = hline(0,'k');
    xlabel('time [s]')
    ylabel('rates [deg/s]')
    title('Angular Rates')
    legend('\omega_{X}','\omega_{Y}','\omega_{Z}')

subplot(2,2,3)
    plot(time,vel_out1,'-k','linewidth',1)
    hold on
    plot(time,vel_out2,'-b','linewidth',1)
    plot(time,vel_out3,'-r','linewidth',1)
    grid off
    box off
    h = hline(0,'k');
    xlabel('time [s]')
    ylabel('velocity [m/s]')
    title('XYZ Velocity Components')
    legend('u','v','w')

subplot(2,2,2)
    plot(time,phi*(180/pi),'-k','linewidth',1)
    hold on
    plot(time,theta*(180/pi),'-b','linewidth',1)
    plot(time,psi*(180/pi),'-r','linewidth',1)
    grid off
    box off
    h = hline(0,'k');
    title('Euler Angles')
    xlabel('time [s]')
    ylabel('angle [deg]')
    legend('Roll','Pitch','Yaw')

subplot(2,2,4)
    plot(time,Delta_out1,'-k','linewidth',1)
    hold on
    plot(time,Delta_out2,'-b','linewidth',1)
    plot(time,Delta_out3,'-r','linewidth',1)
    grid off
    box off
    h = hline(0,'k');
    xlabel('time [s]')
    ylabel('distance [m]')
    title('Position')
    legend('x','y','z')

set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 9, 6])
set(gcf, 'PaperPositionMode', 'auto')
set(gcf, 'PaperUnits', 'inches')
print('-depsc','-r600','trim_v8.eps');

figure(2)
plot3(Delta_out1,Delta_out2,Delta_out3,'-','linewidth',1)
grid off
xlabel('x-axis [m]')
ylabel('y-axis [m]')
zlabel('z-axis [m]')
set(gca,'ZDir','reverse')
set(gca,'YDir','reverse')
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6, 4])
set(gcf, 'PaperPositionMode', 'auto')
set(gcf, 'PaperUnits', 'inches')
title('Glider Trajectory')
print('-depsc','-r600','traj_v8.eps');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

disp('X-distance travelled:')
Delta_out1(end)
disp('Z-distance travelled:')
Delta_out3(end)
glide_ratio=Delta_out1(end)/Delta_out3(end)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
