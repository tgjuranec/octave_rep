1;
echo off all
%matrices
A=[0,1;0,0]
B=[0;1]
C=[1,1]

%get values for K (insert  wanted eigenvalues)
K=place(A,B,[-1,-4])

%set L values
lmbd1=-8;
lmbd2=-15;
L=[-lmbd1-lmbd2;(-lmbd1)*(-lmbd2)]

%init values x
x=[1;1]
xh=[1;0]

%init values for loop
t=0;dt=0.01;tf=5; c = 1;xstore=x;xhstore=xh;
y=[];u=[];
while(t < tf);
	y = C*x;
	u = -K*xh;
	t = t+dt;
	x = x + dt*(A-B*K)*x;
	c = c +1;
	xstore(:,c) = x;
	xh = xh + dt*(A*xh + B*u + L*(y - C*xh));
	xhstore(:,c) = xh;
end;

%show the result
t = 0:0.01:5.01
figure(1)
plot(t,xstore(1,:),t,xhstore(1,:))
figure(2)
plot(t,xstore(2,:),t,xhstore(2,:))