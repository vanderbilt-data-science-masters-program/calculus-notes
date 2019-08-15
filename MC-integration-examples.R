## J. BLume examples

### find Pie or pie/2 by Montecarlo integration
#### sqrt(1-x.sampled^2) between (-1,1) area=pie/2

sims <- 2000
points <- 200

area <- rep(NA,sims)
x <- seq(-1,1,0.001)  # don't need this

for (i in 1:sims) {
x.sampled <- runif(points,-1,1)
  
f.x <- sqrt(1-x.sampled^2)
area[i] <- mean(f.x)*(1-(-1))
}

c(mean(area), pi/2)
(limits <- mean(area)+c(-1,1)*sd(area)/sqrt(sims))

hist(area,breaks=sims/10)
abline(v=pi/2,lwd=2,col="red")


abline(v=limits[1],lwd=2,col="blue")
abline(v=limits[2],lwd=2,col="blue")


### MonteCarlo integreation of Normal curve
### from a to b
sims <- 500
points <- 200

a <- -1
b <- 1.645 
(target <- pnorm(b)-pnorm(a))

area <- rep(NA,sims)

for (i in 1:sims) {
  x.sampled <- runif(200,a,b)
  
  f.x <- exp(-0.5*(x.sampled^2))/sqrt(2*pi)
  area[i] <- mean(f.x)*(b-a)
}

c(mean(area), target)
(limits <- mean(area)+c(-1,1)*sd(area)/sqrt(sims))

hist(area,breaks=sims/5)
abline(v=target,lwd=2,col="red")

abline(v=mean(area),lwd=2,col="green")
abline(v=limits[1],lwd=2,col="blue")
abline(v=limits[2],lwd=2,col="blue")

