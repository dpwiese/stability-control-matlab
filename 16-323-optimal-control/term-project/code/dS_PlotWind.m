%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_PlotWind.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
%DYNAMIC SOARING: PLOT WIND VELOCITY PROFILE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Define altitude range over which to plot wind profile
z = 0:1:40;

%Define wind profile
Wxref = -11;
zref = 10;
z0 = 0.15; %0.05-0.15 Sukumar, Selig, or 0.03sachs
a = 3;
beta = Wxref/zref;

Wxlog = Wxref*(log((z+z0)/z0))/(log(zref/z0));
Wxlin = beta*z;
Wxexp = (Wxref/(1-exp(-a)))*(1-exp(-a*(z/zref)));

%-----------------------------------------------------------------------------------
axisfontsize = 16;
plotlinewidth = 3;
plotlinecolor = [0 0 0];

figure(1)
pp = plot(Wxlin,z,'linewidth',plotlinewidth,'color',plotlinecolor);
hold on
for ii = 5:5:z(end);
    arrow([0 z(ii+1)],[Wxlin(ii+1) z(ii+1)])
end
xl = xlabel('Wind Velocity [m/s]','interpreter','latex','FontSize',axisfontsize);
yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
set(gca,'FontSize',16);
grid on;
ylim([0 z(end)]);
% xlim([-15 0]);
set(gcf,'Units','pixels');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 4.5 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
cd(plotdir)
print('-depsc','-r600','plot_wind_lin.eps');
cd(homedir)

figure(2)
pp = plot(Wxlog,z,'linewidth',plotlinewidth,'color',plotlinecolor);
hold on
for ii = 5:5:z(end);
    arrow([0 z(ii+1)],[Wxlog(ii+1) z(ii+1)])
end
xl = xlabel('Wind Velocity [m/s]','interpreter','latex','FontSize',axisfontsize);
yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
set(gca,'FontSize',16);
grid on;
ylim([0 z(end)]);
% xlim([-15 0]);
set(gcf,'Units','pixels');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 4.5 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
cd(plotdir)
print('-depsc','-r600','plot_wind_log.eps');
cd(homedir)

figure(3)
pp = plot(Wxexp,z,'linewidth',plotlinewidth,'color',plotlinecolor);
hold on
for ii = 5:5:z(end);
    arrow([0 z(ii+1)],[Wxexp(ii+1) z(ii+1)])
end
xl = xlabel('Wind Velocity [m/s]','interpreter','latex','FontSize',axisfontsize);
yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
set(gca,'FontSize',16);
grid on;
ylim([0 z(end)]);
% xlim([-15 0]);
set(gcf,'Units','pixels');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 4.5 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
cd(plotdir)
print('-depsc','-r600','plot_wind_exp.eps');
cd(homedir)

figure(4)
pp = plot(Wxlin,z,'linestyle','--','linewidth',plotlinewidth,'color',plotlinecolor);
hold on
pp = plot(Wxlog,z,'linestyle','-','linewidth',plotlinewidth,'color',plotlinecolor);
pp = plot(Wxexp,z,'linestyle',':','linewidth',plotlinewidth,'color',plotlinecolor);
xl = xlabel('Wind Velocity [m/s]','interpreter','latex','FontSize',axisfontsize);
yl = ylabel('Altitude [m]','interpreter','latex','FontSize',axisfontsize);
set(gca,'FontSize',16);
grid on;
legend('Linear','Logarithmic','Power-Law','location','SouthWest');
ylim([0 z(end)]);
% xlim([-15 0]);
set(gcf,'Units','pixels');
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 4.5 6]);
set(gcf,'PaperPositionMode','manual')
set(gcf,'InvertHardCopy','off');
set(gcf,'color',[1 1 1])
cd(plotdir)
print('-depsc','-r600','plot_wind_linlog.eps');
cd(homedir)
