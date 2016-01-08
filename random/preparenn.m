%stupid preprocessing
data = textread('wdbc.data', '%s', 'delimiter', ',', 'emptyvalue', 0);
data = reshape(data, 32, 569 );
A = str2double(data(3:end, :));
L = double(cell2mat ( data(2,:) ) == 'M');

[pn,meanp,stdp] = prestd(A);
[ptrans,transMat] = prepca(pn,0.001);

A = ptrans;

TestA = A(:, 1:3:end);
A = [ A(:, 2:3:end) A(:, 3:3:end) ];
TestL = L(:, 1:3:end);
L = [ L(:, 2:3:end) L(:, 3:3:end) ];

% A is feature vector ( 20 dims )

%setup network
net = newff ( minmax(A), [ 7 1 ] );
save net.mat net;
save data.mat A TestA L TestL;

