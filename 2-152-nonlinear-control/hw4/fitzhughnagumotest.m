initval = [0; 0; 10*rand(30,1); 0];
[t, y] = ode45(@fitzhughnagumo2, 0:.05:60, initval);

figure(1);
clf;

figure(2);
clf;

for i=3:2:31
    rndcolor = rand(3, 1);

    figure(1);
    plot(t(:,1), y(:,i),'color',rndcolor);
    hold on;

    figure(2);
    plot(t(:,1), y(:,i+1),'color',rndcolor);
    hold on;
end

figure(1);
xlabel('Time')
ylabel('v')
axis([0, 20, -2, 8]);

figure(2);
xlabel('Time')
ylabel('w')
axis([0, 20, 0, 40]);
