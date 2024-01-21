%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Daniel Wiese
% 2.152
% Fitz-Hugh Nagumo
%---------------------------------------------------------------------------------------------------
% The system has 15 oscillators which wrap around so the ends touch. That is, the neighbor of i=15
% is i=1.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function out = fitzhugh_equations(t, in)

    % Take v and w from the input
    vin = in(1:15);
    win = in(16:30);

    % Preallocate the output
    vout = zeros(15, 1);
    wout = zeros(15, 1);

    % Plant parameters
    alpha = 6;
    beta = 3;
    gamma = 0.09;
    k = 25;

    % Part a
    % I=5*ones(15,1);

    % Part b
    for i = 1:10
        I(i) = 5;
    end

    for i = 11:15
        I(i) = 7;
    end

    % Loop through all of the oscillators
    for i = 1
        vout(i) = vin(i)*(alpha-vin(i))*(vin(i)-1)-win(i)+I(i)+k*(vin(i+1)-vin(i))+k*(vin(15)-vin(i));
        wout(i) = beta*vin(i)-gamma*win(i);
    end

    for i = 2:14
        vout(i) = vin(i)*(alpha-vin(i))*(vin(i)-1)-win(i)+I(i)+k*(vin(i+1)-vin(i))+k*(vin(i-1)-vin(i));
        wout(i) = beta*vin(i)-gamma*win(i);
    end

    for i = 15
        vout(i) = vin(i)*(alpha-vin(i))*(vin(i)-1)-win(i)+I(i)+k*(vin(1)-vin(i))+k*(vin(i-1)-vin(i));
        wout(i) = beta*vin(i)-gamma*win(i);
    end

    % Output
    out = [vout; wout];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
