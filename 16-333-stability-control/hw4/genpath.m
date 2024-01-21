%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% genpath.m
% generate path for airplane to follow

tfin = 13.4;

% Centers of the circles
xc = 5;
yc = 5;

% Circumference
circ=15*pi/2;

% Number of points along the straight section and circle
ncirc = 236;
nstrt = 100; % roughly divided ncirc by 2.356

x1stop = 5-5/(nstrt/2);
y1strt = 5-5/(nstrt/2);

t1 = linspace(-pi/2,pi,ncirc);
t2 = -linspace(0,3*pi/2,ncirc);
r = 5;

x1 = linspace(0,x1stop,nstrt/2);
y1 = linspace(0,0,nstrt/2);

x2 = xc+r*cos(t1);
y2 = yc+r*sin(t1);

x3 = linspace(0,0,nstrt-1);
y3 = linspace(y1strt,-y1strt,nstrt-1);

x4 = -xc+r*cos(t2);
y4 = -yc+r*sin(t2);

x5 = linspace(-x1stop,0,nstrt/2);
y5 = linspace(0,0,nstrt/2);

X = [x1, x2, x3, x4, x5];
Y = [y1, y2, y3, y4, y5];
Z = zeros(1,length(X));

T = linspace(0,tfin,length(X));
dt = T(2)-T(1);

% North, East, Down
PD = [X', Y', Z', T'];

PD_dot      = zeros(671,4);
PD_ddot     = zeros(671,4);
PD_dddot    = zeros(671,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:length(T)-1
    PD_dot(i,1) = (PD(i+1,1)-PD(i,1))/(PD(i+1,4)-PD(i,4));
    PD_dot(i,2) = (PD(i+1,2)-PD(i,2))/(PD(i+1,4)-PD(i,4));
    PD_dot(i,3) = (PD(i+1,3)-PD(i,3))/(PD(i+1,4)-PD(i,4));
end

PD_dot(length(T),1) = PD_dot(length(T)-1,1);
PD_dot(length(T),2) = PD_dot(length(T)-1,2);
PD_dot(length(T),3) = PD_dot(length(T)-1,3);

PD_dot(:,1) = smooth(PD_dot(:,1));
PD_dot(:,2) = smooth(PD_dot(:,2));
PD_dot(:,3) = smooth(PD_dot(:,3));
PD_dot(:,4) = PD(:,4);

for i=1:length(T)-1
    PD_ddot(i,1) = (PD_dot(i+1,1)-PD_dot(i,1))/(PD(i+1,4)-PD(i,4));
    PD_ddot(i,2) = (PD_dot(i+1,2)-PD_dot(i,2))/(PD(i+1,4)-PD(i,4));
    PD_ddot(i,3) = (PD_dot(i+1,3)-PD_dot(i,3))/(PD(i+1,4)-PD(i,4));
end

PD_ddot(length(T),1) = (PD_dot(2,1)-PD_dot(length(T),1))/(PD(2,4)-PD(length(T),4));
PD_ddot(length(T),2) = (PD_dot(2,2)-PD_dot(length(T),2))/(PD(2,4)-PD(length(T),4));
PD_ddot(length(T),3) = (PD_dot(2,3)-PD_dot(length(T),3))/(PD(2,4)-PD(length(T),4));

PD_ddot(:,1) = smooth(PD_ddot(:,1));
PD_ddot(:,2) = smooth(PD_ddot(:,2));
PD_ddot(:,3) = smooth(PD_ddot(:,3));
PD_ddot(:,4) = PD(:,4);

for i=1:length(T)-1
    PD_dddot(i,1) = (PD_ddot(i+1,1)-PD_ddot(i,1))/(PD(i+1,4)-PD(i,4));
    PD_dddot(i,2) = (PD_ddot(i+1,2)-PD_ddot(i,2))/(PD(i+1,4)-PD(i,4));
    PD_dddot(i,3) = (PD_ddot(i+1,3)-PD_ddot(i,3))/(PD(i+1,4)-PD(i,4));
end

PD_dddot(length(T),1) = (PD_ddot(2,1)-PD_ddot(length(T),1))/(PD(2,4)-PD(length(T),4));
PD_dddot(length(T),2) = (PD_ddot(2,2)-PD_ddot(length(T),2))/(PD(2,4)-PD(length(T),4));
PD_dddot(length(T),3) = (PD_ddot(2,3)-PD_ddot(length(T),3))/(PD(2,4)-PD(length(T),4));

PD_dddot(:,1) = smooth(PD_dddot(:,1));
PD_dddot(:,2) = smooth(PD_dddot(:,2));
PD_dddot(:,3) = smooth(PD_dddot(:,3));
PD_dddot(:,4) = PD(:,4);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
