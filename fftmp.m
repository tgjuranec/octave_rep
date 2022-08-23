function [mag,phs] = fftmp(x)
	y = fft(x)
	l = length(x)
	middle = ceil(l/2)
	mag = zeros(1,middle)
	phs = zeros(1,middle)
	mag(1) = y(1)
	phs(1) = 0
	mag(2:middle) = 2*abs(y(2:middle))
	phs(2:middle) = angle(y(2:middle))
	return
endfunction
