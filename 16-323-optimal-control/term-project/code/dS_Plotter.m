%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_Plotter.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
% DYNAMIC SOARING: PLOTTER
% This function takes as its input the solution structure from GPOPS and plots the
% state and control histories.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function dS_Plotter(solution, plotdir, homedir, windtype)

    %Take the state and input time histories from the solution structure
    t = solution.phase(1).time;
    x = solution.phase(1).state(:,1);
    y = solution.phase(1).state(:,2);
    z = solution.phase(1).state(:,3);
    V = solution.phase(1).state(:,4);
    gamma = solution.phase(1).state(:,5);
    psi = solution.phase(1).state(:,6);
    phi = solution.phase(1).state(:,7);
    CL = solution.phase(1).state(:,8);
    CLcmd = solution.phase(1).control(:,1);
    p = solution.phase(1).control(:,2);

    axisfontsize = 16;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    cd(plotdir)

    figure(1);
    pp = plot3(x,y,z,'-o');
    hold on
    pp = plot3(x,y,0*z,'-','color',[1 0 0],'linewidth',4);
    plot3(x(1),y(1),z(1),'o','markersize',16,'linewidth',4,'color',[0 0.7 0])
    plot3(x(end),y(end),z(end),'x','markersize',20,'linewidth',4,'color',[1 0 0])
    xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
    yl = ylabel('y [m]','interpreter','latex','FontSize',axisfontsize);
    zl = zlabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
    grid on;
    set(xl,'FontSize',18);
    set(yl,'FontSize',18);
    set(zl,'FontSize',18);
    set(gca,'FontSize',16);
    set(pp,'LineWidth',1.25);
    set(gca,'FontSize',20);
    set(gca,'FontName','Times');
    %Format the figure
    set(gcf,'Units','pixels');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 7.5 4]);
    set(gcf,'PaperPositionMode','manual')
    set(gcf,'InvertHardCopy','off');
    set(gcf,'color',[1 1 1])
    plotname1 = strcat('plot_xyz_',windtype,'.eps');
    print('-depsc','-r600',plotname1);

    %-----------------------------------------------------------------------------------

    figure(2);
    pp = plot(x,y,'-o');
    hold on
    plot(x(1),y(1),'o','markersize',16,'linewidth',4,'color',[0 0.7 0])
    plot(x(end),y(end),'x','markersize',20,'linewidth',4,'color',[1 0 0])
    xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
    yl = ylabel('y [m]','interpreter','latex','FontSize',axisfontsize);
    set(xl,'FontSize',18);
    set(yl,'FontSize',18);
    set(gca,'FontSize',16);
    set(pp,'LineWidth',1.25);
    daspect([1 1 1]);
    %Format the figure
    set(gcf,'Units','pixels');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 7.5 4]);
    set(gcf,'PaperPositionMode','manual')
    set(gcf,'InvertHardCopy','off');
    set(gcf,'color',[1 1 1])
    grid on;
    plotname2 = strcat('plot_xy_',windtype,'.eps');
    print('-depsc','-r600',plotname2);

    %-----------------------------------------------------------------------------------

    figure(3);
    subplot(3,2,1)
        pp = plot(t,V,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Speed [m/s]','interpreter','latex','FontSize',axisfontsize);
    %     set(gca,'FontSize',16,'YTick',40:40:240);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(3,2,2)
        pp = plot(t,gamma*180/pi,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Flight Path Angle [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(3,2,3)
        pp = plot(t,psi*180/pi,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Azimuth [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(3,2,4)
        pp = plot(t,CL,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('CL (dimensionless)','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(3,2,5)
        pp = plot(t,phi*180/pi,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Roll Angle [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(3,2,6)
        pp = plot(t,z,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    %Format the figure
    set(gcf,'Units','pixels');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 12]);
    set(gcf,'PaperPositionMode','manual')
    set(gcf,'InvertHardCopy','off');
    set(gcf,'color',[1 1 1])
    plotname3 = strcat('plot_versus_t_',windtype,'.eps');
    print('-depsc','-r600',plotname3);

    %-----------------------------------------------------------------------------------

    figure(4);
    subplot(3,2,1)
        pp = plot(x,V,'-o');
        xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Speed [m/s]','interpreter','latex','FontSize',axisfontsize);
    %     set(gca,'FontSize',16,'YTick',40:40:240);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([x(1) x(end)]);
    subplot(3,2,2)
        pp = plot(x,gamma*180/pi,'-o');
        xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Flight Path Angle [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([x(1) x(end)]);
    subplot(3,2,3)
        pp = plot(x,psi*180/pi,'-o');
        xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Azimuth [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([x(1) x(end)]);
    subplot(3,2,4)
        pp = plot(x,CL,'-o');
        xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('CL (dimensionless)','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([x(1) x(end)]);
    subplot(3,2,5)
        pp = plot(x,phi*180/pi,'-o');
        xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Roll Angle [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([x(1) x(end)]);
    subplot(3,2,6)
        pp = plot(x,z,'-o');
        xl = xlabel('x [m]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([x(1) x(end)]);
    %Format the figure
    set(gcf,'Units','pixels');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 10 12]);
    set(gcf,'PaperPositionMode','manual')
    set(gcf,'InvertHardCopy','off');
    set(gcf,'color',[1 1 1])
    plotname4 = strcat('plot_versus_x_',windtype,'.eps');
    print('-depsc','-r600',plotname4);

    %-----------------------------------------------------------------------------------

    figure(5);
    subplot(2,3,1)
        pp = plot(t,V,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Speed [m/s]','interpreter','latex','FontSize',axisfontsize);
    %     set(gca,'FontSize',16,'YTick',40:40:240);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(2,3,2)
        pp = plot(t,gamma*180/pi,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Flight Path Angle [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(2,3,3)
        pp = plot(t,psi*180/pi,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Azimuth [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(2,3,4)
        pp = plot(t,CL,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('CL (dimensionless)','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(2,3,5)
        pp = plot(t,phi*180/pi,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Roll Angle [deg]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    subplot(2,3,6)
        pp = plot(t,z,'-o');
        xl = xlabel('Time [s]','interpreter','latex','FontSize',axisfontsize);
        yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
        set(gca,'FontSize',16);
        set(pp,'LineWidth',1.25);
        grid on;
        xlim([t(1) t(end)]);
    %Format the figure
    set(gcf,'Units','pixels');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 16 10]);
    set(gcf,'PaperPositionMode','manual')
    set(gcf,'InvertHardCopy','off');
    set(gcf,'color',[1 1 1])
    plotname3 = strcat('plot_versus_t_',windtype,'_a.eps');
    print('-depsc','-r600',plotname3);

    %-----------------------------------------------------------------------------------

    cd(homedir)

end
