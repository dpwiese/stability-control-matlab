function varargout = asinh(varargin)
%ASINH (overloaded)

% Author Johan L�fberg
% $Id: asinh.m,v 1.5 2008-09-05 07:29:15 joloef Exp $
switch class(varargin{1})

    case 'double'
        error('Overloaded SDPVAR/ASIN CALLED WITH DOUBLE. Report error')

    case 'sdpvar'
        varargout{1} = InstantiateElementWise(mfilename,varargin{:});

    case 'char'

        operator = struct('convexity','none','monotonicity','increasing','definiteness','none','model','callback');
        operator.convexhull = [];
        operator.bounds = @bounds;
        operator.derivative = @(x)((1 + x.^2).^-0.5);

        varargout{1} = [];
        varargout{2} = operator;
        varargout{3} = varargin{3};

    otherwise
        error('SDPVAR/ASINH called with CHAR argument?');
end

function [L,U] = bounds(xL,xU)
L = asinh(xL);
U = asinh(xU);