function [geo, xyz, XYZ] = mass_prop(geo, xyz)

    % qc - quarter chord

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calculate mass of wing, horizontal tail, and vertical tail: add together with tip mass to get total airplane mass
    geo.wing.m = geo.dens.bal*geo.wing.S;
    geo.htai.m = geo.dens.bal*geo.htai.S;
    geo.vtai.m = geo.dens.bal*geo.vtai.S;
    geo.totl.m = geo.wing.m+geo.htai.m+geo.vtai.m+geo.tipm.m;

    % Calculate distances to surfaces relative to coordinates xyz at tip
    % Distance in x-direction
    xyz.wing.xdcg = xyz.wing.xdle-0.5*geo.wing.c;
    xyz.htai.xdcg = xyz.htai.xdle-0.5*geo.htai.c;
    xyz.vtai.xdcg = xyz.vtai.xdle-0.5*geo.vtai.c;
    xyz.tipm.xdcg = 0;

    % Distance in z-direction
    xyz.vtai.zdcg = -0.5*geo.vtai.h;

    % Calculate CG location wrt to coordinates xyz at airplane tip
    xyz.cg.x = ((xyz.wing.xdcg*geo.wing.m)+(xyz.htai.xdcg*geo.htai.m)+(xyz.vtai.xdcg*geo.vtai.m)+(xyz.tipm.xdcg*geo.tipm.m)) / geo.totl.m;
    xyz.cg.y = 0;
    xyz.cg.z = (xyz.vtai.zdcg*geo.vtai.m) / geo.totl.m;
    xyz.cg.totl = [xyz.cg.x, xyz.cg.y, xyz.cg.z];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Calculate distances to surfaces relative to coordinates XYZ at CG
    XYZ.cg.totl=[0, 0, 0];

    % X distances
    % Tip mass
    XYZ.tipm.xdcg=-xyz.cg.x;

    % Wing
    XYZ.wing.xdle = XYZ.tipm.xdcg+xyz.wing.xdle;
    XYZ.wing.xdqc = XYZ.wing.xdle-0.25*geo.wing.c;
    XYZ.wing.xdcg = XYZ.wing.xdle-0.5*geo.wing.c;

    % Horizontal tail
    XYZ.htai.xdle = XYZ.tipm.xdcg+xyz.htai.xdle;
    XYZ.htai.xdqc = XYZ.htai.xdle-0.25*geo.htai.c;
    XYZ.htai.xdcg = XYZ.htai.xdle-0.5*geo.htai.c;

    % Vertical tail
    XYZ.vtai.xdle = XYZ.tipm.xdcg+xyz.vtai.xdle;
    XYZ.vtai.xdqc = XYZ.vtai.xdle-0.25*geo.vtai.c;
    XYZ.vtai.xdcg = XYZ.vtai.xdle-0.5*geo.vtai.c;

    % Y distances: all zero

    % Z distances
    XYZ.tipm.zdcg = -xyz.cg.z;
    XYZ.wing.zdcg = -xyz.cg.z;
    XYZ.htai.zdcg = -xyz.cg.z;
    XYZ.vtai.zdcg = xyz.vtai.zdcg-xyz.cg.z;

    % Radial vectors from cg to aerodynamics surface quarter chords
    XYZ.wing.rqc = [XYZ.wing.xdqc, 0, XYZ.wing.zdcg];
    XYZ.htai.rqc = [XYZ.htai.xdqc, 0, XYZ.htai.zdcg];
    XYZ.vtai.rqc = [XYZ.vtai.xdqc, 0, XYZ.vtai.zdcg];

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    % Distances are from CG to plate

    J_XX_wing = (1/12)*geo.wing.m*geo.wing.b^2+geo.wing.m*(XYZ.wing.zdcg)^2;
    J_XX_htai = (1/12)*geo.htai.m*geo.htai.b^2+geo.htai.m*(XYZ.htai.zdcg)^2;
    J_XX_vtai = (1/12)*geo.vtai.m*geo.vtai.h^2+geo.vtai.m*(XYZ.vtai.zdcg)^2;
    J_XX_mtip = geo.tipm.m*(XYZ.tipm.zdcg)^2;
    JXX = J_XX_wing + J_XX_htai + J_XX_vtai + J_XX_mtip;

    J_YY_wing = (1/12)*geo.wing.m*geo.wing.c^2+geo.wing.m*((XYZ.wing.xdcg)^2+(XYZ.wing.zdcg)^2);
    J_YY_htai = (1/12)*geo.htai.m*geo.htai.c^2+geo.htai.m*((XYZ.htai.xdcg)^2+(XYZ.htai.zdcg)^2);
    J_YY_vtai = (1/12)*geo.vtai.m*(geo.vtai.c^2+geo.vtai.h^2)+geo.vtai.m*((XYZ.vtai.xdcg)^2+(XYZ.vtai.zdcg)^2);
    J_YY_mtip = geo.tipm.m*((XYZ.tipm.xdcg)^2+(XYZ.tipm.zdcg)^2);
    JYY = J_YY_wing + J_YY_htai + J_YY_vtai + J_YY_mtip;

    J_ZZ_wing = (1/12)*geo.wing.m*(geo.wing.c^2+geo.wing.b^2)+geo.wing.m*(XYZ.wing.xdcg)^2;
    J_ZZ_htai = (1/12)*geo.htai.m*(geo.htai.c^2+geo.htai.b^2)+geo.htai.m*(XYZ.htai.xdcg)^2;
    J_ZZ_vtai = (1/12)*geo.vtai.m*geo.vtai.c^2+geo.vtai.m*(XYZ.vtai.xdcg)^2;
    J_ZZ_mtip = geo.tipm.m*(XYZ.tipm.xdcg)^2;
    JZZ = J_ZZ_wing + J_ZZ_htai + J_ZZ_vtai + J_ZZ_mtip;

    J_xy_wing = 0;
    J_xy_htai = 0;
    J_xy_vtai = 0;
    J_xy_mtip = 0;
    Jxy = J_xy_wing + J_xy_htai + J_xy_vtai + J_xy_mtip;
    Jyx = Jxy;

    J_xz_wing = geo.wing.m*(XYZ.wing.xdcg)*(XYZ.wing.zdcg);
    J_xz_htai = geo.htai.m*(XYZ.htai.xdcg)*(XYZ.htai.zdcg);
    J_xz_vtai = geo.vtai.m*(XYZ.vtai.xdcg)*(XYZ.vtai.zdcg);
    J_xz_mtip = geo.tipm.m*(XYZ.tipm.xdcg)*(XYZ.tipm.zdcg);
    Jxz = J_xz_wing+J_xz_htai+J_xz_vtai+J_xz_mtip;

    %CHECK THIS
    Jxz = -Jxz;
    Jzx = Jxz;

    J_yz_wing = 0;
    J_yz_htai = 0;
    J_yz_vtai = 0;
    J_yz_mtip = 0;
    Jyz = J_yz_wing + J_yz_htai + J_yz_vtai + J_yz_mtip;
    Jzy = Jyz;

    geo.totl.J = [  JXX, Jxy, Jxz;
                    Jyx, JYY, Jyz;
                    Jzx, Jzy, JZZ];

end
