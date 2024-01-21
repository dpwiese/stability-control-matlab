function L06ps43(a, n)
    % function L06ps43(a,n)
    %
    % simulation for 6.241/Fall 2006 PS Problem 4.3

    if nargin<2, n = 100; end   % default parameters
    if nargin<1, a = 0.5; end
    m = round(a*n);             % make sure a is meaningful
    a = m/n;
    if m<1, m = 1; end
    if m>n, m = n; end
    dd = 0.05;                  % real part offset parameter
                              % define matrices
    aa = toeplitz([-1-8*n^2;4*n^2;zeros(n-2,1)],[-1-8*n^2 4*n^2 zeros(1,n-2)]);
    aa(n,n-1:n) = [0 0];
    A = [zeros(n) eye(n);aa zeros(n)];
    B = [zeros(2*n-1,1);1];
    C = [zeros(1,m-1) 1 zeros(1,2*n-m)];
    w = linspace(0.5,10,1000);    % frequency samples
    s = dd+j*w;                % use real part offset to avoid the poles
    th = sqrt(1+s.^2)/2;
    ga = (exp(th*a)-exp(-th*a))./((s.^2).*(exp(th)-exp(-th))); % analytical tf
    gn = squeeze(freqresp(ss(A-dd*eye(2*n),B,C,0),w)); % numerical tf
    t = linspace(0,1,1000);     % time samples
    st = squeeze(step(ss(A,B,C,0),t));  % numerical step response

    close(gcf)
    subplot(2,1,1); plot(w,real(ga),'red',w,real(gn),'blue'); grid;
    subplot(2,1,2); plot(w,imag(ga),'red',w,imag(gn),'blue'); grid;
    pause
    close(gcf)
    plot(t,st); grid

    end
