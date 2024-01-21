function dy = disturbedlorenzobserver(t, y)
    dy = zeros(5,1);

    % Use the classical values: sigma = 10, beta = 8/3, rho = 28

    dy(1,1) = 10 * rand(1,1) * (y(2,1) - y(1,1));                   % x
    dy(2,1) = 28 * rand(1,1) * y(1,1) - y(2,1) - y(1,1) * y(3,1);   % y
    dy(3,1) = -(8/3) * rand(1,1) * y(3,1) + y(1,1) * y(2,1);        % z

    dy(4,1) = 28 * (y(1,1)) - y(4,1) - (y(1,1)) * y(5,1);           % yhat
    dy(5,1) = -(8/3) * y(5,1) + (y(1,1)) * y(4,1);                  % zhat
end