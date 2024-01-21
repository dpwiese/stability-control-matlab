%%Code for 7.1

for T=1:1:10
[A,B,C,D]=linmod2('Dan_model1')
E=[0 0 0;0 0 0 ;0 0 0];
L1=[0 0 0 1 0 0];
L2=[1 0 0]*[C D];
L3=[0 0 0 0 1 0];
L4=[0 1 0]*[C D];
L5=[0 0 0 0 0 1];
L6=[0 0 1]*[C D];
L7=[eye(3) E];
L8=[A B];

[n,m]=size(B);
P=sdpvar(n,n);
r=sdpvar(1,1);
d0=sdpvar(1,1);
d1=sdpvar(1,1);
d2=sdpvar(1,1);

F=[P>=0,d0>0,d1>0,d2>0,r>0];
% F=[F,[-C'*C-P*A-A'*P -P*B-C'*D;-B'*P-D'*C r*eye(m)-D'*D]>=0];
F=[F,[-d0*C(1,:)'*C(1,:)-d1*C(2,:)'*C(2,:)-d2*C(2,:)'*C(2,:)-P*A-A'*P -P*B-d0*C(1,:)'*D(1,:)-d1*C(2,:)'*D(2,:)-d2*C(3,:)'*D(3,:);-B'*P-d0*D(1,:)'*C(1,:)-d1*D(2,:)'*C(2,:)-d2*D(3,:)'*C(3,:) r*eye(m)-d0*D(1,:)'*D(1,:)-d1*D(2,:)'*D(2,:)-d2*D(3,:)'*D(3,:)]>=0];
%F=[P>=0,d0>0,d1>0,d2>0,r>0];
% F=[F,[d0*(r*(L1'*L1)-(L2'*L2)) + (d1)*(L3'*L3 - L4'*L4) + (d2)*(L5'*L5 - L6'*L6) - L7'*P*L8 - L8'*P*L7] >= 0]
solvesdp(F,r)              % optimize
R(T)=sqrt(double(r)) ;       % convert to numeric value
plot(T,R(T),'-')
hold on
end


% plot(R)