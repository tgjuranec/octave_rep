#number of batteries
N=10;

#charge current - constant
i_chA=2;
i_dischA=-2;

#Balance - part of bypassed current
balCoeff = 0.5;


#INITIAL STATE OF CELLS
#internal resistance
R=0.1*ones(N,1);
R(3) = 0.07;      #3 cell has smaller internal resistance
R(4) = 0.15;     #4 cell has larger internal resistance
R(5) = 0.15;
#Max charge of the battery 100% SOC
QmaxAh = 14*ones(N,1);
QmaxAh(1) = 13; 
QmaxAh(5) = 13;
#curent status of battery charge
qAh = zeros(N,1);
qAh(2) = 2;
qAh(5) = 2;
#Cutoff voltage to prevent overCHARGE/discharge of cells
VCUTOFF_HIGH = 4.5;
VCUTOFF_LOW = (2.75 + i_dischA*mean(R));
VBALANCE_START = 4.3;


#Number of chargings
nCharges = 32;
#arrays for storing final charging/discharging OCV/SOC values
socEndValues = zeros(N,nCharges*2+1);
ocvEndValues = zeros(N,nCharges*2+1);
socEndValues(:,1) = qAh./QmaxAh;
ocvEndValues(:,1) = bat_ocv(socEndValues(:,1));

#number of checking voltages during charging/discharging
nIterations = 3000;
ocv = zeros(N,nIterations);
vout = zeros(N,nIterations);
balCells = zeros(N,1);
#delta T between iterations in hours 0.006h = 21.600s
dTh = 0.006;


for n = 1:nCharges
  i = 0;
  #CHARGING
  do 
    i = i + 1;
    #increased charge in the cell during charging
    qAh = qAh + i_chA*dTh - balCoeff*i_chA*dTh*balCells;  #get current charge status 
    soc = qAh./QmaxAh;       #get the SOC 
    ocv(:,i) = bat_ocv(soc); #ocv 
    vout(:,i) = ocv(:,i)+i_chA*R;
    #BALANCED CELLS
    balCells = vout(:,i) > VBALANCE_START;
  until ((max(vout(:,i)) > VCUTOFF_HIGH))
  #overvoltage detected - STOP CHARGING ALL CELLS
  ocv = ocv(:,1:i);
  vout = vout(:,1:i);
  #print OCV & SOC
  printf("%d: Overvoltage detection\nOCV diff:%f\nSOC diff:%f%%\n", n,...
  max(ocv(:,i)) - min(ocv(:,i)), ...
  100*(max(soc)-min(soc)))
  #Store end values Q and V
  ocvEndValues(:,n*2) = ocv(:,i);
  socEndValues(:,n*2) = 100*soc;  

  #DISCHARGING - NO BALANCING
  do 
    i = i + 1;
    #increased charge in the cell during discharging
    qAh = qAh + i_dischA*dTh;  #get current charge status 
    soc = qAh./QmaxAh;       #get the SOC 
    ocv(:,i) = bat_ocv(soc); #ocv 
    vout(:,i) = ocv(:,i)+i_dischA*R;
  until (min(vout(:,i)) < VCUTOFF_LOW)
  #undervoltage detected - STOP DISCHARGING ALL CELLS
  ocv = ocv(:,1:i);
  vout = vout(:,1:i);
  #print OCV & SOC
  printf("%d: Undervoltage detection\nOCV diff:%f\nSOC diff:%f%%\n", n,...
  max(ocv(:,i)) - min(ocv(:,i)), ...
  100*(max(soc)-min(soc)))
  #Store end values Q and V
  ocvEndValues(:,n*2+1) = ocv(:,i);
  socEndValues(:,n*2+1) = 100*soc;  
  #detecting low Qmax cells last 4 loops
  if(rem(n,4) == 0)
    diffvector=[-1;1;-1;1;-1;1;-1;1];
    Qdetection = ocvEndValues(:,n*2-7:n*2) * diffvector
  endif
endfor

t = [1:2*nCharges+1];

plot(t,ocvEndValues(1,:), t, ocvEndValues(2,:), t , ocvEndValues(3,:), t, ocvEndValues(4,:), t, ocvEndValues(5,:))
#plot(t,socEndValues(1,:), t, socEndValues(2,:), t , socEndValues(3,:), t, socEndValues(4,:), t, socEndValues(5,:))

l=legend("LowQmax","Precharged", "Low R", "High R", "Insane");
legend(l,"location", "northeastoutside");
