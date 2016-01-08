function res = optTour (pl)

load cities;
opt = [ 1, 8, 38,31,44,18,7,28,6,37,19,27,17,43,30,36,46,33,20,47,21,32,39,48,5,42,24,10,45,35,4,26,2,29,34,41, ...
    16,22,3,23,14,25,13,11,12,15,40,9 ];

dists = cities(:, circshift (opt,[0 1]) ) - cities(:,opt);
res = sum(sqrt(sum ( dists .* dists)));

if ( nargin > 0)
    plot ( cities(1,opt), cities(2,opt), 'b-' );    
    xlim ( [ (min (cities(1,:)) - 1000) (max(cities(1,:)) + 1000) ] )
    ylim ( [ (min (cities(2,:)) - 1000) (max(cities(2,:)) + 1000) ] )
end
