function dy = noisylorenzobserver(t, y)
    dy = zeros(5,1);

    % Use the classical values: sigma = 10, beta = 8/3, rho = 28

    dy(1,1) = 10 * (y(2,1) - y(1,1));                   % x
    dy(2,1) = 28 * y(1,1) - y(2,1) - y(1,1) * y(3,1);   % y
    dy(3,1) = -(8/3) * y(3,1) + y(1,1) * y(2,1);        % z

    % Measurement of x is off from 0 to +1 due to noise
    randnum = rand(1,1);
    dy(4,1) = 28 * (y(1,1) + randnum-.5) - y(4,1) - (y(1,1) + randnum-.5) * y(5,1); % yhat
    dy(5,1) = -(8/3) * y(5,1) + (y(1,1) + randnum-.5) * y(4,1);                     % zhat
end
