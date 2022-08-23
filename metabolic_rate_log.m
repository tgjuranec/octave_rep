MR = zeros(1,1000);
MR(1) = 1200;
MR_square = zeros(1,1000);


U(1:200) =  2000; #+ 1000*rand(1,500)
T(1:200) =  600; #+ 500*rand(1,500)

U(201:400) =  1900; #+ 1000*rand(1,500)
T(201:400) =  600; #+ 500*rand(1,500)

U(401:600) =  1800; #+ 1000*rand(1,500)
T(401:600) =  600; #+ 500*rand(1,500)

U(601:800) =  1700; #+ 1000*rand(1,500)
T(601:800) =  600; #+ 500*rand(1,500)

U(801:1000) =  1600; #+ 1000*rand(1,500)
T(801:1000) =  600; #+ 500*rand(1,500)

K1 = 0.08
K2 = 0.08
C1 = 0.2
C2 = 0.2
K = 20
C = 1.5

S = zeros(1,1000);
MRmin = MR(1);
MRmax = 0;
#MR(i) = MR(i-1) + K1*(U(i-1) - C1*MR(i-1)) + K2*(T(i-1) - C2*MR(i-1))

for i = 2:1000
  MR(i) = MR(i-1)*(1-C1*K1-C2*K2) + K1*U(i-1) + K2*T(i-1)-K*log(C*MR(i-1)+1);
  if(MR(i) < MRmin) MRmin = MR(i);
    endif;
  if(MR(i) > MRmax) MRmax = MR(i);
    endif;
  S(i) = U(i) - MR(i) - T(i);
  if(MR(i) < 0) break;
    endif;
  endfor;
  




 MR(600) -2*MR(800)+MR(1000)
 MRmin
 MRmax
 plot(MR(20:1000))