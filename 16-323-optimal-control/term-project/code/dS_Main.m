%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_Main.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
%DYNAMIC SOARING PROBLEM: MAIN FILE
% (1) Replace gpopsdir with the apporpriate directory on the local machine
% (2) Replace plotdir with the appropriate directory where the figures are to be
%     saved. Can simply set plotdir to homedir.
% (3) Go into dS_continuous.m to comment/uncomment different wind profiles
% (4) Run dS_Main.m. Results will be plotted.
%-----------------------------------------------------------------------------------
%  -  Can generate a movie using dS_MakeMovie.m
%  -  Can plot saved data by uncommenting lines at the bottom of this script
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;
restoredefaultpath;

thismfile = dbstack('-completenames');
homedir = fileparts(thismfile.file);
cd(homedir);

addpath(fullfile(fileparts(pwd)));
addpath('../Trajectory_Plotter');
addpath('../Saved_Solutions');
addpath('../Trajectory_Plotter/aircraft_models');
addpath('mpgwrite\src');

gpopsdir = 'gpops2';
plotdir = 'figures';

cd(gpopsdir)
gpopsMatlabPathSetup
cd(homedir)

% Environment Data
rho        = 1.225;
beta       = 0.5;
Wxref      = -11;
zref       = 10;

% Albatross Data
CD0        = 0.033;
Emax       = 20;
g          = 9.8;
m          = 8.5;
S          = 0.65;
k          = 1/(4*Emax^2*CD0);

% Initial Condition
x0         = 0;
y0         = 0;
z0         = 10;
r0         = 0;
v0         = 24;
psi0       = 90*pi/180;
Phi0       = 0;
t0         = 0;

% Terminal Condition
xf         = 0;
yf         = 500;
zf         = 10;
rf         = 0;
vf         = 24;

% Constraints
xmin       = -100;
xmax       = 1000;
ymin       = -1000;
ymax       = 1000;
zmin       = 1.0;
zmax       = 40;
Vmin       = 12;
Vmax       = 47;
gammamin   = -75*pi/180;
gammamax   = 75*pi/180;
psimin     = -4*pi;
psimax     = 4*pi;
phimin     = -70/180*pi;
phimax     = 70/180*pi;
CLmin      = -1.0;
CLmax      = 1.5;
tfmin      = 20;
tfmax      = 30;
pmin       = -360*pi/180;
pmax       = 360*pi/180;
betamin    = beta;
betamax    = beta;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Build auxiliary data structure for GPOPS
auxdata.rho     = rho;
auxdata.CD0     = CD0;
auxdata.g       = g;
auxdata.k       = k;
auxdata.m       = m;
auxdata.S       = S;
auxdata.Emax    = Emax;
auxdata.W0      = 0;
auxdata.lmin    = -2;
auxdata.lmax    = 5;
auxdata.zref    = zref;
auxdata.Wxref   = Wxref;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Phase 1 Information
iphase = 1;
bounds.phase(iphase).initialtime.lower  = t0;
bounds.phase(iphase).initialtime.upper  = t0;
bounds.phase(iphase).finaltime.lower    = tfmin;
bounds.phase(iphase).finaltime.upper    = tfmax;
bounds.phase(iphase).initialstate.lower = [x0, y0, z0, v0, gammamin, -0.5*pi, phimin, CLmin];
bounds.phase(iphase).initialstate.upper = [x0, y0, z0, v0, gammamax, 1.5*pi, phimax, CLmax];
bounds.phase(iphase).state.lower        = [xmin, ymin, zmin, Vmin, gammamin, psimin, phimin, CLmin];
bounds.phase(iphase).state.upper        = [xmax, ymax, zmax, Vmax, gammamax, psimax, phimax, CLmax];
bounds.phase(iphase).finalstate.lower   = [xmin, -yf, zf, Vmin, gammamin, psimin, phimin, CLmin];
bounds.phase(iphase).finalstate.upper   = [xmax, yf, zmax, Vmax, gammamax, psimax, phimax, CLmax];
bounds.phase(iphase).control.lower      = [CLmin, pmin];
bounds.phase(iphase).control.upper      = [CLmax, pmax];
bounds.phase(iphase).path.lower         = auxdata.lmin;
bounds.phase(iphase).path.upper         = auxdata.lmax;

%Preallocate eventgroup to make trajectory periodic
bounds.eventgroup(1).lower              = zeros(1,6);
bounds.eventgroup(1).upper              = zeros(1,6);

bounds.parameter.lower                  = betamin;
bounds.parameter.upper                  = betamax;

tfguess    = 30;
N          = 100;
CL0        = CLmax;
basetime   = linspace(0,tfguess,N).';
xguess     = 0*basetime/tfguess;
yguess     = 0*basetime/tfguess;
zguess     = 0*basetime/tfguess;
vguess     = 0*basetime/tfguess;
gammaguess = 0*basetime/tfguess;
psiguess   = -1-basetime/4;
CLguess    = CL0*ones(N,1)/3;
phiguess   = -ones(N,1);
pguess     = -ones(N,1);
betaguess  = beta;

[xguess, yguess, zguess, vguess, gammaguess, psiguess, phiguess] = dS_LoadGuess(N);

% ASSEMBLE GUESS
guess.phase(iphase).time    = [basetime];
guess.phase(iphase).state   = [xguess, yguess, zguess, vguess, gammaguess, psiguess, phiguess, CLguess];
guess.phase(iphase).control = [CLguess, pguess];
guess.parameter             = [betaguess];

setup.name                             = 'Dynamic-Soaring-Problem';
setup.functions.continuous             = @dS_Continuous;
setup.functions.endpoint               = @dS_Endpoint;
setup.nlp.solver                       = 'ipopt';
% setup.nlp.solver                       = 'snopt';
setup.nlp.options.ipopt.linear_solver  = 'ma57';
% setup.nlp.options.ipopt.linear_solver = 'mumps';
setup.bounds                           = bounds;
setup.guess                            = guess;
setup.auxdata                          = auxdata;
setup.derivatives.supplier             = 'sparseCD';
setup.derivatives.derivativelevel      = 'second';
setup.scales.method                    = 'automatic-bounds';
setup.method                           = 'RPMintegration';
setup.mesh.method                      = 'hp1';
% setup.mesh.method                      = 'hpSliding';
setup.mesh.tolerance                   = 1e-5;
setup.mesh.colpointsmin                = 4;
setup.mesh.colpointsmax                = 10;

output = gpops2(setup);
solution = output.result.solution;
solname = dS_FileNamer;
save(solname,'solution')
windtype = 'log';

%% Plot Results

%UNCOMMENT TO PLOT SAVED SOLUTION DATA

% %Linear wind profile:
% load('linwind.mat','solution')
% windtype='lin';

% %Logarithmic wind profile:
% load('logwind.mat','solution')
% windtype='log';

% %Power law wind profile:
% load('expwind.mat','solution')
% windtype='exp';

dS_Plotter(solution, plotdir, homedir, windtype);
