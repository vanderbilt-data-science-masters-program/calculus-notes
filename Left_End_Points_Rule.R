example = 4 #1=quadratic, 2=sin, 3=gaussian, 4=1/x
max_num_pts <-50
start=0
end=1
area_estimate <- numeric(max_num_pts-1)


for(i in 2:max_num_pts){
  running_sum<-0
  x_partition <- seq(from=start, to=end, length.out=i+1)
  if(example ==1){
    for(j in 1:i){
      running_sum <- running_sum+x_partition[j+1]^2
    } # End-computing right-hand endpoints
  }
  if(example ==2){
    for(j in 1:i){
      running_sum <- running_sum+sin(x_partition[j+1])
    }
  } #End sin
  if(example ==3){
    for(j in 1:i){
    running_sum<-running_sum+(1/(sqrt(2*pi)))*exp(-x_partition[j+1]^2/2)
    }
  }
  if(example==4){
    for(j in 1:i){
      running_sum <- running_sum+1/x_partition[j+1]
    }
  }
 area_estimate[i-1] <- (end-start)*running_sum/i
}

vec <- 2:max_num_pts
plot_ly(data.frame(vec,area_estimate), x=~vec, y=~area_estimate, type='scatter', mode='markers')
  