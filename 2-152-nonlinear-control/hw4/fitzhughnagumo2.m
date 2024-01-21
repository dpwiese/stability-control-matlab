function dy = fitzhughnagumo2(t,y)

    % The system relies on having 30 oscillators but also depends on neighboring oscillators. We
    % will say that v1 is coupled to zero on its left and v15 is coupled to zero on its right.

    dy = zeros(33, 1);

    % y(1) = v0 = 0,
    % y(3) = v1,
    % y(4) = w1,
    % y(5) = v2,
    % ...,
    % y(31) = v15,
    % y(32) = w15,
    % y(33) = v16 = 0

    % for i = 3:2:31 % 3, 5, 7, ...
    %       %if(i <= 21)
    %           I = 5;
    %       %else
    %          % I = 7;
    %      % end

    %     if i == 3
    %         dy(i,1) = y(i,1) * (6 - y(i,1)) * (y(i,1) - 1) - y(i+1,1) + I + 25 * (y(i+2,1) + y(31,1) - 2*y(i,1)); % v
    %         dy(i+1,1) = 3 * y(i,1) - 0.09 * y(i+1,1); % w
    %     elseif i == 31
    %         dy(i,1) = y(i,1) * (6 - y(i,1)) * (y(i,1) - 1) - y(i+1,1) + I + 25 * (y(3,1) + y(i-2,1) - 2*y(i,1)); % v
    %         dy(i+1,1) = 3 * y(i,1) - 0.09 * y(i+1,1); % w
    %     else
    %         dy(i,1) = y(i,1) * (6 - y(i,1)) * (y(i,1) - 1) - y(i+1,1) + I + 25 * (y(i+2,1) + y(i-2,1) - 2*y(i,1)); % v
    %         dy(i+1,1) = 3 * y(i,1) - 0.09 * y(i+1,1); % w
    %     end

    % end

    % Plant parameters
    alpha   = 6;
    beta    = 3;
    gamma   = 0.09;
    k       = 25;

    for i = 3:2:31

        I=5;

        if i == 3
            dy(i) = y(i) * (alpha- y(i)) * (y(i) - 1) - y(i+1) + I + k * (y(i+2) + y(31) - 2*y(i)); % v
            dy(i+1,1) = beta * y(i,1) - gamma * y(i+1,1); % w
        elseif i == 31
            dy(i) = y(i) * (alpha - y(i)) * (y(i) - 1) - y(i+1) + I + k * (y(3) + y(i-2) - 2*y(i)); % v
            dy(i+1) = beta * y(i) - gamma * y(i+1); % w
        else
            dy(i) = y(i) * (alpha - y(i)) * (y(i) - 1) - y(i+1) + I + k * (y(i+2) + y(i-2) - 2*y(i)); % v
            dy(i+1) = beta * y(i) - gamma * y(i+1); % w
        end

    end

end
