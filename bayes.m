
p = 0.95;
rel=0.7

A = [p;1-p]
R = [rel,1-rel]

bTable = A*R

pp = R*A

negative = diag(bTable)
positive = diag(fliplr(bTable))

FPR = bTable(1,2)*1/(1-pp)
MD = bTable(2,2)/pp