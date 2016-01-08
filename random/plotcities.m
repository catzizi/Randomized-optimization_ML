function [] = plotcities (perm)

load cities;
if ( nargin == 0 )
plot ( cities(1,:), cities(2,:), 'b+' );
else
    [tmp perm] = sort(perm);
    plot ( cities(1,perm), cities(2,perm), 'b-' );    
end
xlim ( [ (min (cities(1,:)) - 1000) (max(cities(1,:)) + 1000) ] )
ylim ( [ (min (cities(2,:)) - 1000) (max(cities(2,:)) + 1000) ] )

end
