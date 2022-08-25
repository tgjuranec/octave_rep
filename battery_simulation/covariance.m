#function calculates covariance of two vectors
function covxy = covariance(x,y)

  N = length(x);
  #testing lengths of the provided vectors
  if((length(y) != N) || (N<=1))
    covxy = nan;
    printf("Error, vectors' lengths must be equal and grater than 1\n")
    return
  endif
  #Preparing data ror calculation
  xm = mean(x);
  xsum = sum(x);
  ym = mean(y);
  ysum = sum(y);
  xy = x.*y;
  #Final calculation
  covxy = (sum(xy) - ym*xsum - xm*ysum)/N + xm*ym;
endfunction
