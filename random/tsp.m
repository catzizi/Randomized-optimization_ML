function dist = tsp (x)

load cities
[k,l] = sort(x);

% l is permutation
if ( size(l,1) > size(l,2) )
dists = cities(:, circshift (l,[1 0]) ) - cities(:,l);
else
dists = cities(:, circshift (l,[0 1]) ) - cities(:,l);
end
dist = sum(sqrt(sum ( dists .* dists)));

end