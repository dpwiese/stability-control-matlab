
%%The other guy's code
[A,B,C,D]=linmod2('q1_3')
E=[0 0 0; 0 0 0; 0 0 0; 0 0 0]
L1=[0 0 0 0 1 0 0];
L2=[1 0 0]*[C D];
L3=[0 0 0 0 0 1 0];
L4=[0 1 0]*[C D];
L5=[0 0 0 0 0 0 1];
L6=[0 0 1]*[C D];
L7=[eye(4) E];
L8=[A B];

[n,m]=size(B);
P=sdpvar(n,n);
r=sdpvar(1,1);
d0=sdpvar(1);
d1=sdpvar(1);
d2=sdpvar(1);
D1= (d1^2)/(d0^2);
D2= (d2^2)/(d0^2);

F=[P>=0,d0>0,d1>0,d2>0,r>0];
F=[F,[-C'*C-P*A-A'*P -P*B-C'*D;-B'*P-D'*C r*eye(m)-D'*D]>=0];
%F=[F,[r*(d0^2)*(L1'*L1)-(d0^2)*(L2'*L2) + (d1^2)*(L3'*L3 - L4'*L4) + (d2^2)*(L5'*L5 - L6'*L6) - L7'*P*L8 - L8'*P*L7] >= 0]
%solvesdp(F)              % optimize
%r=sqrt(double(r));         % convert to numeric value

solvesdp(F,r);
%if(info.problem==0)
   r=sqrt(double(r))