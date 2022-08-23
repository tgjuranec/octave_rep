

1;

fs = 1000
ns = fs

#x ordinata
n = 0:999

#pulse frequency
fp = 40
#pulse lasting in samples
Tp = 101
Tphalf_ceil = ceil(Tp/2)
Tphalf_floor = floor(Tp/2)
p = sin(2*pi*fp*(n(1:Tp)-Tphalf_floor)/fs)./(2*pi*fp*(n(1:Tp)-Tphalf_floor)/fs)
p(Tphalf_ceil) = 1
[pm,pa] = fftmp(p)


#x - input signal 
x = rand(1,1000)
x = x - 0.5
x = x + sin(2*pi*70*n/fs + pi/4)
x(550:650)= x (550:650) + p

#y - output signal
y = conv(x,p,"same")


plot(n,x,y)

