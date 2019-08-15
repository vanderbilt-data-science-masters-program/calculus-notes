library(plotly)

example <- 2 #1=quadratic, 2=sin, 3=relu,4=non-differentiable
method <- 2 #1=forward difference, 2=backward, 3=centered

estimate <- numeric(100)
x<- numeric(100)

for (i in 1:100){
  x <- 0.1/i
  h[i]<- x
  if(method==1){
    x1<-x
    x2<-0
  }#Forward difference method
  if(method==2){
    x1<-0
    x2<- -x
  } #Backward differe
  if(method==3){
    x1<- x
    x2<- -x
  } #centered difference (CAN YIELD VALUES FOR NON-DIFFERENTIABLE FUNCTIONS, |x| e.g.)
  if(example==1){
    slope <- (x1^2-x2^2)/(x1-x2)
  }
  if(example==2){
    slope <- (sin(x1)-sin(x2))/(x1-x2)
  }
  if(example==3){
    slope<- (max(0,x1)-max(0,x2))/(x1-x2)
  }
  if(example==4){
    slope<- (sin(1/x1)-sin(1/x2))/(x1-x2)
  }
  estimate[i]<- slope
}

plot_ly(data = data.frame(h,estimate), x=~h,y=~estimate, type='scatter')

