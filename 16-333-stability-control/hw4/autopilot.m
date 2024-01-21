function u = autopilot(x, u0, Pd, Pd_dot, Pd_ddot, Pd_dddot, p_ddot, K, T, i)

    p       = x(1:3, 1);
    p_dot   = x(4:6, 1);
    n       = x(7:9, 1);

    an = u0(1);
    at = u0(2);
    w1 = u0(3);

    e1 = p_dot / norm(p_dot);
    e3 = n / norm(n);
    e2 = cross(e3, e1);

    R = [e1, e2, e3];

    % Calculate w2 and w3 from page 8 lecture notes
    V = norm(p_dot);
    temp = R' * Pd_ddot;

    w3 = temp(2) / V;
    w2 = -temp(3) / V;

    % Set up ODE to solve for u from page 9 lecture notes
    U0 = [at w1 an];

    [~,utemp] = ode45(@(t,u)intcont(w2, w3, R, Pd, Pd_dot, Pd_ddot, Pd_dddot, p, p_dot, p_ddot, u0, K), [T(i), T(i+1)], U0);

    gw1 = [-w2/an; (w3*at)/an; w2*at]+[1, 0, 0; 0, -1/an, 0; 0, 0, 1]*R'*(Pd_dddot-K*[p-Pd; p_dot-Pd_dot; p_ddot-Pd_ddot]);

    u = [utemp(end,3), utemp(end,1), gw1(2)];

end
