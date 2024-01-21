%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #1
%---------------------------------------------------------------------------------------------------
% Objective function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [f, g] = functionpart2_objective(x)

    global nf

    nf = nf + 1;

    x1 = x(1);
    x2 = x(2);

    if nargout == 1
        f = x1^4 + 100 * x2^4;
    elseif nargout == 2
        f = x1^4 + 100 * x2^4;
        dfdx1 = 4 * x1^3;
        dfdx2 = 400 * x2^3;
        g = [dfdx1, dfdx2]';
    else
        error('how many output arguements are you using?')
    end

end
