1;
echo off all


Kp = 10
Kd = 10


%init values x
x=0
v = 0
xdes = 10


%init values for loop
t=0;dt=0.01;tf=5; c = 1;xstore=[x;v]
while(t < tf);
	t = t+dt;
	a = Kp*(xdes-x) + Kd*(0 - v)
	v = v + a*dt
	x = x + v*dt 
	c = c +1;
	xstore(:,c) = [x;v];
end;

t = 0:0.01:5.01
plot(t,xstore)
