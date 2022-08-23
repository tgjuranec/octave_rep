function [n,x,y,e,wo,F,Wo] = lms_ale(SNR,N,M,mu)
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
n= 0:N; % actually length N+1
x= 1*cos(2*pi*1/20*n); % Here A = 1, Fo/Fs = 1/20
x= x + sqrt(1/2/(10^(SNR/10)))*randn(1,N+1);
%White Noise -> Delta = 1, so delay x by one sample
xd = filter([0,1],1,x);
% Initialize output vector y to zero
y = zeros(1,N+1);
% Initialize error vector e to zero
e = zeros(1,N+1);
% Initialize weight vector to zero
wo = zeros(1,M);
% Initialize filter memory to zero
z = zeros(1,M-1);
% Initialize a vector for holding xd of length M
xdm = zeros(1,M);
for k=1:N+1
	% Filter one sample at a time
	y(k) = filter(wo,1,x(k));
	% Form the error sequence
	e(k) = x(k) - y(k);
	% Update the weight vector
	wo = wo + 2*mu*e(k)*xdm;
	% Update vector used for correlation with e(k)
	xdm = [xd(k) xdm(1:M-1)];
end %end loop on time index k
% Create filter frequency response
[Wo,F] = freqz(wo,1,512,1);
Wo = 20*log10(abs(Wo));
endfunction
