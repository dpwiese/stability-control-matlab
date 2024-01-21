function [g,gmax] = L06ps52c(G,h,dd)
    % function [g,gmax] = L06ps52c(G,h,dd)
    %
    % Solves 6.241/Fall 2006 PS5 problem 5.2c
    % G,h: outputs of L06ps52b
    % dd: row vector of d parameter values

    if nargin<3, dd = logspace(-4,0,50); end

    [ar,br,cr,dr] = ssdata(G);    % reduced system model
    a = [ar br zeros(3,2); 0 0 0 0 1 0;-cr 0 0 1;cr 0 0 -2];
    b = [zeros(4,2);1 0;0 0];     % constant terms in the
    c = [cr 0 0 0;zeros(1,6)];    % matrices of the "E" system
    d = zeros(2);

    em = max(real(eig(a))); % check stability of the nominal feedback
    if em> = 0,error(['a pole with re = ' num2str(em)]); end
    gmax = norm(ss(a,b,c,d),Inf);  % nominal L2 gain

    N = length(dd);                % number of d-samples
    gi = zeros(1,N);               % to keep INVERSES of gain bounds

    for k = 1:N,
        b(5:6,:) = [0  -dd(k); 0  dd(k)];  % update a,b,c,d
        c(2,5) = h/dd(k);
        d(1,2) = dd(k);
        gimin = 0;                 % minimal possible 1/gamma
        gimax = 1/gmax;            % maximal possible 1/gamma
        if norm(ss(a,b,c,d),Inf)<1,  % if not true, gamma = infinity
            while (gimax-gimin)*gmax>0.01,  % binary search for gamma
                gg = (gimax+gimin)/2;   % new test point
                b(5,1) = gg;            % updata a,b,c,d
                if norm(ss(a,b,c,d),Inf)<1, %pass/fail
                    gimin = gg;
                else
                    gimax = gg;
                end
            end
        end
        gi(k) = gg;                % lower bound for 1/gamma
    end

    g = max(gi); if g>0, g = 1/g; end
    if nargout<1, close(gcf);loglog(dd,gi);grid; end

end
