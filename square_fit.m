N = 10
M = 20

n = -M:M
k = -M:M
l = N:-1:0
k = repmat(k,N+1,1)
l = repmat(l',1,2*M+1)
a = k.^l

x = rand(1,2*M+1) + cos(2*pi*n*1/10)


for m = 0:N
	p = polyfit(n,x,m)
	%y = p1*n^l + ... pn-2*n^2 + pn-1*n+pn
	y = p*a(1:m+1,:)
	figure
	plot(n,x,n,y)
endfor

