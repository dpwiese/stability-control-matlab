%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_Continuous.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
% DYNAMIC SOARING: EQUATIONS OF MOTION
% This function contains the equations of motion for the albatross to be used with
% GPOPS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

load('linwind','solution')

% Take the state and input time histories from the solution structure
t       = solution.phase(1).time;
x       = solution.phase(1).state(:,1);
y       = solution.phase(1).state(:,2);
z       = solution.phase(1).state(:,3);
V       = solution.phase(1).state(:,4);
gamma   = solution.phase(1).state(:,5);
psi     = solution.phase(1).state(:,6);
phi     = solution.phase(1).state(:,7);
CL      = solution.phase(1).state(:,8);
CLcmd   = solution.phase(1).control(:,1);
p       = solution.phase(1).control(:,2);

alpha   = CL/2;
theta   = alpha+gamma;
psi     = psi-pi/2;

scale_factor    = 0.15;
step            = 0.005;
aircrafttype    = 'cessna';

npathend    = 400;
N           = 200;

clearvars mov

xtraj       = imresize(x(1:npathend), [N, 1], 'nearest');
ytraj       = imresize(y(1:npathend), [N, 1], 'nearest');
ztraj       = imresize(z(1:npathend), [N, 1], 'nearest');
thetatraj   = imresize(theta(1:npathend), [N, 1], 'nearest');
phitraj         = imresize(phi(1:npathend), [N, 1], 'nearest');
psitraj         = imresize(psi(1:npathend), [N, 1], 'nearest');

for ii = 1:N
    jj = ii*1;
    trajectory2(xtraj, ytraj, ztraj, thetatraj, phitraj, psitraj, 10, 10, aircrafttype);
    hold on

    % Ground track
    plot3(xtraj(1:jj), ytraj(1:jj), 0*ztraj(1:jj), 'color', [1, 0, 0], 'linewidth', 3);

    trajectory2(xtraj(jj), ytraj(jj), ztraj(jj), thetatraj(jj), phitraj(jj), psitraj(jj), scale_factor, step, aircrafttype);
    % Plot O and X at beginning and end
    plot3(xtraj(1), ytraj(1), ztraj(1), 'o', 'markersize', 16, 'linewidth', 4, 'color', [0, 0.7, 0])
    plot3(xtraj(end), ytraj(end), ztraj(end), 'x', 'markersize', 20, 'linewidth', 4, 'color', [1, 0, 0])

    % image(k.*peaks,'parent',hax); %puts image in invisible axes

    % Set axes limits
    xlim([min(xtraj) max(xtraj)]);
    ylim([min(ytraj) max(ytraj)]);
    zlim([0 40]);

    % set(gca,'CameraViewAngle',10)
    set(gca,'CameraPosition',[-141 -500 200]*2);

    set(gca,'OuterPosition',[0.2 0.2 0.8 0.8])
    % set(gcf,'PaperUnits','inches','PaperPosition',[0 0 7.5 4]);

    set(gca,'nextplot','replacechildren');

    % % OVERHEAD VIEW
    % set(gca,'CameraPosition',[25 -40 200]);
    % set(gca,'CameraTarget',[25 -40 0])

    mov(ii) = getframe(gca);

    % writeVideo(vidObj, getframe(gca));

    clf;
end

movie2avi(mov, 'lin_video_a.avi', 'compression','None', 'fps', 20, 'Quality', 100);

% close all
%
%     vidObj  =  VideoWriter('peaks.avi');
%     open(vidObj);
%
%     % Create an animation.
%     trajectory2(xtraj,ytraj,ztraj,thetatraj,phitraj,psitraj,10,10,aircrafttype);
%     axis tight
%     set(gca,'nextplot','replacechildren');
%
%     for ii = 1:N
%        jj = ii*1;
%             trajectory2(xtraj,ytraj,ztraj,thetatraj,phitraj,psitraj,10,10,aircrafttype);
%             hold on
%             trajectory2(xtraj(jj),ytraj(jj),ztraj(jj),thetatraj(jj),phitraj(jj),psitraj(jj),scale_factor,step,aircrafttype);
%             %Plot O and X at beginning and end
%             plot3(xtraj(1),ytraj(1),ztraj(1),'o','markersize',16,'linewidth',4,'color',[0 0.7 0])
%             plot3(xtraj(end),ytraj(end),ztraj(end),'x','markersize',20,'linewidth',4,'color',[1 0 0])
%             %Set axes limits
%             xlim([min(xtraj) max(xtraj)]);
%             ylim([min(ytraj) max(ytraj)]);
%             zlim([0 40]);
%
%             % set(gca,'CameraViewAngle',10)
%             set(gca,'CameraPosition',[-141 -500 200]*2);
%
%             set(gca,'OuterPosition',[0.2 0.2 0.8 0.8])
%             % set(gcf,'PaperUnits','inches','PaperPosition',[0 0 7.5 4]);
%
%             set(gca,'nextplot','replacechildren');
%
%        % Write each frame to the file.
%        currFrame  =  getframe;
%        writeVideo(vidObj,currFrame);
%     end
%
%     % Close the file.
%     close(vidObj);
