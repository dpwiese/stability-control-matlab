function L06ps23(n)
    % function L06ps23(n)
    %
    % MATLAB code for 6.241/Fall 2006 PS2, problem 3(e)

    if nargin<1, n = 5; end        % default dimension
    L0i = randn(n);                % generate random data
    L0i = L0i/(sqrt(n+abs(randn))*norm(L0i)); % normalize
    L0 = inv(L0i);
    B = randn(n,1);
    C = randn(1,n);
    CL0iB = C*L0i*B;               % derived matrices
    E0 = [1 zeros(1,n)];
    E1 = [B -L0];
    F0 = [-CL0iB C];
    F1 = [zeros(n,1) eye(n)];
    abst_init_lmi                % begin LMI description
    D = diagonal(n);               % matrix of di's
    r = symmetric;
    d = symmetric;
    D>0;
    d>trace(D);
    E0'*r*E0+E1'*D*E1-F0'*F0-(F1'*F1)*d>0;
    lmitbx_options([0 0 0 0 1]);
    lmi_mincx_tbx(r);
    fprintf('\n accurate bound: %f',sqrt(value(r)))
    abst_init_lmi                % new LMI description
    d = symmetric;               % matrix of di's
    r = symmetric;
    d>0;
    E0'*r*E0+E1'*d*E1-F0'*F0-(n*F1'*F1)*d>0;
    lmi_mincx_tbx(r);
    fprintf('\n relaxed bound: %f\n',sqrt(value(r)))

end
