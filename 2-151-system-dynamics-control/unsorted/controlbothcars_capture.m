%% Control of Both Cars
% 2.151

clear;
figure(1);
clf;
hold on;

x1      = 2; % Initial Position Car 1
x2      = 1; % Initial Position Car 1
v1      = 6; % Initial Velocity Car 1
v2      = 3; % Initial Velocity Car 2
vmin    = 1; % Minimum Velocity for both cars
vmax    = 6; % Maximum Velocity for both cars
tstep   = 0.02;
ah      = 6; % Accel high
al      = -6; % Accel low
Lo      = [6, 6];
Uo      = [8, 8];
x1enter = Lo(1);
x1exit  = Uo(1);
y2enter = Lo(2);
y2exit  = Uo(2);
LCh     = zeros(2);UCh = zeros(2);LCl = zeros(2);UCl = zeros(2);

LCh(1,:) = Lo;
UCh(1,:) = Uo;
LCl(1,:) = Lo;
UCl(1,:) = Uo;

%Car Sim loop.
n = 2;
v1 = [v1, v1, v1];
v2 = [v2, v2, v2];
x1 = [x1, x1, x1];
x2 = [x2, x2, x2];
a1 = [0, 0, 0];
a2 = [0, 0, 0];

while x1(n)<Uo(1)+1 && x2(n)<Uo(2)+1

    clf;
    subplot(1,2,1);
    hold on;

    inCh = 0;nextCh = 0;
    inCl = 0;nextCl = 0;

    % Check if car is in capture set
    x1(n+2) = x1(n+1)+tstep*v1(n); % check where the cars will be with no acceleration
    x2(n+2) = x2(n+1)+tstep*v2(n);

    for i = 1:length(LCh)
        if x1(n)>LCh(i,1) && x1(n)<UCh(i,1) && x2(n)>LCh(i,2) && x2(n)<UCh(i,2)
            inCh = 1;  %in Ch
            break
        end
    end

    for i = 1:length(LCh)
        if x1(n+2)>LCh(i,1) && x1(n+2)<UCh(i,1) && x2(n+2)>LCh(i,2) && x2(n+2)<UCh(i,2) %%step would enter Ch
            nextCh = 1;
            break
        end
    end

    for j = 1:length(LCl)
        if x1(n)>LCl(j,1) && x1(n)<UCl(j,1) && x2(n)>LCl(j,2) && x2(n)<UCl(j,2)
            inCl = 1;
            break
        end
    end

    for j = 1:length(LCl)
        if x1(n+2)>LCl(j,1) && x1(n+2)<UCl(j,1) && x2(n+2)>LCl(j,2) && x2(n+2)<UCl(j,2)
            nextCl = 1;
            break
        end
    end

    if inCh =  = 1 && nextCl =  = 1
        a1(n) = al;
        a2(n) = ah;
    elseif inCl =  = 1 && nextCh =  = 1
        a1(n) = ah;
        a2(n) = al;
    elseif (x2(n)+(v2(n)/v1(n))*(Lo(1)-x1(n)))<Lo(2)
        a1(n) = 0;
        a2(n) = 0;
    else
        a1(n) = 0;
        a2(n) = 0;
    end

    plot([Lo(1), Lo(1)], [Lo(2), Uo(2)], 'k');
    plot([Uo(1), Uo(1)], [Lo(2), Uo(2)], 'k');
    plot([Lo(1), Uo(1)], [Lo(2), Lo(2)], 'k');
    plot([Lo(1), Uo(1)], [Uo(2), Uo(2)], 'k');
    axis([0, 9, 0, 9])
    axis square

    % Calculate Ch
    k = 1;
    v1Ch = v1(n);
    v2Ch = v2(n);
    while UCh(k,1)>x1(1)-.5 && UCh(k,2)>x2(1)-.5
        if v1Ch(k)+ ah*tstep<vmax
            v1Ch(k+1) = v1Ch(k)+ ah*tstep;
            LCh(k+1,1) = Lo(1)-k*tstep*v1Ch(1)-(k-1)*k/2*tstep^2*ah;
            UCh(k+1,1) = Uo(1)-k*tstep*v1Ch(1)-(k-1)*k/2*tstep^2*ah;
        else
            v1Ch(k+1) =  vmax;
            LCh(k+1,1) = LCh(k,1)-tstep*vmax;
            UCh(k+1,1) = UCh(k,1)-tstep*vmax;
        end

        if v2Ch(k)+ al*tstep>vmin
           v2Ch(k+1) = v2Ch(k)+ al*tstep;
           LCh(k+1,2) = Lo(2)-k*tstep*v2Ch(1)-(k-1)*k/2*tstep^2*al;
           UCh(k+1,2) = Uo(2)-k*tstep*v2Ch(1)-(k-1)*k/2*tstep^2*al;
        else
           v2Ch(k+1) = vmin;
           LCh(k+1,2) = LCh(k,2)-tstep*vmin;
           UCh(k+1,2) = UCh(k,2)-tstep*vmin;
        end
        % plot([LCh(k+1,1),LCh(k+1,1)],[LCh(k+1,2),UCh(k+1,2)]);plot([UCh(k+1,1),UCh(k+1,1)],[LCh(k+1,2),UCh(k+1,2)]);
        % plot([LCh(k+1,1),UCh(k+1,1)],[LCh(k+1,2),LCh(k+1,2)]);plot([LCh(k+1,1),UCh(k+1,1)],[UCh(k+1,2),UCh(k+1,2)]);
        k = k+1;
    end
    % plot(LCh(:,1),UCh(:,2))
    plot(UCh(1:(k-5),1),LCh(1:(k-5),2))

    % Calculate Cl
    k = 1;
    v1Cl = v1(n);
    v2Cl = v2(n);
    while UCl(k,1)>x1(1)-.5 && UCl(k,2)>x2(1)-.5
        if v1Cl(k)+ al*tstep>vmin
            v1Cl(k+1) = v1Cl(k)+ al*tstep;
            LCl(k+1,1) = Lo(1)-k*tstep*v1Cl(1)-(k-1)*k/2*tstep^2*al;
            UCl(k+1,1) = Uo(1)-k*tstep*v1Cl(1)-(k-1)*k/2*tstep^2*al;
        else
            v1Cl(k+1) =  vmin;
            LCl(k+1,1) = LCl(k,1)-tstep*vmin;
            UCl(k+1,1) = UCl(k,1)-tstep*vmin;
        end

        if v2Cl(k)+ ah*tstep<vmax
           v2Cl(k+1) = v2Cl(k)+ ah*tstep;
           LCl(k+1,2) = Lo(2)-k*tstep*v2Cl(1)-(k-1)*k/2*tstep^2*ah;
           UCl(k+1,2) = Uo(2)-k*tstep*v2Cl(1)-(k-1)*k/2*tstep^2*ah;
        else
           v2Cl(k+1) = vmax;
           LCl(k+1,2) = LCl(k,2)-tstep*vmax;
           UCl(k+1,2) = UCl(k,2)-tstep*vmax;
        end
       % plot([LCl(k+1,1),LCl(k+1,1)],[LCl(k+1,2),UCl(k+1,2)],'r');plot([UCl(k+1,1),UCl(k+1,1)],[LCl(k+1,2),UCl(k+1,2)],'r');
       % plot([LCl(k+1,1),UCl(k+1,1)],[LCl(k+1,2),LCl(k+1,2)],'r');plot([LCl(k+1,1),UCl(k+1,1)],[UCl(k+1,2),UCl(k+1,2)],'r');
        k = k+1;
    end

    plot(LCl(1:(k-5),1),UCl(1:(k-5),2))
    %plot(UCl(:,1),LCl(:,2))

    n = n+1;
    v1(n) = v1(n-1)+tstep*a1(n-1);
    v2(n) = v2(n-1)+tstep*a2(n-1);
    x1(n+1) = x1(n)+tstep*v1(n);
    x2(n+1) = x2(n)+tstep*v2(n);
    plot(x1(1:n),x2(1:n),'ko')
    title('Control of both car (with vmax & vmin)')
    xlabel('car 1 position')
    ylabel('car 2 position')
    [inCh;nextCh;inCl;nextCl];
    [a1(n-1);a2(n-1)];

end
