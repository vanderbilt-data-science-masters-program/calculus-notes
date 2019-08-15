neurons = 1000;
eta = 0.01;
training_its = 60000;
Test_freq=50;
sample_window=4;
Test_Window=8;
test_pts=1000;
Make_gif = true(1); 
filename = 'neural.gif';

Weights = 0.1*randn(neurons,1);% Weight INTO neuron i
Biases = 0.1*randn(neurons,1); % Bias for neuron i
Coeffs = 0.1*randn(neurons,1); %weight out of neuron i

d_Weights = zeros(neurons,1); %partial derivatives w.r.t. weights
d_Biases = zeros(neurons,1);  %partial derivatives w.r.t. biases
d_Coeffs = zeros(neurons,1);  %partial derivatives w.r.t. coeffs

%utilities to help plotting later
x_part =linspace(-Test_Window,Test_Window,test_pts);
f_at_x_part = zeros(1,test_pts);
true=zeros(1,test_pts);
fig=figure;
axis manual;
for i=1:training_its
   input = 2*sample_window*rand-sample_window;
   %target = exp(-0.5*(input^2));
   target = sin(3*input);
   Neural_Outputs = relu(input*Weights+Biases);
   predicted = dot(Coeffs,Neural_Outputs);
   
   % We minimize L2 error. 
   for j=1:neurons
       d_Coeffs(j)= 2*(predicted-target)*Neural_Outputs(j);
       if Neural_Outputs(j)>0
           d_Biases(j)=2*(predicted-target)*Coeffs(j);
       else
           d_Biases(j)=0;
       end
       d_Weights(j)=d_Biases(j)*input;
   end
   Weights = Weights - eta*d_Weights;
   Biases = Biases - eta*d_Biases;
   Coeffs = Coeffs - eta*d_Coeffs;
   if mod(i,Test_freq)==1 && Make_gif %Picture every 10 updates
        for j=1:test_pts
            f_at_x_part(j)= dot(Coeffs,relu(x_part(j)*Weights+Biases));
            %true(j)=exp(-0.5*(x_part(j)^2));
            true(j)=sin(3*x_part(j));
        end
        plot(x_part,f_at_x_part); hold on
        plot(x_part,true); 
        line([ -sample_window -sample_window], [-2 2], 'LineStyle', '--'); 
        line([ sample_window sample_window], [-2 2], 'LineStyle', '--');hold off
        title(['Training Iterations: ' num2str(i-1)  ]);
        axis([-Test_Window Test_Window -2 2]);
        drawnow
        frame=getframe(fig);
        im=frame2im(frame);
        [imind,cm]=rgb2ind(im,256);
        if i == 1 
            imwrite(imind,cm,filename,'gif', 'Loopcount',inf,'DelayTime',0.1); 
        else 
            imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime',0.1); 
        end 
   end
end

figure; 
for j=1:test_pts
    f_at_x_part(j)=dot(Coeffs,relu(x_part(j)*Weights+Biases));
    true(j)=sin(3*x_part(j));
end
plot(x_part,f_at_x_part); hold on; plot(x_part,true); axis([-Test_Window Test_Window, -1 1]);