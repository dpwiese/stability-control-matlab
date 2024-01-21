function [er, Gr] = L06ps52b(m, n, L, N)
    % function [er,Gr] = L06ps52b(m,n,L,N)
    %
    % Solves 6.241/Fall 2006 PS5 problem 5.2b
    % n: number of space samples,
    % m: output sample
    % L: largest frequency to sample
    % N: number of frequency samples

    if nargin<4, N = 30000; end
    if nargin<3, L = 1000; end
    if nargin<2, n = 100; end
    if nargin<1, m = round(n/2); end


    A = toeplitz([-2*n^2;n^2;zeros(n-3,1)],[-2*n^2 n^2 zeros(1,n-3)]);
    B = [zeros(n-2,1);n^2];            % state space matrices
    C = zeros(1,n-1); C(m) = 1;
    x = m/n;

    G0 = ss(A,B,C,0);
    Gr = reduce(G0,3);                 % reduced model
    w = linspace(0.001,L,N)';          % frequency samples column
    s12 = sqrt(j*w);                   % sqrt(jw) samples
    gd = exp(s12)-exp(-s12);           % denominator of the TF
    gr = squeeze(freqresp(Gr,w));      % reduced model response
    ga = (exp(x*s12)-exp(-x*s12))./gd; % analytical response
    er = max(abs(ga-gr));

    if nargout<2,
        close(gcf)
        subplot(3,1,1);plot(w,real(ga),w,real(gr));grid
        subplot(3,1,2);plot(w,imag(ga),w,imag(gr));grid
        subplot(3,1,3);plot(w,abs(ga-gr)); grid
    end

end
