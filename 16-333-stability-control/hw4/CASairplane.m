function [dx] = CASairplane(x,u)

    g = [0, 0, 9.81]';

    p = x(1:3, 1);
    v = x(4:6, 1);
    n = x(7:9, 1);

    an = u(1);
    at = u(2);
    w1 = u(3);

    e1 = v / norm(v);
    e3 = n / norm(n);
    e2 = cross(e3, e1);

    R = [e1, e2, e3];

    dp = v;
    dv = g+R*[at; 0; an];

    aux = -(R'*dv/norm(v));
    w2 = aux(3);

    dn = R*[w2; -w1; 0];

    dx = [dp; dv; dn];

end
