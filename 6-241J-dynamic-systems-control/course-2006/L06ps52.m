function L06ps52(n,L,N)
    % function L06ps52(n,L,N)
    %
    % Solves 6.241/Fall 2006 PS5 problem 5.2
    % n: number of space samples,
    % L: largest frequency to sample
    % N: number of frequency samples

    if nargin<3, N = 30000; end
    if nargin<2, L = 1000; end
    if nargin<1, n = 100; end

    gg = zeros(1,n-1);  % to store actual L2 gain bounds
    g0 = zeros(1,n-1);  % to store nominal L2 gains
    fprintf('\n')

    for k = 1:n-1,
        [h,G] = L06ps52b(k,n,L,N);
        [g,gmax] = L06ps52c(G,h);
        gg(k) = g;
        g0(k) = gmax;
        fprintf('.')
    end

    fprintf('\n')
    close(gcf)
    plot((1:n-1)/n,gg,(1:n-1)/n,g0);grid
end
