function [x, fval, exitflag, output, grad, hessian] = optimize_thing(x0)
    %% This is an auto generated MATLAB file from Optimization Tool.

    %% Start with the default options
    options = optimoptions('fminunc');

    %% Modify options setting
    options = optimoptions(options,'Display', 'off');
    options = optimoptions(options,'Algorithm', 'quasi-newton');
    options = optimoptions(options,'GradObj', 'on');
    options = optimoptions(options,'Hessian', 'off');
    [x, fval, exitflag, output, grad, hessian] = fminunc(@costgrad, x0, options);

end
