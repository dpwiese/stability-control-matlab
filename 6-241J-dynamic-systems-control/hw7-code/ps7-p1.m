% 6.241 Dynamic Systems and Control
% Problem Set 7
% Problem 2

clear all;
close all;
clc;

s = zpk('s');

avect = [-10:1:10];

for i = 1:1:21
    for j = 1:1:1

    const = 1;
    a = avect(i);
    % a = 1;
    passband = 0.25*abs(a+0.00001);
    shift = 30;

    [A,B,C,D] = linmod2('model2');
    sys = ss(A,B,C,D);

    [K,CL,GAM,INFO] = hinfsyn(sys,1,1);

    [A2,B2,C2,D2] = linmod2('test2');
    test = ss(A2,B2,C2,D2);

    [mag,phase,wout] = bode(test);

    figure(1)
    plot(wout,squeeze(mag))
    xlim([0.01 10])
    ylim([0 0.1])
    hold all

    max(squeeze(mag))

    figure(2)
    plot(wout,squeeze(mag))
%     xlim([0.01 1])
%     ylim([0 0.1])
    hold all

    end
end
