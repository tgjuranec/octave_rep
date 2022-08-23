1;
echo off all
fs = 1000
T = 1
N=fs*T
f1 = 100
f2 = 92

n = 0:N-1
SNR = 6
M = 1
%signals 
xd = cos(2*pi*n*f1/fs) 
x = sqrt(1/2/(10^(SNR/10)))*randn(1,N)
xf = x + xd

%coefficients for changing mu
mustart = 1e-10
mu = 1e-4	%the results

%coefficients for changing number of steps
LOOP = 30
%results of similarity are stored in d and r
d = []
r = []
e = xf
for k=1:LOOP
	[e,y,wo,F,Wo] = lms_nc(e,x,1,mu);
	[o,p,q] = dtw(xd(fix(N/2):N),e(fix(N/2):N));
	d(k) = o/p;
	r(k) = corr(xd(fix(N/2):N),e(fix(N/2):N));
endfor

