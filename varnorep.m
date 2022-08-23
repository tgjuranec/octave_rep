function res = varnorep(domain, N)
  fs = domain : -1 : (domain-N+1);
  res = prod(fs);
  endfunction