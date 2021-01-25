setwd ("C:/Users/Zhengkun/Downloads")

library(readxl)
data<-read_xlsx("2017_2_15_mid.xlsx")

# Black-Scholes IV apporoximation formula by Hagan(2002)
SABR.BSIV <- function(t, f, K, a, b, rho, n)
{
  numerator <- 1 + ((1-b)^2/24*a^2/f^(2-2*b) + 0.25*rho*b*n*a/f^(1-b) + (2-3*rho^2)*n^2/24)*t
  return(a*numerator/f^(1-b))
}

# Parameter calibration function for SABR
SABR.calibration <- function(t, f, K, sigMKT, b)
{
  # objective function for optimization
  # variables are transformed because of satisfing the constraint conditions
  
  objective <- function(x)
  {
    sum( (sigMKT - SABR.BSIV(t, f, K, x[1], b, x[3], x[4]))^2)
    }
  x <- nlm(objective, c(0.3, b, 0.0, 0.3))
  
  # return the optimized parameters
  
  parameter <- x$estimate
  parameter <- c(parameter[1], parameter[2], parameter[3], parameter[4])
  names(parameter) <- c("Alpha","Beta","Rho","Nu")
  return(list("parameter"=parameter,"Minimum"=x$minimum))
}

strike<- c(data[seq(2,38,by=2),7]/100) #Strike price= forward rate for Tao=4
vol <- c(data[seq(1,38,by=2),7]/100)   #volatility vector for Tao=4
Beta1 <- SABR.calibration(t=5,f=strike,K=strike,sigMKT=vol,b=0.4)$parameter
Beta2 <- SABR.calibration(t=5,f=strike,K=strike,sigMKT=vol,b=0.5)$parameter
Beta3 <- SABR.calibration(t=5,f=strike,K=strike,sigMKT=vol,b=0.7)$parameter


#a)-----------------------------
Beta2 #Beta=0.5

#b)-----------------------------
Beta1 #beta=0.4
Beta3 #beta=0.7

#c)----------------------------------------------------------------
be <- c(seq(from=0, to=0.9,by=0.1))

result <- data.frame()
for (i in 1:10) {
  result[i,1] <- SABR.calibration(t=4,f=strike,K=strike,sigMKT = vol,b=be[i])$parameter[1]
  result[i,2] <- be[i]
  result[i,3] <- SABR.calibration(t=4,f=strike,K=strike,sigMKT = vol,b=be[i])$parameter[3]
  result[i,4] <- SABR.calibration(t=4,f=strike,K=strike,sigMKT = vol,b=be[i])$parameter[4]
}
colnames(result) <- c("Alpha","Beta","Rho","Nu")
result #table for parameters of each beta
plot(result[,2],result[,1],type="l",col="green",ylim= c(-2,2.4),xlab="Beta",ylab="parameters")
lines(result[,2],result[,3],col="red")
lines(result[,2],result[,4],col="blue")
abline(v=0.4)
legend(0,2.3,legend=c("Alpha","rho","Nu"),col=c("Green","red","blue"),lty=1,lwd=3)

#d)----

error1 <- SABR.calibration(t=4,f=strike,K=strike,sigMKT=vol,b=0.4)$Minimum
error2 <- SABR.calibration(t=4,f=strike,K=strike,sigMKT=vol,b=0.5)$Minimum
error3 <- SABR.calibration(t=4,f=strike,K=strike,sigMKT=vol,b=0.7)$Minimum
error1 #Beta=0.4
error2 #Beta=0.5
error3 #Beta=0.7

#When beta is 0.4, error is the smallest. So, beta=0.4 is the best mod.

#e)----
strike2 <- c(data[seq(2,38,by=2),7]/100) #Strike price for Tao=5
vol2 <- c(data[seq(1,38,by=2),7]/100)    #Volatility for Tao=5
Bench <- c() #Vol for benchmark
error <- c() #error

for(i in 1:19) {
  error[i] <- abs(SABR.BSIV(5,strike2[i],strike2[i],Beta1[1],0.4,Beta1[3],Beta1[4])-vol2[i])
  Bench[i] <- SABR.BSIV(5,strike2[i],strike2[i],Beta1[1],0.4,Beta1[3],Beta1[4])
}
Bench
a <- seq(from=1, to=19,by=1)
plot(a,Bench,type="l",ylim=c(0.6,0.9))
points(a,vol2,col="blue")

