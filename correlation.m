function mat = cor_matrix(x,y)

len = length(x)
xave = sum(x)/len
yave = sum(y)/len
mat = zeros(len,len)
for m = 1:len
	for n = 1:len
		mat(m,n) = (x(m)-xave)*(y(n)-yave)
	endfor
endfor

endfunction