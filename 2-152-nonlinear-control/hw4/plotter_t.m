function plotter_t(u, qtilde, time, titlename)

    subplot(4, 1, 1);
    plot(time(:,1), qtilde(:,1), 'b');
    hold on;

    subplot(4, 2, 1);
    plot(time(:,1), qtilde(:,2), 'b');
    title(titlename)

    subplot(4, 1, 2);
    plot(time(:,1), u(:,1), 'b');
    hold on;

    subplot(4, 2, 2);
    plot(time(:,1), u(:,2), 'b');

end
