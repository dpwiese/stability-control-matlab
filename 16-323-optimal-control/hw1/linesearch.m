%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 16.323 - HW #1
%---------------------------------------------------------------------------------------------------
% Linesearch
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [alpha, xk1, fk1, gk1, NFinc] = linesearch(fhand, xk, dk)

    NFinc = 0;
    % global nf
    % nf=nf+1;
    %-----------------------------------------------------------------------------------------------
    %Preliminary stuff and constants
    c1 = 0.00001;
    c2 = 0.9;
    delta = 10;
    wolfecountermax = 10;
    endnow = 0;
    wolfe = 0;
    jj = 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    while endnow == 0 && wolfe == 0;
        % BRACKETING
        % Preallocate stuff for bracketing procedure
        clearvars a fxk
        [fxk, ~] = fhand(xk);
        a(1) = 0;
        delta = delta * 1 * abs(rand^(1/2));
        % disp(delta)
        foundbracket = 0;
        fa = fxk;
        ii = 1;
        % Go along alpha taking Delta steps until a bracket is found
        while foundbracket == 0;
        Delta = delta*2^(ii-1);
        a(ii+1) = a(ii) + Delta;
        [fap1, ~] = fhand(xk+a(ii+1)*dk);
            if fap1<=fa
                foundbracket = 0;
            else
                if ii == 1
                    lambdal = a(ii);
                    lambdau = a(ii+1);
                else
                    lambdal = a(ii-1);
                    lambdau = a(ii+1);
                end
                foundbracket = 1;
            end
        ii = ii + 1;
        fa = fap1;
        end
        % nf=nf+1;

        %-------------------------------------------------------------------------------------------
        % BISECTION SEARCH

        % Pick a point in middle of bracket
        alpha = (lambdal+lambdau)/2;

        % Preallocate for bisection search
        wolfecounter = 0;
        armijo = 0;
        curvature = 0;

        % Iterate the bisection until wolfe conditions are met, or it reaches max tries
        while armijo == 0 && curvature == 0 && wolfecounter<wolfecountermax;
        % Evaluate the gradient at the middle point
        [~, gk] = fhand(xk+alpha*dk);
            % If slope is positive, minimum is left of the middle point
            if gk'*dk>0
                lambdau = alpha;
                alphanew = (lambdal + lambdau) / 2;
            % If slope is negative, minimum is right of the middle point
            elseif gk'*dk<0
                lambdal = alpha;
                alphanew = (lambdal+lambdau) / 2;
            % If slope is zero, we have found stationary point
            elseif gk'*dk==0
                alphanew=(lambdal+lambdau) / 2;
                endnow=1;
            end
            [fkpadk,gkpadk]=fhand(xk+alphanew*dk);
            alpha=alphanew;
            % Armijo Condition
            if fkpadk>fxk+c1*alpha*dk'*gk;
                armijo=0;
            else
                armijo=1;
            end
            % Curvature Condition
            if c2*dk'*gk>dk'*gkpadk
                curvature = 0;
            else
                curvature = 1;
            end
            wolfecounter = wolfecounter + 1;
        end
        % nf=nf+1;
        if armijo == 1 && curvature == 1
            wolfe=1;
        else
            wolfe=0;
        end
        jj = jj + 1;
    end

    % disp(armijo)
    % disp(curvature)

    %-----------------------------------------------------------------------------------------------

    fk1 = fkpadk;
    gk1 = gkpadk;
    xk1 = xk+alpha*dk;

end
