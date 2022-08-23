function [e,y,wo,F,Wo] = lms_nc(xfull,xnoise,M,mu)
%[n,x,y,e,wo,F,Wo] = lms_ale(SNR,N,M,mu)
%%*******LMS ALE Simulation************
%SNR = Sinusoid SNR in dB
%N = Number of simulation samples
%M = FIR Filter length
%mu = LMS step-size
%%n = Index vector
%x = Noisy input
%y = Filtered output
%e = Error sequence
%wo = Final value of weight vector
%F = Frequency response axis vector
%Wo = Frequency response of filter
%**************************************
%Mark Wickert, 4/27/98
%%


%Sinusoid SNR = (A^2/2)/noise_var
N=length(xfull)
%White Noise -> Delta = 1, so delay x by one sample
xd = filter(1,1,xfull);
% Initialize output vector y to zero
y = zeros(1,N);
% Initialize error vector e to zero
e = zeros(1,N);
% Initialize weight vector to zero
wo = zeros(1,M);
% Initialize filter memory to zero
z = zeros(1,M-1);
% Initialize a vector for holding xd of length M
xdm = zeros(1,M);
for k=1:N
	% Filter one sample at a time
	[y(k),z] = filter(wo,1,xnoise(k),z);
	% Form the error sequence
	e(k) = xfull(k) - y(k);
	% Update the weight vector
	wo = wo + 2*mu*e(k)*xdm;
	% Update vector used for correlation with e(k)
	xdm = [xd(k) xdm(1:M-1)];
end %end loop on time index k
% Create filter frequency response
[Wo,F] = freqz(wo,1,512,1);
Wo = 20*log10(abs(Wo));
endfunction
