#Function returns covariance matrix
function mat = covmat(x,y)

  N = length(x);
  #testing lengths of the provided vectors
  if((length(y) != N) || (N<=1))
    mat = nan;
    printf("Error, vectors' lengths must be equal and grater than 1\n")
    return
  endif  
  mat = [covariance(x,x) covariance(x,y);covariance(y,x) covariance(y,y)];
  #Plot ellipse 
  xm = mean(x)
  xsum = sum(x);
  ym = mean(y)
  ysum = sum(y);
  theta = 0:0.01:2*pi;
  xplot = xm + mat(1,1)*cos(theta) + mat(1,2)*sin(theta);
  yplot = ym + mat(2,1)*cos(theta) + mat(2,2)*sin(theta);
  plot(xplot,yplot,xm,ym);axis equal;
  line([xm xm+mat(1,1)],[ym ym+mat(1,2)]);
  line([xm xm+mat(2,1)],[ym ym+mat(2,2)]);
endfunction
