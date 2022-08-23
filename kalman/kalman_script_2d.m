
#2 dimensional kalman filter 

#position
px = 0; py = 0;
#velocity
vx = 0; vy = 0;
T = 200;
dt = 0.1;
nIterations  = int32(T/dt);

#estimated position and velocity
x = zeros(4,nIterations);
x(:,1) = [px;py;vx;vy];
#Initial Covariance matrix 
P = zeros(4,4);

# data from sensors
z = zeros(4,nIterations);
R = diag([0.06;0.06;0.03;0.03]);
z(:,1) = [0;0;0;0];

#noise - external disturbances - stohastic
Q = diag([0.03;0.03;0.001;0.001]);

#noise - directed error (e.g. wind)
zwind = [0;0;0.15;-0.04];


#Multiplication matrix - between steps
F = [1 0 dt 0; 0 1 0 dt; 0 0 1 0; 0 0 0 1];

#Control vector
u = [0.1;0.0665;0.1;0.0665];
B=diag([dt*dt/2;dt*dt/2;dt; dt]);

#convert
H = diag([1;1;1;1]);

#Final calculated variable
xkal = zeros(4,2000);
Pkal = zeros(4,4);


for i = 2:nIterations
     x(:,i) = F*xkal(:,i-1) + B*u;
     P = F*Pkal*transpose(F) + Q;  
   
     #get sensor variable
     #This is simulation - sensor has independent measurement
     #in a real situation z does not depend on x!!!!!
     z(:,i)= x(:,i) + normrnd(0,sqrt(0.01),4,1) + zwind;
     #START KALMAN
     K = P*H'*inv(H*P*H' + R);
     #APPLY KALMAN - INTEGRATE x estimate and z measurement
     xkal(:,i) = x(:,i) + K*(z(:,i)-H*x(:,i));
     Pkal = P - K*H*P;
endfor
P
Pkal
figure(1);
plot(0:dt:T-dt,xkal);
figure(2);
plot(xkal(1,:),xkal(2,:));
grid on;
axis equal;