function rd = L06ps12float(n)
    % function rd = L06ps12float(n)
    %
    % numerical rank calculations for 6.241/F2006 PS1.2

    L = zeros(n);
    for k = 1:n,
        for i = 1:k-1,
            L(k,i) = nchoosek(k-1,i-1);
        end
        L(k,n-k+1) = L(k,n-k+1)-1;
    end
    rd = n-rank(L);

end
