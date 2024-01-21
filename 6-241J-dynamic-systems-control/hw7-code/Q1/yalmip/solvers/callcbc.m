function output = callcbc(interfacedata)

% Author Johan L�fberg
% $Id: callcbc.m,v 1.6 2005-05-07 13:53:20 joloef Exp $

% Standard input interface
options = interfacedata.options;
F_struc = interfacedata.F_struc;
c       = interfacedata.c;
K       = interfacedata.K;
lb      = interfacedata.lb;
ub      = interfacedata.ub;
x0      = interfacedata.x0;

showprogress('Calling CBC',options.showprogress);

if isempty(F_struc)
    Aeq = [];
    beq = [];
    A = [];
    b = [];
else
    Aeq = -F_struc(1:1:K.f,2:end);
    beq = F_struc(1:1:K.f,1);
    A =-F_struc(K.f+1:end,2:end);
    b = F_struc(K.f+1:end,1);
end
solvertime = clock;

ivars = zeros(length(c),1);
ivars(interfacedata.integer_variables) = 1;
ivars = int32(ivars);
opts.nin = length(b);
opts.tolint = 1e-4;
opts.maxiter = 10000;
opts.maxnodes = 100000;
opts.maxtime =  100000;
opts.display = options.verbose;

if options.savedebug
    save cbcdebug c A b Aeq beq lb ub opts
end

sos.sostype=[];
sos.sosind=[];
sos.soswt=[];

solvertime = clock;
[x,fval,exitflag,iter] = cbc(full(c), A, full(b), full(lb), full(ub), ivars,sos,opts);
solvertime = etime(clock,solvertime);
problem = 0;

% No duals
D_struc = [];
if isempty(x)
    x = zeros(length(c),1);
end

% Check, currently not exhaustive...
switch exitflag
    case 1
        problem = 0;
    case 0
        problem = 3;
    case -1
        problem = 1;
    case -2
        problem = 11;
    case -5
        probolem = 16;
    otherwise
        problem = -1;
end

infostr = yalmiperror(problem,'CBC');

% Save all data sent to solver?
if options.savesolverinput
    solverinput.A = A;
    solverinput.b = b;
    solverinput.f = c;
else
    solverinput = [];
end

% Save all data from the solver?
if options.savesolveroutput
    solveroutput.x = x;
    solveroutput.fval = fval;
    solveroutput.exitflag = exitflag;
    solveroutput = iter;
else
    solveroutput = [];
end

% Standard interface
output.Primal      = x(:);
output.Dual        = D_struc;
output.Slack       = [];
output.problem     = problem;
output.infostr     = infostr;
output.solverinput = solverinput;
output.solveroutput= solveroutput;
output.solvertime  = solvertime;