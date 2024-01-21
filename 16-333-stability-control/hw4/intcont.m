function [du] = intcont(w2, w3, R, Pd, Pd_dot, Pd_ddot, Pd_dddot, p, p_dot, p_ddot, u0, K)

    an = u0(1);
    at = u0(2);

    du = [-w2/an; (w3*at)/an; w2*at] + [1, 0, 0; 0, -1/an, 0; 0, 0, 1]*R'*(Pd_dddot-K * [p-Pd; p_dot-Pd_dot; p_ddot-Pd_ddot]);

end
