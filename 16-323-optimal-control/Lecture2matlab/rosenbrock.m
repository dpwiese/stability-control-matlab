function [y, g, h] = rosenbrock(x)

    % If x is wide instead of tall, transpose

    if size(x,1) == 2 && size(x,2) ~=  2
        x = x';
    end

    % Value of function

    y = (1-x(:,1)).^2 + 100*(x(:,2)-x(:,1).^2).^2;

    % Gradient

    if nargout >= 2
        g = [-2*(1-x(:,1)) - 400 * x(:,1) .* (x(:,2)-x(:,1).^2), 200 * (x(:,2)-x(:,1).^2)];
    end

    % Hessian

    if nargout >= 3
        h = zeros(2,2);
        h(1,1) = 2 - 400*x(2) + 1200*x(1)^2;
        h(1,2) = -400*x(1);
        h(2,1) = h(1,2);
        h(2,2) = 200;
    end

end