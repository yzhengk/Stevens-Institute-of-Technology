#a)----
cholesky <- function(x) {
  x <- chol(x)
  return(t(x)) #return lower triangular matrix
}
a <- matrix(c(1,0.5,0.2,0.5,1,-0.4,0.2,-0.4,1),nrow = 3,ncol = 3)
R <- cholesky(a)
R

#b) ----
S0 = c(100,101,98)
nu = c(0.03,0.06,0.02)
sig = c(0.05,0.2,0.15)
Tm=100/365
n = 100
m=1000
dt = Tm/n
St1=St2=St3 = matrix(0,nrow = n+1, ncol = m)
lnSt1 = lnSt2 = lnSt3 = c()
St1[1,] = S0[1]
St2[1,] = S0[2]
St3[1,] = S0[3]
price = array(0,dim = c(3,101,1000))  # three dimensional array
set.seed(2017)
for(j in 1:m){
  lnSt1[1] = log(S0[1])
  lnSt2[1] = log(S0[2])
  lnSt3[1] = log(S0[3])
  price[1,1,] = S0[1]
  price[2,1,] = S0[2]
  price[3,1,] = S0[3]
  
  
  for(i in 1:n){
      dx = c(rnorm(1),rnorm(1),rnorm(1))  # generate three random number
      dbt = R %*% dx*sqrt(dt)  #dwt part for the monte carlo function
      lnSt1 = lnSt1 + nu[1]*dt + sig[1]*dbt[1] #generate three correlated BM
      lnSt2 = lnSt2 + nu[2]*dt + sig[2]*dbt[2]
      lnSt3 = lnSt3 + nu[3]*dt + sig[3]*dbt[3]
      
      St1[i+1,j] = exp(lnSt1)
      St2[i+1,j] = exp(lnSt2)
      St3[i+1,j] = exp(lnSt3)
      price[1,i+1,j] = St1[i+1,j]  # put the results in the three-dimensional matrix
      price[2,i+1,j] = St2[i+1,j]
      price[3,i+1,j] = St3[i+1,j]
      
  }
  
}
day1 <- seq(from = 1,to = 101,by = 1)
day2 <- seq(from = 1,to = 101,by = 1)
day3 <- seq(from = 1,to = 101,by = 1)

#plot three-dimensional 
install.packages("scatterplot3d")
library(scatterplot3d)
myplot <- scatterplot3d(day3,rep(3,101),price[3,,50],xlab = "days",ylab = "asset",zlab = "stock price",xlim = c(0,101),ylim = c(0,3),zlim = c(90,115),color ="red",pch=20)
myplot$points3d(day2,rep(2,101),price[2,,50],col="blue",pch=20)
myplot$points3d(day1,rep(1,101),price[1,,50],col="green",pch=20)

plot(x=day1,y=price[1,,50],ylim=c(90,115),type = "l",col="green",xlab = "Days",ylab = "stocks")
lines(x=day2,y=price[2,,50],col="blue")
lines(x=day3,y=price[3,,50],col = "red")


#c)----
U_call <- c()
U_put <- c()
value <- c()
for (i in 1:1000) {
  value[i] <- (price[1,101,i] + price[2,101,i] + price[3,101,i])/3
  U_call[i] <- max((value[i] - 100),0)
  U_put[i] <- max((100 - value[i]),0)
}
U_call1 = mean(U_call) 
U_put1 = mean(U_put)
U_call1
U_put1

#d) ----
B=104
K =100
C = c()
for (j in 1:1000)
{
  if (max(price[2,,j]) > B)
  {
    C[j] = max(price[2,101,j] - K, 0)
  } else 
  {
    if (max(price[2,,j]) > max(price[3,,j]))
    {
      C[j] = (max(price[2,101,j] - K, 0))^2
    } else 
    {
      if (mean(price[2,,j]) > mean(price[3,,j]))
      {
        C[j] = max(mean(price[2,,j]) - K, 0)
      } else 
      {
        Ut = (price[1,101,j]+price[2,101,j]+price[3,101,j])/3
        C[j] = max(Ut-K, 0)
      }
    }
  }
}
cat("The option price is",mean(C))

