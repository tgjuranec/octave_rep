1;
n = 0:999
pls1 = sinc(2*pi*(-50:50)*20/1000)
pls =- ones(1,101)
noise = randn(1,1000)*1/1
x = zeros(1,1000)
x(850:950) = x(850:950)+pls
x(250:350) = x(250:350)+pls1
xfull = noise + x
%x  = abs(x)

for k= 1:10
	y = sgolayfilt(xfull,k,41)
	[o,p,q] = dtw(abs(y),abs(x))
	d(k) = o/p
endfor
%subplot(311)
%plot(n,x)
%subplot(312)
%plot(n,xfull)
%subplot(313)
%plot(n,abs(y))
%
