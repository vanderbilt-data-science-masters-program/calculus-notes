clear all
close all
clc

resolution=1000; 
f = @(x) (x-1)^2 +1; %Saddle point around (1,1)

init_zoom = 0.25;
function_vals=zeros(1,resolution);
horiz=ones(1,resolution);
fig=figure;
filename='quadratic_zoom.gif';

for t=1:50
    cur_zoom=4*init_zoom/(t);
    x=linspace(1-cur_zoom,1+cur_zoom, resolution);
    for i=1:resolution
        function_vals(i)=f(x(i));
    end
    plot(x,function_vals,'Linewidth',2, 'Color', 'r'); hold on
    plot(x,horiz,'Linewidth',1, 'Color', 'b');
    legend('Quadratic Polynomial','Linear Approximation Whose Slope is the Derivative');
    title('The Derivative is the Slope of the Best Linear Approximation')
    axis([1-cur_zoom 1+cur_zoom 1-cur_zoom^1.5 1+cur_zoom^1.5])
    drawnow
    frame=getframe(fig);
    im=frame2im(frame);
    [imind,cm]=rgb2ind(im,256);
    if t == 1 
        imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.3); 
    else 
        imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime',0.3); 
    end 
end