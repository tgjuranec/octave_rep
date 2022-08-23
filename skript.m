1;
echo off all
fs = 1000
T = 10
N=fs*T
f1 = 100
f2 = 92

n = 0:N-1
SNR = 6
M = 1
%signals 
xd = ones(1,N) + cos(2*pi*n*f1/fs) + cos(2*pi*n*f2/fs)
x = sqrt(1/2/(10^(SNR/10)))*randn(1,N)
xf = x + xd

%coefficients for changing mu
mustart = 1e-10
MU_LOOP = 8

%coefficients for changing M
LOOP = 30
%results of similarity are stored in d and r
d = []
r = []

for k=1:LOOP
	for l = 1:MU_LOOP
		mu = mustart * power(10,l);
		[e,y,wo,F,Wo] = lms_nc(xf,x,k,mu);
		[o,p,q] = dtw(xd(fix(N/2):N),e(fix(N/2):N));
		d(k,l) = o/p;
		r(k,l) = corr(xd(fix(N/2):N),e(fix(N/2):N));
	endfor
endfor

