1;
echo off all

a=ones(1,100)
b=ones(1,100)
res=ones(1,100)
rnd = 0xFF002244
rnd2 = rnd+151126

for m=0:99
	a(m+1)=bitxor(rnd,65535+m)
	b(m+1)=bitxor(rnd,65535+m+1)
	ab(m+1)=bitxor(a(m+1),b(m+1))

endfor