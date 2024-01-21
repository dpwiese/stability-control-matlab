clear all;
close all;

% Plant
A = [0, 1, 0; 0, 0, 1; -1, -2, -3];
B = [0, 0; 1, 0; -1, 2];
Lambda = [1.5, 0.2; 0.2, 0.5];
Bp = B * Lambda;
C = eye(length(A));

n = length(A);
m = size(B, 2);
p = size(C, 1);

eig_A = eig(A);
eig_Lam = eig(Lambda);

% Reference model
Am_FB = 1;

if Am_FB == 0;
    Am = A;
else
    Qr = 1*eye(n);
    Rr = 1*eye(m);
    K = lqr(A, B, Qr, Rr);
    K = -K;
    Am = A + B * K;
end

eig_Am = eig(Am);

Bm = B;

% CRM
Ql = 10*eye(n);
Rl = 1*eye(p);
L = lqr(Am', C', Ql, Rl);
L = L';

L_norm = norm(L);
Aml = Am - L * C;
eig_Aml = eig(Aml);

Q = eye(n);
P = lyap(Aml', Q');

% Simulation Setup
x0 = 2*ones(n,1);
xm0 = 0*ones(n,1);

theta_0 = zeros(m,n);
phi_0 = zeros(m,m);

tsim = 20;
data_deci = 1;

% 0 turn off, 1 turn on
CRMs = 1;

% Adaptation Gain
if CRMs == 1;
    Gamma_p = L_norm * eye(m);
    if Am_FB == 0;
        Gamma_t = 0 * eye(m);
    else
        Gamma_t = L_norm*eye(m);
    end
else
    Gamma_p = 10 * eye(m);
    if Am_FB == 0;
        Gamma_t = 0 * eye(m);
    else
        Gamma_t = 10 * eye(m);
    end
end

error('open P4_sim.slx and run the simulation');

% Data processing

theta = permute(theta, [3, 1, 2]);
phi = permute(phi, [3, 1, 2]);

% Plot the figures
% Initialize_Opt_v1;

opt.colortype = {'r', 'b', 'k', 'g', 'y', 'c'};
opt.fighold = 0;
opt.plotpara = 2;
opt.linecolor = 'k';
opt.linestyle = '-';
opt.linewidth = 2;
opt.gridon = 0;
opt.legfontsize = 12;

figsize = [4, 4, 5, 2];

opt.plotcrm = 1;
opt.plotcmd = 1;
opt.plotinput = 1;
opt.plotoutput = 1;
opt.plotmain = 1;
opt.plotstate = [1:3];
opt.legname = 'sim';
opt.figsave = 0;
opt.figname = [];
opt.ignoreylim = 0;
opt.figfontsize = 15;

opt.fig_r = 3;
opt.fig_c = 3;

num_input = size(u,2);
num_state = size(x,2);
num_cmd = size(r,2);
xmin = ts(1);
xmax = ts(end);

%% Plot states

figure(1);
clf;
box on;

figarraysize = [1, 1, opt.fig_c*figsize(3), opt.fig_r*figsize(4)];

set(gcf, 'paperunits', 'inches', 'paperPosition', figarraysize)
set(gcf, 'Units', 'inches', 'paperPosition', figarraysize)
set(gcf, 'Units', 'inches', 'Position', figarraysize)
set(gcf, 'PaperPositionMode', 'auto');

for i=1:1:9

    if i<=3
        subplot(opt.fig_r, opt.fig_c, i);
        hold on;
        box on;
        plot(ts,x(:,i), 'color', opt.linecolor, 'linestyle',opt.linestyle, 'linewidth', opt.linewidth);
    if opt.plotcrm
        plot(ts,xm(:,i), 'color', opt.linecolor, 'linestyle', ':', 'linewidth',opt.linewidth);
    end

    ylabel(strcat('$x_',num2str(i), '$'), 'interpreter', 'Latex', 'fontsize',opt.figfontsize);
        if i==3;
            hl=legend({'x';'x_m'}, 'location', 'northeast');
            set(hl, 'fontsize',opt.legfontsize);
        end

    elseif i<=5
        subplot(opt.fig_r, opt.fig_c, i);
        hold on;
        box on;
        plot(ts,u(:,i-3), 'color', opt.linecolor, 'linestyle', opt.linestyle, 'linewidth', opt.linewidth);
        ylabel(strcat('$u_', num2str(i-3), '$'), 'interpreter', 'Latex', 'fontsize', opt.figfontsize);
    elseif i<=7
        subplot(opt.fig_r, opt.fig_c, i);
        hold on;
        box on;
        plot(ts,r(:,i-5), 'color', opt.linecolor, 'linestyle', opt.linestyle, 'linewidth', opt.linewidth);
        ylabel(strcat('$r_', num2str(i-5), '$'), 'interpreter', 'Latex', 'fontsize', opt.figfontsize);
    elseif i==8
        subplot(opt.fig_r, opt.fig_c, i);
        hold on;
        box on;
        if length(size(theta))==3;
            theta_plot=theta(:,:);
        end
        for k=1:1:size(theta_plot,2);
            plot(ts, theta_plot(:,k), 'color', opt.colortype{k}, 'linestyle', opt.linestyle', 'linewidth', opt.linewidth);
        end
        ylabel('$\Theta$', 'interpreter', 'Latex', 'fontsize', opt.figfontsize);
    elseif i==9
        subplot(opt.fig_r, opt.fig_c, i);
        hold on;
        box on;
        if length(size(phi))==3;
            phi_plot=phi(:,:);
        end
        for k=1:1:size(phi_plot, 2);
            plot(ts,phi_plot(:,k), 'color', opt.colortype{k}, 'linestyle', opt.linestyle', 'linewidth', opt.linewidth);
        end
        ylabel('$\Phi$', 'interpreter', 'Latex', 'fontsize', opt.figfontsize);
    end
    if opt.gridon==1;
        grid on;
    end;
    xlabel('Time [sec]', 'fontsize', opt.figfontsize);
    set(gca, 'FontSize', opt.figfontsize)
    xlim([xmin, xmax]);
end

set(findall(gcf, 'type', 'text'), 'fontName', 'Times', 'fontsize', opt.figfontsize)
set(findall(gcf, 'type', 'number'), 'fontName', 'Times', 'fontsize', opt.figfontsize)

if opt.figsave==1;
    % print (1, '-depsc', strcat('P4_Sim_Results', '.eps'))
    print (1, '-depsc', strcat('P4_Sim_Results_ORM', '.eps'))
end
