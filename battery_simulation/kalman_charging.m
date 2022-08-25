
#time between measuring 0.01h = 36s
dth = 0.01
#predicted time of charging/discharging
Th = 2
ndata = int32(Th/dth);

#Number of cells
N = 10

#Charging current
Imax = 2
i = Imax*(N)
#Max charge per cell (100% charged)
QmaxAVG = 14;
Qmax = QmaxAVG*ones(N);

#Starting charge
qStart = zeros(N);

#balanced cells
bal = zeros(N);

#initialize q 
q = zeros(N, ndata);
q(:,1) = qStart;
