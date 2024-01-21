function plotter(u, qtilde, time, ahat, a1, a2, a3, a4, titlename)

    title(titlename)

    subplot(4,2,1)
    plot(time(:,1),qtilde(:,1),'LineStyle','-','Color','Black'); hold on;
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('Error $q_{1}$','interpreter','latex','FontSize',10)

    subplot(4,2,2)
    plot(time(:,1),qtilde(:,2),'LineStyle','-','Color','Black'); hold on;
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('Error $q_{2}$','interpreter','latex','FontSize',10)

    subplot(4,2,3)
    plot(time(:,1),u(:,1),'LineStyle','-','Color','Black'); hold on;
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('Input 1','interpreter','latex','FontSize',10)

    subplot(4,2,4)
    plot(time(:,1),u(:,2),'LineStyle','-','Color','Black');
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('Input 2','interpreter','latex','FontSize',10)

    subplot(4,2,5)
    plot(time(:,1),ahat(:,1),'LineStyle','-','Color','Black','Linewidth',1)
    hold on
    plot(time(:,1),a1*ones(length(time(:,1)),1),'LineStyle',':','Color','Black','Linewidth',2);
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('$\hat{a}_{1}$','interpreter','latex','FontSize',10)

    subplot(4,2,6)
    plot(time(:,1),ahat(:,2),'LineStyle','-','Color','Black','Linewidth',1)
    hold on
    plot(time(:,1),a2*ones(length(time(:,1)),1),'LineStyle',':','Color','Black','Linewidth',2);
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('$\hat{a}_{2}$','interpreter','latex','FontSize',10)

    subplot(4,2,7)
    plot(time(:,1),ahat(:,3),'LineStyle','-','Color','Black','Linewidth',1)
    hold on
    plot(time(:,1),a3*ones(length(time(:,1)),1),'LineStyle',':','Color','Black','Linewidth',2);
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('$\hat{a}_{3}$','interpreter','latex','FontSize',10)

    subplot(4,2,8)
    plot(time(:,1),ahat(:,4),'LineStyle','-','Color','Black','Linewidth',1)
    hold on
    plot(time(:,1),a4*ones(length(time(:,1)),1),'LineStyle',':','Color','Black','Linewidth',2);
    xlabel('Time','interpreter','latex','FontSize',10)
    ylabel('$\hat{a}_{4}$','interpreter','latex','FontSize',10)

end
