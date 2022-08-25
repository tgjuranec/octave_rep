
#internal resistance
R=0.1
#SOC- OVC curve
c = [
 2.85
 4.80
 -17.80
 38.59
 4.91
 -210.52
 433.98
 -368.45
 115.81
]


#Max charge of the battery 100% SOC
QmaxAh = 14;
#curent status of battery charge
qAh = QmaxAh;
#discharge current - constant
iA=1

nIterations = 1000;
ovc = zeros(1,nIterations);
vout = zeros(1,nIterations);
#delta T between iterations
dTh = QmaxAh/iA/nIterations

for i = 1:nIterations
  qAh = qAh - iA*dTh;   #get current charge status 
  soc = qAh/QmaxAh;     #get get SOC 
  ovc(i) = c(1) + c(2)*soc + c(3)*power(soc,2) + c(4)*power(soc,3) + ...
    c(5)*power(soc,4) + c(6)*power(soc,5)+ ...
    c(7)*power(soc,6) + c(8)*power(soc,7)+ ...
    c(9)*power(soc,8);
  vout(i) = ovc(i)-iA*R;    
endfor

t = [0:dTh:(nIterations-1)*dTh];