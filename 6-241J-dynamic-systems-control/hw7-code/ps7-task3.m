%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 6.241 Homework Assignment #7
% Task 3
% Due: Friday April 27, 2012
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;
close all;
clc;

this_mfile = dbstack('-completenames');
this_dir = fileparts(this_mfile.file);
plot_dir = sprintf('%s', '\latex');

open_system('model3a')
open_system('model3b')

s = tf('s');

h_vec = [0.1:0.1:10];

for i = 1:length(h_vec)
    h = h_vec(i);
    F1 = (s+1)/(s^2+s+1);
    F2 = (s^2)/(s^2+s+1);
    [A,B,C,D] = linmod2('Dan_model3a');
    sys = minreal(ss(A,B,C,D));
    K_vec = h2syn(sys,1,1);
    K = minreal(K_vec);
    [A2,B2,C2,D2] = linmod2('Dan_model3b');
    gamma(i) = norm(minreal(ss(A2,B2,C2,D2)));
end

cd(plot_dir)
figure(1)
plot(h_vec,gamma)
grid on
xlabel('h')
ylabel('H_{2} Norm of e(s)/w(s)')
set(gcf,'Units','inches');
set(gcf, 'OuterPosition', [1, 1, 6, 5])
set(gcf, 'PaperPositionMode', 'auto')
print('-depsc','-r600','task3_v1.eps');
saveas(get_param('Dan_model3a','Handle'),'task3ablock_v1.eps');
saveas(get_param('Dan_model3b','Handle'),'task3bblock_v1.eps');
cd(this_dir)

close_system('model3a')
close_system('model3b')
