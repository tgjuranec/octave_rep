function vbat = bat_ocv(soc)
  #SOC- OVC curve
  c = [
   2.85
   4.80
   -17.80
   38.59
   4.91
   -210.52
   433.98
   -368.45
   115.81
  ];
  vbat = c(1) + c(2)*soc + c(3)*power(soc,2) + c(4)*power(soc,3) + ...
    c(5)*power(soc,4) + c(6)*power(soc,5)+ ...
    c(7)*power(soc,6) + c(8)*power(soc,7)+ ...
    c(9)*power(soc,8);  
endfunction
