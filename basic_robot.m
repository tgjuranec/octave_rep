1;
echo off all
%matrices
A=[0,1;-3,0]
B=[0;1]
C=[1,0]
%get values for K (insert  wanted eigenvalues)
K=place(A,B,[-2,-4])

%init values x
x=[1;0]
xh=[0;0]

%init values for loop
t=0;dt=0.01;tf=5; c = 1;xstore=x;
while(t < tf);
	t = t+dt;
	x = x + dt*(A-B*K)*x;
	c = c +1;
	xstore(:,c) = x;
end;

%show the result
t = 0:0.01:5.01
plot(t,xstore)