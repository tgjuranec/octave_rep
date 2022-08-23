
g = 9.81
l = 0.5

t = 0.01

xinit = [pi/18;0]
xdotinit = [0 (pi*g)/(18*l)]
x = zeros(2,1000)
xdot = zeros(2,1000)
x(:,1) = xinit
xdot(:,1) = xdotinit


u = 0;

B = [0;1]

A = [0 1;
    -g/l 0]

F = [1 0 ; 
     0 1]


for i = 2:1000
  x(:,i) = F*x(:,i-1) + [t t*t/2;1 t]*xdot(:,i-1)
  xdot(:,i) = A*x(:,i) + B*u
  endfor
  