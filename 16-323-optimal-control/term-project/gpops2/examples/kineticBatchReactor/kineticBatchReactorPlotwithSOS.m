%----------------------------------%
%   Plot Solution from GPOPS-II    %
%----------------------------------%
% Load the SOS Solution
SOS{1} = load('solutions/kineticBatchReactorSOSPhase1.dat');
SOS{2} = load('solutions/kineticBatchReactorSOSPhase2.dat');
SOS{3} = load('solutions/kineticBatchReactorSOSPhase3.dat');
solution = output.result.solution;
marks = {'-bd','-gs','-r^','-cv','-mo','-kh'};
% Extract the time in each phase of the problem.
time{1} = solution.phase(1).time;
time{2} = solution.phase(2).time;
time{3} = solution.phase(3).time;
timeRadau{1} = solution.phase(1).timeRadau;
timeRadau{2} = solution.phase(2).timeRadau;
timeRadau{3} = solution.phase(3).timeRadau;
for iphase=1:3
  y{iphase} = solution.phase(iphase).state;
  u{iphase} = solution.phase(iphase).control;
  uRadau{iphase} = solution.phase(iphase).controlRadau;
end;
solution = output.result.solution;
% Extract the time in each phase of the problem.
timeSOS{1} = SOS{1}(:,1);
timeSOS{2} = SOS{2}(:,1);
timeSOS{3} = SOS{3}(:,1);
for iphase=1:3
  ySOS{iphase} = SOS{iphase}(:,2:7);
  uSOS{iphase} = SOS{iphase}(:,8:12);
end;
nstates = 6;
ncontrols = 5;
for istate = 1:nstates
  stateString = strcat('$y_',num2str(istate),'(t)$');
  stateStringPrint = strcat('Y',num2str(istate));
  figure(istate);
  pp = plot(timeSOS{1},ySOS{1}(:,istate),marks{1},timeSOS{2},ySOS{2}(:,istate),marks{2},timeSOS{3},ySOS{3}(:,istate),marks{3},time{1},y{1}(:,istate),marks{4},time{2},y{2}(:,istate),marks{5},time{3},y{3}(:,istate),marks{6});
  xl = xlabel('$t \textrm{(hours)}$','interpreter','LaTeX');
  yl = ylabel(stateString,'interpreter','LaTeX');
  ll = legend('Phase 1 (SOS)','Phase 2 (SOS)','Phase 3 (SOS)','Phase 1 (GPOPS-II)','Phase 1 (GPOPS-II)','Phase 1 (GPOPS-II)','Location','Best');
  set(pp,'LineWidth',1.25,'MarkerSize',6);
  set(xl,'FontSize',18,'interpreter','LaTeX');
  set(yl,'FontSize',18,'interpreter','LaTeX');
  set(ll,'FontSize',20);
  set(gca,'FontSize',16,'FontName','Times');
  grid on;
  filename = strcat([,'kineticBatchReactor',stateStringPrint,'.eps']);
  print('-depsc2',filename);
end;

