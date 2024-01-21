%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152 HW #3 Problem 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [sys, x0, str, ts] = plant_sfcn(t, x, u, flag, startpt)

    % t - time
    % x - state (column vector)
    % u - input (column vector)
    % flag - 0,1,2,3,4,9
    % Other additional supplied parameters could come following flag (such as
    % initial conditions or something)
    % sys - main vector of results requested by simulink. Depending on which
    % flag was sent by simulink, this vector will hold different information

    switch flag,

        %%%%%%%%%%%%%%%%%%
        % Initialization %
        %%%%%%%%%%%%%%%%%%
        case 0,
            [sys, x0, str, ts] = mdlInitializeSizes(startpt);

        %%%%%%%%%%%%%%%
        % Derivatives %
        %%%%%%%%%%%%%%%
        case 1,
            sys = mdlDerivatives(t, x, u);

        %%%%%%%%%%%
        % Outputs %
        %%%%%%%%%%%
        case 3,
            sys = mdlOutputs(t, x, u);

        %%%%%%%%%%%%%%%%%%%
        % Unhandled flags %
        %%%%%%%%%%%%%%%%%%%
        case { 2, 4, 9 },
            sys = [];

        %%%%%%%%%%%%%%%%%%%%
        % Unexpected flags %
        %%%%%%%%%%%%%%%%%%%%
        otherwise
            DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));

    end

end

%=============================================================================
% mdlInitializeSizes
% Return the sizes, initial conditions, and sample times for the S-function.
%=============================================================================

function [sys, x0, str, ts] = mdlInitializeSizes(startpt)

    % Initialization
    sizes = simsizes;
    sizes.NumContStates  = 2;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 2;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;

    sys = simsizes(sizes);
    x0  = startpt;
    str = [];
    ts  = [0, 0];

end

%=============================================================================
% mdlDerivatives
% Return the derivatives for the continuous states.
%=============================================================================

function sys = mdlDerivatives(t, x, u)

    sys = hw3_eom(t, x, u);

end

%=============================================================================
% mdlOutputs
% Return the block outputs.
%=============================================================================

function sys = mdlOutputs(t, x, u)

    sys = x;

end
