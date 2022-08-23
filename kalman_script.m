
#1 dimensional kalman filter 
nIterations  = 2000;
position = 0
velocity = 0
dt = 0.1

#estimated position and velocity
x = zeros(2,nIterations);
x(:,1) = [position;
     velocity];
#Initial Covariance matrix 
P = [0 0 ; 0 0];

# data from sensors
z = zeros(2,nIterations);
R = [0.12 0.0;0.0 0.08];
z(:,1) = [0;0];

#noise - external disturbances - stohastic
Q = [0.03,0.0;0.0,0.04];

#noise - directed error (e.g. wind)
zwind = [0;-0.2]


#Multiplication matrix - between steps
F = [1 dt; 0 1];

#Control vector
u = [0.1;0.1];
B=[dt*dt/2 , 0; 0, dt];

#convert
H = [1,0;0,1];

#Final calculated variable
xkal = zeros(2,2000);
Pkal = [0,0;0,0];


for i = 2:nIterations
     x(:,i) = F*xkal(:,i-1) + B*u;
     P = F*Pkal*transpose(F) + Q;  
   
     #get sensor variable
     #This is simulation - sensor has independent measurement
     #in a real situation z does not depend on x!!!!!
     z(:,i)= H*(x(:,i) + normrnd(0,sqrt(0.01),2,1)) + zwind;
     #START KALMAN
     K = P*H'*inv(H*P*H' + R);
     #APPLY KALMAN - INTEGRATE x estimate and z measurement
     xkal(:,i) = x(:,i) + K*(z(:,i)-H*x(:,i));
     Pkal = P - K*H*P;
endfor
P
Pkal
