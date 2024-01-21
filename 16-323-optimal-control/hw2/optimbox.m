function [x, fval, exitflag, output, grad, hessian] = optimbox(x0, PrecondBandWidth_Data)
    %% This is an auto generated MATLAB file from Optimization Tool.

    %% Start with the default options
    options = optimset;

    %% Modify options setting
    options = optimset(options,'Display', 'off');
    options = optimset(options,'PlotFcns', { @optimplotx @optimplotfval @optimplotfirstorderopt });
    options = optimset(options,'GradObj', 'on');
    options = optimset(options,'Hessian', 'off');
    options = optimset(options,'PrecondBandWidth', PrecondBandWidth_Data);
    [x, fval, exitflag, output, grad, hessian] = fminunc(@pendulum_b, x0, options);

end
