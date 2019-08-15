library(plotly)

example <- 3 #1=quadratic, 2=-cos(5x), 3=bad function
learning_rate <- 1
iterations <- 201 #Number of Update Steps
iterates <- numeric(iterations)
iterates[1] <- 1 #Initial Guess
func_values <- numeric(iterations)
xs <- seq(from=-iterates[1], to=iterates[1], length.out=iterations)  
true <- numeric(iterations)

if(example==1){
  func_values[1] <- iterates[1]^2
  true[1]<- xs[1]^2
}else if(example==2){
  func_values[1] <- -cos(3*iterates[1])
  true[1] <- -cos(3*xs[1])
}else{
  func_values[1] <- sqrt(abs(iterates[1]))
  true[1] <- sqrt(abs(xs[1]))
}

for (i in 2:iterations){
  if(example==1){
    deriv <- 2*iterates[i-1]
    iterates[i] <- iterates[i-1]-learning_rate*deriv
    func_values[i]=iterates[i]^2
    true[i]=xs[i]^2
  }
  if(example==2){
    deriv <- 3*sin(3*iterates[i-1])
    iterates[i] <- iterates[i-1]-learning_rate*deriv
    func_values[i]=-cos(3*iterates[i])
    true[i]=-cos(3*xs[i])
  }
  if(example==3){
    deriv<- 1/(2*sqrt(abs(iterates[i-1])))
    if(iterates[i-1]<0){
      deriv <- deriv*(-1)
    }
    iterates[i] <- iterates[i-1]-learning_rate*deriv
    func_values[i] =sqrt(abs(iterates[i]))
    true[i] =sqrt(abs(xs[i]))
  }
}

p<-plot_ly(data.frame(iterates,func_values), x=~iterates, y=~func_values, type='scatter', mode='lines+markers') %>%
add_trace(data.frame(xs,true),x=~xs, y=~true, type='scatter', mode='lines')
p
