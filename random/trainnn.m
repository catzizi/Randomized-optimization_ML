function err = trainnn (w)

% w has 7*20+7 = 147 weights

% pack weights in the matrices for net
load net.mat;

% 7 x 20
net.IW{1} = reshape ( w(1:(7*20)), 7, 20 );
net.LW{2} = reshape ( w((7*20+1):(7*20+7)), 1, 7 );

load data.mat;

%calc error
err = ( sum ( (L - sim (net, A)).^2 ) + 0.5 * sum(w.*w) ) / size(A,2);

end