%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.S997
% Lecture 3: Adaptive Tuning and Closed-Loop Reference Models
% Master Script
%---------------------------------------------------------------------------------------------------
% This script simulates the response of an adaptive system as the adaptive
% tuning gain is varied, and compares ORM responses to CRM responses.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
clc;
close all;

restoredefaultpath;

thismfile = dbstack('-completenames');
thisdir = fileparts(thismfile.file);
cd(thisdir);
addpath(fullfile(fileparts(pwd)));
plotdir = '';

%---------------------------------------------------------------------------------------------------

tsim = 30;

% Reference model
am = -1;
km = 1;

% Plant
ap = 1;
kp = 2;
xp0 = 0;

%Simulate model
allrunnames = {'orm1', 'orm2', 'orm3', 'crm1', 'crm2', 'crm3'};

% for ii=1:length(allrunnames)
 % runname='crm3';
% runname=allrunnames{ii};
% simsetup_crmorm_v2;
sizefont = 22;
linewidth = 3;
ticklabelfontsize = 20;

% k2iplotsig.(runname) = k2iout.signals.values;
% k2iplottime.(runname) = k2iout.time;
% t2iplotsig.(runname) = t2iout.signals.values;
% t2iplottime.(runname) = t2iout.time;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %Plot
% figure(1)

% subplot(1, 2, 1)
% hold on;
% if sum(strcmp(runname(1), 'o'))==1
%     plot(time.(runname), xmo.(runname), 'linestyle', '--', 'color', [0, 0, 0], 'linewidth', linewidth);
%     plot(time.(runname), xp.(runname), 'linestyle', '-', 'color', [0, 0, 0], 'linewidth', linewidth);
% else
%     plot(time.(runname), xmo.(runname), 'linestyle', '--', 'color', [0, 0, 0], 'linewidth', linewidth);
%     plot(time.(runname), xp.(runname), 'linestyle', '-', 'color', [0, 0, 0], 'linewidth', linewidth);
%     plot(time.(runname), xmc.(runname), 'linestyle', '--', 'color', [0.5, 0.5, 0.5], 'linewidth', 0.5*linewidth);
% end

% xlabel('time [s]', 'interpreter', 'latex', 'FontSize',sizefont);
% ylabel('State', 'interpreter', 'latex', 'FontSize',sizefont);

% if sum(strcmp(runname(1), 'o'))==1
%     legend('$x_{m}$', '$x_{p}$', 'Location', 'NorthEast');
% else
%     legend('$x_{m}^{o}$', '$x_{p}$', '$x_{m}$', 'Location', 'NorthEast');
% end

% temphandle = legend;
% set(temphandle, 'interpreter', 'latex', 'FontSize', sizefont, 'box', 'off');
% ylim([-0.2, 2.5])
% set(gca, 'box', 'off');
% set(gca, 'fontsize', ticklabelfontsize);
% set(gca, 'fontname', 'times');

% subplot(1, 2, 2)
% plot(time.(runname), theta.(runname), 'color',[0.5, 0.5, 0.5], 'linewidth', linewidth);
% hold on;
% plot(time.(runname), k.(runname), 'color', [0, 0, 0], 'linewidth', linewidth);
% legend('$\theta$', '$k$', 'Location', 'NorthEast');
% temphandle = legend;
% set(temphandle, 'interpreter', 'latex', 'FontSize', sizefont, 'box', 'off');
% ylim([-1.3, 1.3]);
% xlabel('time [s]', 'interpreter', 'latex', 'FontSize', sizefont);
% ylabel('Parameter', 'interpreter', 'latex', 'FontSize', sizefont);
% set(gca, 'box', 'off');
% set(gca, 'fontsize', ticklabelfontsize);
% set(gca, 'fontname', 'times');

% %-------------------------------------------------------------------------------------------------
% % ha=axes('Position',[0 0 1 1], 'Xlim',[0 1], 'Ylim',[0 1], 'Box', 'off', 'Visible',...
% %     'off', 'Units', 'normalized', 'clipping', 'off');

% % if sum(strcmp(runname(1), 'o'))==1
% %     plot_title1=strcat('$\gamma=$',sprintf('%0.0f',gamma));
% % else
% %     plot_title1=strcat('$\gamma=$',sprintf('%0.0f',gamma), ', $\ell=$',...
% %         sprintf('%0.0f',l));
% % end
% % text(0.5, 1,plot_title1, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'top',...
% %     'interpreter', 'latex', 'FontSize',sizefont);

% set(gcf, 'Units', 'pixels');
% set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 11, 4.5]);
% set(gcf, 'PaperPositionMode', 'manual')
% set(gcf, 'InvertHardCopy', 'off');
% set(gcf, 'color', [1, 1, 1])

