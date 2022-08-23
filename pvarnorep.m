function res = pvarnorep(domain, N)
  fs = domain : -1 : (domain-N+1);
  fracts = fs./domain;
  res = prod(fracts);
endfunction
