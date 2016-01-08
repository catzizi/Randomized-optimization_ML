function x = neighborSwitch (x)
    mask = randperm(length(x))==length(x);
    mask2 = circshift ( mask, [ 0 1] );
    tmp = x(mask);
    x(mask) = x(mask2);
    x(mask2) = tmp;
end