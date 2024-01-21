function tbxStruct  = demos

% DEMOS Demo list for the Aircraft Library.

% Version 1.9 (R11.1,R13)
% Giampiero Campa
% 29-Feb-2004

if nargout == 0, demo blockset; return; end

tbxStruct.Name='Aircraft Library';
tbxStruct.Type='Blockset';

tbxStruct.Help={
   'Airlib is a library of aircraft models to be '
   'used with Simulink 3.1 (Matlab 5.3) or later.'
};

 tbxStruct.DemoList = { ' Aircraft Library',  'airlib'; ...
                        ' Aircraft Models',  'airlibex'; ...
                        ' General Controller',  'airgk'; ...
                        ' Wind Handling',  'fdcwind'; ...
                        ' Boeing 747',  'B747cl'};
