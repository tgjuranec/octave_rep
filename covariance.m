function covxy = covariance(x,y)
     N = length(x);
     
     if((N < 2) || (N != length(y)))
        printf("Error, vectors must have equal number of members")
        covxy = nan;
        return;        
     endif
     
     xm = mean(x);
     xsum = sum(x);
     ym = mean(y);
     ysum = sum(y);
     xy = sum(x.*y);
     
     covxy = (xy-xm*ysum-ym*xsum)/N + xm*ym;     
     
endfunction
