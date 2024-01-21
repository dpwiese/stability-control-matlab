function plotter2(u, qtilde, time, titlename)

    title(titlename)

    subplot(2, 2, 1);
    plot(time(:,1), qtilde(:,1), 'Color', 'Black');
    hold on;
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('Error $q_{1}$', 'interpreter', 'latex', 'FontSize', 10);

    subplot(2, 2, 2);
    plot(time(:,1), qtilde(:,2), 'Color', 'Black');
    hold on;
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('Error $q_{2}$', 'interpreter', 'latex', 'FontSize', 10);

    subplot(2, 2, 3);
    plot(time(:,1), u(:,1), 'Color', 'Black');
    hold on;
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('Input 1', 'interpreter', 'latex', 'FontSize', 10);

    subplot(2, 2, 4);
    plot(time(:,1), u(:,2), 'Color', 'Black');
    xlabel('Time', 'interpreter', 'latex', 'FontSize', 10);
    ylabel('Input 2', 'interpreter', 'latex', 'FontSize', 10);

end
