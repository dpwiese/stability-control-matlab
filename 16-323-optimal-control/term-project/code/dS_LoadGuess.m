%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_LoadGuess.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
%DYNAMIC SOARING: LOAD A SOLUTION GUESS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [xguess,yguess,zguess,vguess, gammaguess, psiguess, phiguess] = dS_LoadGuess(N)

    % %Saved guess file, works for any trajectory
    load('guess.mat','solution')

    x       = solution.phase(1).state(:,1);
    y       = solution.phase(1).state(:,2);
    z       = solution.phase(1).state(:,3);
    V       = solution.phase(1).state(:,4);
    gamma   = solution.phase(1).state(:,5);
    psi     = solution.phase(1).state(:,6);
    phi     = solution.phase(1).state(:,7);
    CLa     = solution.phase(1).state(:,8);

    xguess      = imresize(x, [N 1], 'nearest');
    yguess      = imresize(y, [N 1], 'nearest');
    zguess      = imresize(z, [N 1], 'nearest');
    vguess      = imresize(V, [N 1], 'nearest');
    gammaguess  = imresize(gamma, [N 1], 'nearest');
    psiguess    = imresize(psi, [N 1], 'nearest');
    phiguess    = imresize(phi, [N 1], 'nearest');

    xguess = smooth(xguess);
    yguess = smooth(yguess);
    zguess = smooth(zguess);

end
