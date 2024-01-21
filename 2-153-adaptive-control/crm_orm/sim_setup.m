%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.S997
% Lecture 3: Adaptive Tuning and Closed-Loop Reference Models
% Simulation Setup Script
%---------------------------------------------------------------------------------------------------
% This script simulates the response of an adaptive system as the adaptive tuning gain is varied,
% and compares ORM responses to CRM responses.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if sum(strcmp(runname,'orm1'))==1
    gamma=1;
    l = 0;
end

%---------------------------------------------------------------------------------------------------

if sum(strcmp(runname,'orm2'))==1
    gamma=10;
    l = 0;
end

%---------------------------------------------------------------------------------------------------

if sum(strcmp(runname,'orm3'))==1
    gamma = 100;
    l = 0;
end

%---------------------------------------------------------------------------------------------------

if sum(strcmp(runname,'crm1'))==1
    gamma = 100;
    l = -10;
end

%---------------------------------------------------------------------------------------------------

if sum(strcmp(runname,'crm2'))==1
    gamma = 100;
    l = -100;
end

%---------------------------------------------------------------------------------------------------

if sum(strcmp(runname,'crm3'))==1
    gamma=100;
    l=-1000;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sim('crmorm_model')

time.(runname)  = xpout.time;
r.(runname)     = rout.signals.values;
xp.(runname)    = xpout.signals.values;
xmc.(runname)   = xmcout.signals.values;
xmo.(runname)   = xmoout.signals.values;
eo.(runname)    = eoout.signals.values;
ec.(runname)    = ecout.signals.values;
u.(runname)     = uout.signals.values;
theta.(runname) = thetaout.signals.values;
k.(runname)     = kout.signals.values;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
