t = 0.01

xin = [0;0]
Pin = [0.2,0.3;0.3,0.1]


F = [1,t;0,1]
B = [t*t/2;t]
u = 0.5
#noise
Q = [0.05,0.02;0.02,0.05]

#convert
H = [1,0;0,1]

#real variable - usually not known

# data from sensors
z = zeros(2,1000)
R = [0.06 0.05;0.05 0.06]

#results
x = zeros(2,1000)
P = zeros(2,2,1000)
x(:,1) = xin
P(:,:,1) = Pin;

xest = zeros(2,1000)
Pest = zeros(2,2,1000)

for i = 2:1000
  #update predict variable
  x(:,i) = H*(F*xest(:,i-1) + B*u)
  P(:,:,i) = H*(F*Pest(:,:,i-1)*transpose(F) + Q)*transpose(H)
  #get sensor variable
  z(:,i)= H*(F*xest(:,i-1) + B*u + normrnd(0,sqrt(0.01),2,1))
  #calculate estimation variable 
  K = P(:,:,i)*transpose(H)*inv(H*P(:,:,i)*transpose(H) + R)
  xest(:,i) = x(:,i) + K*(z(:,i)-H*x(:,i))
  Pest(:,:,i) = P(:,:,i) - K*H*P(:,:,i)  
  endfor