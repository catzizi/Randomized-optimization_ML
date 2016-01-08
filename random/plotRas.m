
function [] = plotRas (cont)

if ( nargin == 0 )
    [X,Y] = meshgrid ( -5:0.05:5, -5:0.05:5);
    Z = Ras(X,Y);

    surf (X,Y,Z, 'EdgeColor', 'none');
    shading interp;
    figure;
end;

[X,Y] = meshgrid ( -2:0.05:2, -2:0.05:2);
Z = Ras(X,Y);

[C,h] = contour(X,Y,Z,1:4:40);

if ( nargin == 0 )
text_handle = clabel(C,h);
set(text_handle,'BackgroundColor',[1 1 .6], 'Edgecolor',[.7 .7 .7]);
end