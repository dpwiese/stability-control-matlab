%%PS7 - Task 1
clear all;
for T=0.1:0.1:10
[A,B,C,D]=linmod2('q1_2');
if max(real(eig(A)))>=0,        %%check stability
    r=Inf; return
end
[n,m]=size(B);
P=sdpvar(n,n);                  %%defining the variables for optimization
r=sdpvar(1,1);
d1=sdpvar(1,1);
d2=sdpvar(1,1);
S1=diag([r d1 d2]);
S2=diag([1 d1 d2]);
F=[P>=0,d1>0,d2>0,r>0];
F=[F,[-C'*S2*C-P*A-A'*P -P*B-C'*S2*D;-B'*P-D'*S2*C S1-D'*S2*D]>=0]; %optimizaton criteria
info=solvesdp(F,r);
 i=int64(10*T);
 t(i)=T;
if info.problem==0,             %% optimization successful
R(i)=sqrt(double(r));
elseif min(checkset(F))>-1e-6,  %% optimization errors
R(i)=sqrt(double(r));           %% but the constraints are satisfied
else                            %% optimization failed and therefore the L2 gain is infinite
R(i)=Inf;
end

end

figure(1); plot(t,R)
xlabel('T');
ylabel('r');
title('L2 gain vs. T');
