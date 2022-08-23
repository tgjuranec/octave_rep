function mat = matcov(x,y)
     N = length(x);
     
     if((N < 2) || (N != length(y)))
        printf("Error, vectors must have equal number of members")
        covxy = nan;
        return;        
     endif
     mat = [covariance(x,x) covariance(x,y);
            covariance(y,x) covariance(y,y)];
     
endfunction