for icontrol = 1:ncontrols
  figure(icontrol+nstates);
  controlStringPrint = strcat('U',num2str(icontrol));
  if (icontrol==2),
    controlString = strcat('$u_',num2str(icontrol),'(t)\times 10^{-3}$');
    pp = plot(timeSOS{1},uSOS{1}(:,icontrol)*1e3,marks{1},timeSOS{2},uSOS{2}(:,icontrol)*1e3,marks{2},timeSOS{3},uSOS{3}(:,icontrol)*1e3,marks{3},timeRadau{1},uRadau{1}(:,icontrol)*1e3,marks{4},timeRadau{2},uRadau{2}(:,icontrol)*1e3,marks{5},timeRadau{3},uRadau{3}(:,icontrol)*1e3,marks{6});
  elseif (icontrol==3) || (icontrol==4),
    controlString = strcat('$u_',num2str(icontrol),'(t)\times 10^{-5}$');
    pp = plot(timeSOS{1},uSOS{1}(:,icontrol)*1e5,marks{1},timeSOS{2},uSOS{2}(:,icontrol)*1e5,marks{2},timeSOS{3},uSOS{3}(:,icontrol)*1e5,marks{3},timeRadau{1},uRadau{1}(:,icontrol)*1e5,marks{4},timeRadau{2},uRadau{2}(:,icontrol)*1e5,marks{5},timeRadau{3},uRadau{3}(:,icontrol)*1e5,marks{6});
  else
    controlString = strcat('$u_',num2str(icontrol),'(t)$');
   pp = plot(timeSOS{1},uSOS{1}(:,icontrol),marks{1},timeSOS{2},uSOS{2}(:,icontrol),marks{2},timeSOS{3},uSOS{3}(:,icontrol),marks{3},timeRadau{1},uRadau{1}(:,icontrol),marks{4},timeRadau{2},uRadau{2}(:,icontrol),marks{5},timeRadau{3},uRadau{3}(:,icontrol),marks{6});
  end
  xl = xlabel('$t \textrm{(hours)}$','interpreter','LaTeX');
  yl = ylabel(controlString,'interpreter','LaTeX');
  ll = legend('Phase 1 (SOS)','Phase 2 (SOS)','Phase 3 (SOS)','Phase 1 (GPOPS-II)','Phase 1 (GPOPS-II)','Phase 1 (GPOPS-II)','Location','Best');
  set(pp,'LineWidth',1.25,'MarkerSize',6);
  set(xl,'FontSize',18,'interpreter','LaTeX');
  set(yl,'FontSize',18,'interpreter','LaTeX');
  set(ll,'FontSize',20);
  set(gca,'FontSize',16,'FontName','Times');
  grid on;
  filename = strcat([,'kineticBatchReactor',controlStringPrint,'.eps']);
  print('-depsc2',filename);
end;

close all;

for istate = 1:nstates
  stateString = strcat('$y_',num2str(istate),'(t)$');
  stateStringPrint = strcat('Y',num2str(istate));
  figure(istate);
  pp = plot(timeSOS{1},ySOS{1}(:,istate),marks{1},time{1},y{1}(:,istate),marks{2});
  xl = xlabel('$t \textrm{(hours)}$','interpreter','LaTeX');
  yl = ylabel(stateString,'interpreter','LaTeX');
  ll = legend('Phase 1 (SOS)','Phase 1 (GPOPS-II)','Location','Best');
  set(pp,'LineWidth',1.25,'MarkerSize',6);
  set(xl,'FontSize',18,'interpreter','LaTeX');
  set(yl,'FontSize',18,'interpreter','LaTeX');
  set(ll,'FontSize',20);
  set(gca,'FontSize',16,'FontName','Times');
  grid on;
  filename = strcat([,'kineticBatchReactor',stateStringPrint,'Phase1.eps']);
  print('-depsc2',filename);
end;

for icontrol = 1:ncontrols
  figure(icontrol+nstates);
  controlStringPrint = strcat('U',num2str(icontrol));
  if (icontrol==2),
    controlString = strcat('$u_',num2str(icontrol),'(t)\times 10^{-3}$');
    pp = plot(timeSOS{1},uSOS{1}(:,icontrol)*1e3,marks{1},timeRadau{1},uRadau{1}(:,icontrol)*1e3,marks{2});
  elseif (icontrol==3) || (icontrol==4),
    controlString = strcat('$u_',num2str(icontrol),'(t)\times 10^{-5}$');
    pp = plot(timeSOS{1},uSOS{1}(:,icontrol)*1e5,marks{1},timeRadau{1},uRadau{1}(:,icontrol)*1e5,marks{2});
  else
    controlString = strcat('$u_',num2str(icontrol),'(t)$');
    pp = plot(timeSOS{1},uSOS{1}(:,icontrol),marks{1},timeRadau{1},uRadau{1}(:,icontrol),marks{2});
  end
  xl = xlabel('$t \textrm{(hours)}$','interpreter','LaTeX');
  yl = ylabel(controlString,'interpreter','LaTeX');
  ll = legend('Phase 1 (SOS)','Phase 1 (GPOPS-II)','Location','Best');
  set(pp,'LineWidth',1.25,'MarkerSize',6);
  set(xl,'FontSize',18,'interpreter','LaTeX');
  set(yl,'FontSize',18,'interpreter','LaTeX');
  set(ll,'FontSize',20);
  set(gca,'FontSize',16,'FontName','Times');
  grid on;
  filename = strcat([,'kineticBatchReactor',controlStringPrint,'Phase1.eps']);
  print('-depsc2',filename);
end;
