# Cleaning Function
Simul_Clean_NA <- function(list1, list2){
indices <- c()
len <- length(list1)
for(i in 1:len){
	if(!is.na(list1[i]) && !is.na(list2[i])){
		indices <- c(indices, i)
	}
}
return(indices)
}
require("Lock5Data")
data(AllCountries)

Internet <- as.numeric(AllCountries[ , 12])
GDP <- as.numeric(AllCountries[ , 5])
ind <- Simul_Clean_NA(Internet,GDP)
Internet <- Internet[ind]
GDP <- GDP[ind]

# Lets first see a linear fit:
lin <- lm(Internet ~ GDP)
dev.new()
plot(GDP,Internet, main='Linear Fit', ylim=c(0,110),, xlab='GDP/Capita',ylab='Percentage of Population with Internet Access')
abline(lin, col="red")

#now a quaInternetatic fit:
GDP2 = GDP^2
quad <- lm(Internet ~ GDP + GDP2)
l <- seq(from = min(GDP), to = max(GDP), length.out=100)
d <- data.frame(GDP=l, GDP2=l^2)
dev.new() # new plot window
plot(GDP, Internet, main='Quadratic Fit', ylim=c(0,110), xlab='GDP/Capita',ylab='Percentage of Population with Internet Access')
predictions <- predict(quad, newdata = d)
lines(l ,predictions, col=2)



# Example of overfitting the data

GDP3 = GDP^3
GDP4 = GDP^4
GDP5 = GDP^5


model5 <- lm(Internet ~ GDP+GDP2+GDP3+GDP4+GDP5)
l <- seq(from = min(GDP), to = max(GDP), length.out=100)
# the data frame fed into predict must have the same column names
# as the original data which was fit and must be of the same type
d <- data.frame(GDP = l, GDP2=l^2, GDP3=l^3, GDP4=l^4, GDP5=l^5)
dev.new() # new plot window
plot(GDP, Internet, main = 'Quintic', ylim=c(0,110), xlab='GDP/Capita',ylab='Percentage of Population with Internet Access')
predictions <- predict(model5, newdata = d)
lines(l ,predictions, col=2)


# Even higher? Degree 8
dev.new() # new plot screen
GDP6=GDP^6
GDP7=GDP^7
GDP8=GDP^8
model9 <- lm(Internet ~ GDP+GDP2+GDP3+GDP4+GDP5+GDP6+GDP7+GDP8)
d <- data.frame(GDP = l, GDP2=l^2, GDP3=l^3, GDP4=l^4, GDP5=l^5, GDP6=l^6,GDP7=l^7,GDP8=l^8)
plot(GDP,Internet, main = 'Degree 8', ylim=c(0,110), xlab='GDP/Capita',ylab='Percentage of Population with Internet Access')
predictions <- predict(model9, newdata=d)
lines(l, predictions, col=2)

# If we have time, let us see how much the high order polynomials vary
# when selecting a random subset of the points. THis is the "variance"
# of bias-variance tradeoff. 

