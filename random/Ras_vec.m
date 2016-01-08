function [ res ] = Ras_vec( x )

res = 20 + 3 *(x(1).^2 + x(2).^2) -10*(cos(2*pi*x(1))+cos(2*pi*x(2)));
