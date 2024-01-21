function r=cthinf6241new(G)
% function r=cthinf6241(G)
%
% using SDP optimization with YALMIP
% for CT H-Inifnity norm calculation
% note: this is NOT the efficient way to compute H-Infinity norm!
[A,B,C,D]=ssdata(G);
[n,m]=size(B);
P=sdpvar(n,n);
r=sdpvar(1,1);
F=[P>=0,[-C'*C-P*A-A'*P -P*B-C'*D;-B'*P-D'*C r*eye(m)-D'*D]>=0]; % KYP LMI
info=solvesdp(F,r);
if info.problem==0,
    r=sqrt(double(r));
elseif min(checkset(F))>-1e-6,
    r=sqrt(double(r));
else r=Inf;
% optimization successful
% optimization had some problems
% but its output satisfies constraints
% optimization failed (likely infeasible)
% get state space matrices
% state/input dimensions
% the symmetric P=P? matrix from KYP Lemma
% L2 gain bound squared
end