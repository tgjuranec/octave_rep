function [mag,phs] = pwm_analysis(fs, dc)
	non = floor(fs * dc)
	noff = floor(fs * (1 - dc))

	x = horzcat(1,ones(1,floor(non)),zeros(1,floor(noff)))

	r = fft(x)

	nfreq = ceil(fs/2)
	mag = zeros(1,nfreq)

	mag(1) = r(1)
	mag(2:nfreq) = 2*abs(r(2:nfreq))
	phs(1) = 0
	phs(2:nfreq) = angle(r(2:nfreq))
	subplot(2,1,1)
	title(	strcat("sample freq: ",num2str(fs), " duty cycle: ", num2str(dc)))
	grid on
	bar(mag)
	subplot(2,1,2)
	grid on
	bar(phs)
	return
endfunction
