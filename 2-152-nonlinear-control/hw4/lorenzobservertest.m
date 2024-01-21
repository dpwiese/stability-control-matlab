% Random initial values for all between 0 and 10
initval = 10 * rand(5,1);
[t, y] = ode45(@noisylorenzobserver, 0:.01:10, initval);

figure(1);
clf;
plot(t, y(:,1), '-');
xlabel('Time');
ylabel('x');

figure(2);
clf;
plot(t, y(:,2)-y(:,4), '-');
hold on;
xlabel('Time');
ylabel('y error');

figure(3);
clf;
plot(t, y(:,3)-y(:,5), '-');
hold on;
xlabel('Time');
ylabel('z error');
