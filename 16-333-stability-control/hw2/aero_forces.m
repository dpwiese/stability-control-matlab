function [fB, tauB, vel, aer] = aero_forces(geo, XYZ, xihat_b, aer)

    vel.totl    = [xihat_b(1,4) xihat_b(2,4) xihat_b(3,4)];
    vel.u       = vel.totl(1);
    vel.v       = vel.totl(2);
    vel.w       = vel.totl(3);
    vel.omega   = hat(xihat_b(1:3,1:3));
    vel.p       = vel.omega(1);
    vel.q       = vel.omega(2);
    vel.r       = vel.omega(3);
    vel.VT      = norm(vel.totl);
    vel.alpha   = atan2(vel.w,vel.u);
    vel.beta    = asin(vel.v/vel.VT);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % LONGITUDINAL DYNAMICS

    % Calculate effective uvw velocity components at wing (in body axes, NOT including surface deflections)
    vel.wing.totl   = vel.totl+cross(vel.omega,XYZ.wing.rqc);
    vel.wing.u      = vel.wing.totl(1);
    vel.wing.v      = vel.wing.totl(2);
    vel.wing.w      = vel.wing.totl(3);
    vel.wing.VT     = norm(vel.wing.totl);
    vel.wing.alpha  = atan2(vel.wing.w,vel.wing.u);
    vel.wing.beta   = asin(vel.wing.v/vel.wing.VT);

    % Calculate effective uvw velocity components at horizontal tail (in body axes, including surface deflections)
    vel.htai.totl   = vel.totl+cross(vel.omega,XYZ.htai.rqc);
    vel.htai.u      = vel.htai.totl(1);
    vel.htai.v      = vel.htai.totl(2);
    vel.htai.w      = vel.htai.totl(3);
    vel.htai.VT     = norm(vel.htai.totl);
    vel.htai.alpha  = atan2(vel.htai.w,vel.htai.u)+aer.delt.e;
    vel.htai.beta   = asin(vel.htai.v/vel.htai.VT);

    % Calculate lift coefficient and total lift force for wing
    aer.wing.CL = (pi*geo.wing.AR*vel.wing.alpha)/(1+sqrt(1+(geo.wing.AR/2)^2));
    aer.wing.L  = 0.5*geo.dens.air*(vel.wing.VT^2)*geo.wing.S*aer.wing.CL;

    % Calculate lift coefficient and total lift force for horizontal tail
    aer.htai.CL = (pi*geo.htai.AR*(vel.htai.alpha))/(1+sqrt(1+(geo.htai.AR/2)^2));
    aer.htai.L  = 0.5*geo.dens.air*(vel.htai.VT^2)*geo.htai.S*aer.htai.CL;

    % Calculate drag coefficient and total drag force for wing
    aer.wing.CD = (aer.wing.CL^2)/(pi*geo.wing.AR*aer.wing.e);
    aer.wing.D  = 0.5*geo.dens.air*(vel.wing.VT^2)*geo.wing.S*aer.wing.CD;

    % Calculate drag coefficient and total drag force for horizontal tail
    aer.htai.CD = (aer.htai.CL^2)/(pi*geo.htai.AR*aer.htai.e);
    aer.htai.D  = 0.5*geo.dens.air*(vel.htai.VT^2)*geo.htai.S*aer.htai.CD;

    % Calculate X components of lift and drag for wing
    aer.wing.FXL = aer.wing.L*sin(vel.alpha);
    aer.wing.FXD = -aer.wing.D*cos(vel.alpha);

    % Calculate X components of lift and drag for horizontal tail
    aer.htai.FXL = aer.htai.L*sin(vel.alpha);
    aer.htai.FXD = -aer.htai.D*cos(vel.alpha);

    % Calculate Z components of lift and drag for wing
    aer.wing.FZL = -aer.wing.L*cos(vel.alpha);
    aer.wing.FZD = -aer.wing.D*sin(vel.alpha);

    % Calculate Z components of lift and drag for horizontal tail
    aer.htai.FZL = -aer.htai.L*cos(vel.alpha);
    aer.htai.FZD = -aer.htai.D*sin(vel.alpha);

    % Calculate moment MY about Y-axis due to wing and horizontal tail force components FZ_ and FX_
    aer.wing.MYL = aer.wing.FZL*XYZ.wing.xdqc+aer.wing.FXL*XYZ.wing.zdcg;
    aer.wing.MYD = aer.wing.FZD*XYZ.wing.xdqc+aer.wing.FXD*XYZ.wing.zdcg;
    aer.htai.MYL = -aer.htai.FZL*XYZ.htai.xdqc+aer.htai.FXL*XYZ.htai.zdcg;
    aer.htai.MYD = -aer.htai.FZD*XYZ.htai.xdqc+aer.htai.FXD*XYZ.htai.zdcg;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % LATERAL DYNAMICS

    % Calculate effective uvw velocity components at vertical tail (in body axes, including surface deflections)
    vel.vtai.totl   = vel.totl+cross(vel.omega,XYZ.vtai.rqc);
    vel.vtai.u      = vel.vtai.totl(1);
    vel.vtai.v      = vel.vtai.totl(2);
    vel.vtai.w      = vel.vtai.totl(3);
    vel.vtai.VT     = norm(vel.vtai.totl);
    vel.vtai.alpha  = asin(vel.vtai.v/vel.vtai.VT)-aer.delt.r;

    % Calculate lift coefficient and lift force for vertical tail
    aer.vtai.CL     = (pi*geo.vtai.AR*vel.vtai.alpha)/(1+sqrt(1+(geo.vtai.AR/2)^2));
    aer.vtai.L      = 0.5*geo.dens.air*vel.vtai.VT^2*geo.vtai.S*aer.vtai.CL;

    % Calculate drag coefficient and drag and drag force for vertical tail
    aer.vtai.CD     = (aer.vtai.CL^2)/(pi*geo.vtai.AR*aer.vtai.e);
    aer.vtai.D      = 0.5*geo.dens.air*(vel.vtai.VT^2)*geo.vtai.S*aer.vtai.CD;

    % Calculate X components of lift and drag for vertical tail
    aer.vtai.FXL    = aer.vtai.L*sin(vel.vtai.alpha);
    aer.vtai.FXD    = -aer.vtai.D*cos(vel.vtai.alpha);

    % Calculate Y components of lift and drag for vertical tail
    aer.vtai.FYL    = -aer.vtai.L*cos(vel.vtai.alpha);
    aer.vtai.FYD    = -aer.vtai.D*cos(vel.vtai.alpha);

    % Calculate moment about X-axis: MX
    aer.wing.dCL    = (pi*geo.wing.AR*aer.delt.a)/(1+sqrt(1+(geo.wing.AR/2)^2));
    aer.wing.MX     = (0.5*geo.dens.air*vel.wing.VT^2*geo.wing.S*aer.wing.dCL*0.5*geo.wing.b); % *sign(aer.delt.a);

    % Calculate moment about Z-axis: MZ
    aer.vtai.MZ     = aer.vtai.FYL*XYZ.vtai.xdqc+aer.vtai.FYD*XYZ.vtai.xdqc;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % DAMPING

    aer.damp.MX = -0.01*vel.omega(1);
    aer.damp.MY = -0.1*vel.omega(2);
    aer.damp.MZ = -0.01*vel.omega(3);

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % SUM TOTALS

    aer.totl.FX = aer.wing.FXL+aer.wing.FXD+aer.htai.FXL+aer.htai.FXD;
    aer.totl.FY = aer.vtai.FYL+aer.vtai.FYD;
    aer.totl.FZ = aer.wing.FZL+aer.wing.FZD+aer.htai.FZL+aer.htai.FZD;

    aer.totl.MX = aer.wing.MX;
    aer.totl.MY = aer.wing.MYL+aer.wing.MYD+aer.htai.MYL+aer.htai.MYD;
    aer.totl.MZ = aer.vtai.MZ;

    % OUTPUTS
    fB   = [aer.totl.FX, aer.totl.FY, aer.totl.FZ];
    tauB = [aer.totl.MX, aer.totl.MY, aer.totl.MZ];

end
