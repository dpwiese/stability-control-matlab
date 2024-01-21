%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Dan Wiese
% 16.323 - Term Project
% dS_FileNamer.m
% Friday 09-May-2014
%-----------------------------------------------------------------------------------
%DYNAMIC SOARING: CREATE THE NAME WITH TIMESTAMP TO SAVE DATA
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function solname = dS_FileNamer

    thetime = clock;
    year    = thetime(1);
    month   = thetime(2);
    date    = thetime(3);
    hour    = thetime(4);
    minute  = thetime(5);
    second  = thetime(6);

    year    = sprintf('%04d',year);
    month   = sprintf('%02d',month);
    date    = sprintf('%02d',date);
    hour    = sprintf('%02d',hour);
    minute  = sprintf('%02d',minute);
    second  = sprintf('%02d',round(second));

    solname = strcat('sol_',year,month,date,'_',hour,minute,second,'.mat');

end
