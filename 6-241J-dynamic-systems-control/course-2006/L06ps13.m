function rd = L06ps13(n)
    % function rd = L06ps13(n)
    %
    % numerical calculations for 6.241/F2006 PS1.3c

    if nargin<1, n = 10; end
    F = zeros(n,1);
    R = zeros(n);
    for k = 1:n,
        F(k) = -(n-k-1/2)/n^2;
        R(k,k) = 1/n+(n-k-1/3)/n^3;
        for i = 1:(k-1),
            R(k,i) = -F(k)/n;
            R(i,k) = R(k,i);
        end
    end
    u = inv(R)*F;            % optimal u
    u = [u';u']; u = u(:);     % prepare for nice plotting
    t = [(0:n-1)/n;(1:n)/n]; t = t(:);

    t0 = linspace(0,1,500)';
    u0 = (exp(t0-1)-exp(1-t0))/(exp(1)+exp(-1));
    close(gcf)
    plot(t0,u0,t,u)

end
