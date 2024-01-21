function varargout=quadratic_over_affine(varargin)
%quadratic_over_affine (overloaded)

% Author Johan L�fberg
% $Id: quadratic_over_affine.m,v 1.28 2008-11-11 13:29:20 joloef Exp $

switch class(varargin{1})
    case 'double'
        varargout{1} = varargin{1}/varargin{2};

    case 'sdpvar' % Overloaded operator for SDPVAR objects. Pass on args and save them.        
        if is(varargin{1},'quadratic') & ~is(varargin{1},'linear') & is(varargin{2},'linear')            
            p = varargin{1};
            [Q,c,f,x,info] = quaddecomp(p);
            q = chol(Q)*x;
            varargin{1} = q;            
            varargout{1} = yalmip('define',mfilename,varargin{:});       
        else
            error('First argument should be quadratic and second affine')
        end
        
    case 'char' % YALMIP send 'graph' when it wants the epigraph or hypograph
        switch varargin{1}
            case 'graph'
                % Description using epigraphs
                t = varargin{2};
                q = varargin{3};
                y = varargin{4};
                %[M,m] = derivebounds(y);
                %if m<0
                %    varargout{1} = [];
                %    varargout{2} = [];
                %    varargout{3} = [];
                %else
                    varargout{1} = [cone([2*q;t-y],t+y)];
                    varargout{2} = struct('convexity','convex','monotonicity','none','definiteness','positive','model','graph');
                    varargout{3} = [q;y];
                %end
            case {'exact','integer','callback'}
                
                t = varargin{2};
                q = varargin{3};
                y = varargin{4};
                varargout{1} = [];
                varargout{2} = struct('convexity','none','monotonicity','none','definiteness','positive','model','callback');
                varargout{3} = [q;y];

            otherwise
                error('SDPVAR/ABS called with CHAR argument?');
        end
    otherwise
        error('Strange type on first argument in SDPVAR/ABS');
end
