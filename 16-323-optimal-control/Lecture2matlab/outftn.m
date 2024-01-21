function stop = outftn(x, optimValues, state)
    % function stop = outftn(x, optimValues, state)
    % Function to store path of optimization for later plotting

    global xpath

    xpath = [xpath ; x'];
    stop = 0;

    return

end