% cd(plotdir)
% filename=strcat('gib_ormcrm_',runname, '.eps');
% print('-depsc',filename);
% clf;
% cd(thisdir);

load dandata

% allrunnames{ii}
% colorarr = [0, 0, 0; 0.5, 0.5, 0.5; 0.8, 0, 0; 0, 0.6, 0; 0, 0, 0.8; 0, 1, 1];
colorarr = [0, 0, 0; 0, 0, 0; 0, 0, 0; 0.5, 0.5, 0.5; 0.5, 0.5, 0.5; 0.5, 0.5, 0.5];
stylearr = {'-', '--', '-.', '-', '--', '-.'}';

figure(2)
subplot(1, 2, 1)

% for jj=1:length(allrunnames)
%     runname=allrunnames{jj};
%     plot(k2iplottime.(runname), k2iplotsig.(runname), 'linestyle', '-', 'linewidth', linewidth, 'color', colorarr(jj,:));
%     hold on;
% end

jj=1;
plot(k2iplottime.(allrunnames{jj}), k2iplotsig.(allrunnames{jj}), 'linestyle', '-', 'linewidth', linewidth, 'color', colorarr(jj,:))
hold on
jj=2;
plot(k2iplottime.(allrunnames{jj}), k2iplotsig.(allrunnames{jj}), 'linestyle', '--', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=3;
plot(k2iplottime.(allrunnames{jj}), k2iplotsig.(allrunnames{jj}), 'linestyle', '-.', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=4;
plot(k2iplottime.(allrunnames{jj}), k2iplotsig.(allrunnames{jj}), 'linestyle', '-', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=5;
plot(k2iplottime.(allrunnames{jj}), k2iplotsig.(allrunnames{jj}), 'linestyle', '--', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=6;
plot(k2iplottime.(allrunnames{jj}), k2iplotsig.(allrunnames{jj}), 'linestyle', '-.', 'linewidth', linewidth, 'color', colorarr(jj,:))

xlabel('time [s]', 'interpreter', 'latex', 'FontSize', sizefont)
ylabel('State', 'interpreter', 'latex', 'FontSize', sizefont)
legend(allrunnames, 'Location', 'NorthEast')
temphandle = legend;
set(temphandle, 'interpreter', 'latex', 'FontSize', sizefont, 'box', 'off')
ylim([-0.2, 20])
set(gca, 'box', 'off')
set(gca, 'fontsize', ticklabelfontsize);
set(gca, 'fontname', 'times');
subplot(1, 2, 2)

% for jj=1:length(allrunnames)
%     runname = allrunnames{jj};
%     plot(t2iplottime.(runname), t2iplotsig.(runname), 'linestyle', '-', 'linewidth', linewidth, 'color', colorarr(jj,:))
%     hold on;
% end

jj=1;
plot(t2iplottime.(allrunnames{jj}),t2iplotsig.(allrunnames{jj}), 'linestyle', '-', 'linewidth', linewidth, 'color', colorarr(jj,:))
hold on;
jj=2;
plot(t2iplottime.(allrunnames{jj}),t2iplotsig.(allrunnames{jj}), 'linestyle', '--', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=3;
plot(t2iplottime.(allrunnames{jj}),t2iplotsig.(allrunnames{jj}), 'linestyle', '-.', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=4;
plot(t2iplottime.(allrunnames{jj}),t2iplotsig.(allrunnames{jj}), 'linestyle', '-', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=5;
plot(t2iplottime.(allrunnames{jj}),t2iplotsig.(allrunnames{jj}), 'linestyle', '--', 'linewidth', linewidth, 'color', colorarr(jj,:))
jj=6;
plot(t2iplottime.(allrunnames{jj}),t2iplotsig.(allrunnames{jj}), 'linestyle', '-.', 'linewidth', linewidth, 'color', colorarr(jj,:))

legend(allrunnames, 'Location', 'NorthEast');
temphandle = legend;
set(temphandle, 'interpreter', 'latex', 'FontSize', sizefont, 'box', 'off');
ylim([-0.2, 20])
xlabel('time [s]', 'interpreter', 'latex', 'FontSize', sizefont);
ylabel('Parameter', 'interpreter', 'latex', 'FontSize', sizefont);
set(gca, 'box', 'off')
set(gca, 'fontsize', ticklabelfontsize);
set(gca, 'fontname', 'times');
set(gcf, 'Units', 'pixels');
set(gcf, 'PaperUnits', 'inches', 'PaperPosition', [0, 0, 11, 4.5]);
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'InvertHardCopy', 'off');
set(gcf, 'color', [1, 1, 1])

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
