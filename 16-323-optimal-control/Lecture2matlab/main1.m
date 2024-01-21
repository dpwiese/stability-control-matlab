% main1.m
%
% Does optimization examples for gradient search methods
%
% Based on Jon How 16.323 Lecture 1

global xpath
clear FF

% grid for plots

x1 = (-3:.02:3)';
x2 = x1;
N = length(x1);
FF = zeros(N,N);

% evaluate Rosenbrock function on grid

for ii = 1:N
    for jj = 1:N
        FF(ii,jj) = rosenbrock([x1(ii) ; x2(jj)]);
    end
end

% Quasi-Newton optimization using BFGS

% variable to keep track of optimization path

xpath = [];

% set options for search

opt = optimset('fminunc');          % default for unconstrained search
opt = optimset(opt,...              % incorporate defaults plus ...
    'tolx',1e-99,...                % very small tolerance on change in x
    'tolfun',1e-99,...              % very small tolerance on change function
    'Hessupdate','bfgs',...         % use BFGS for Hessian update
    'gradobj','on',...              % function call return gradient
    'Display','Iter',...            % display progress
    'LargeScale','off',...          % uses methods that don't store large matrices
    'InitialHessType','identity',...% First hessian is identity
    'MaxFunEvals',150,...           % maximum number of function evals
    'OutputFcn',@outftn);           % function called on each iteration

% starting x

x0 = [-1.9 ; 2];

% do the optimization

xout1 = fminunc('rosenbrock',x0,opt) % quasi-newton
xbfgs = xpath;

% Gradient search

xpath = [];
opt = optimset('fminunc');
opt = optimset(opt,...
    'Hessupdate','steepdesc',...    % Gradient search this time
    'gradobj','on',...
    'Display','Iter',...
    'LargeScale','off',...
    'InitialHessType','identity',...
    'MaxFunEvals',2000,...
    'MaxIter',1000,...
    'OutputFcn',@outftn);

xout = fminunc('rosenbrock',x0,opt)
xgs = xpath;

% Hybrid GS and BFGS. Take 5 GS steps, then BFGS

xpath = [];
opt = optimset('fminunc');
opt = optimset(opt,...
    'Hessupdate','steepdesc',...
    'gradobj','on',...
    'Display','Iter',...
    'LargeScale','off',...
    'InitialHessType','identity',...
    'MaxFunEvals',5,...
    'OutputFcn',@outftn);
xout = fminunc('rosenbrock',x0,opt)
opt = optimset('fminunc');
opt = optimset(opt,...
    'Hessupdate','bfgs',...
    'gradobj','on',...
    'Display','Iter',...
    'LargeScale','off',...
    'InitialHessType','identity',...
    'MaxFunEvals',150,...
    'OutputFcn',@outftn);
xout = fminunc('rosenbrock',xout,opt)
xhyb = xpath;

% Plot the BFGS search path

figure(1)
clf
contour(x1,x2,FF',[0:2:10 15:50:1000])
hold on
plot(xbfgs(:,1),xbfgs(:,2),'-k.','markersize',12)
plot(x0(1),x0(2),'ro')
plot(1,1,'ks')%,'Markersize',12)
title('Rosenbrock with BFGS','interpreter','latex','fonts',14)
hold off
xlabel('$x_1$','interpreter','latex','fonts',14)
ylabel('$x_2$','interpreter','latex','fonts',14)
axis equal
print -depsc  rosen1a.eps

figure(2);clf
contour(x1,x2,FF',[0:2:10 15:50:1000])
hold on
plot(xgs(:,1),xgs(:,2),'-k.','Markersize',6)
plot(x0(1),x0(2),'ro','Markersize',12)
plot(1,1,'ks','Markersize',12)
title('Rosenbrock with Gradient Search','interpreter','latex','fonts',14)
hold off
xlabel('$x_1$','interpreter','latex','fonts',14)
ylabel('$x_2$','interpreter','latex','fonts',14)
axis equal
print -depsc  rosen1b.eps

figure(3);clf
contour(x1,x2,FF',[0:2:10 15:50:1000])
hold on
plot(xhyb(:,1),xhyb(:,2),'-k.','Markersize',12)
plot(x0(1),x0(2),'ro','Markersize',12)
plot(1,1,'k.')
title('Rosenbrock with GS(5) and BFGS','interpreter','latex','fonts',14)
hold off
xlabel('$x_1$','interpreter','latex','fonts',14)
ylabel('$x_2$','interpreter','latex','fonts',14)
axis equal
print -depsc rosen1c.eps

!/bin/bash --login -c 'epstopdf rosen1a.eps'
!/bin/bash --login -c 'epstopdf rosen1b.eps'
!/bin/bash --login -c 'epstopdf rosen1c.eps'

figure(4)
clf
errorbfgs = sqrt(sum((xbfgs-ones(size(xbfgs)))'.^2));
semilogy(errorbfgs,'o-')
xlabel('Iteration Number','interpreter','latex','fonts',14)
ylabel('$|x_k-x^*|$','interpreter','latex','fonts',14)
title('Convergence of BFGS Algorithm','interpreter','latex','fonts',14)
print -depsc errorbfgs.eps

figure(5)
clf
errorgs = sqrt(sum((xgs-ones(size(xgs)))'.^2));
semilogy(errorgs,'o-')
xlabel('Iteration Number, $k$','interpreter','latex','fonts',14)
ylabel('$|x_k-x^*|$','interpreter','latex','fonts',14)
title('Convergence of GS Algorithm','interpreter','latex','fonts',14)
print -depsc errorgs.eps

!/bin/bash --login -c 'epstopdf errorgs.eps'
!/bin/bash --login -c 'epstopdf errorbfgs.eps'

