function res = performnn (w)

load net.mat;

% 7 x 20
net.IW{1} = reshape ( w(1:(7*20)), 7, 20 );
net.LW{2} = reshape ( w((7*20+1):(7*20+7)), 1, 7 );

load data.mat;

%calc error
simL = sim (net, TestA) > 0.5;
res = sum(simL == TestL ) / length(TestL);

end