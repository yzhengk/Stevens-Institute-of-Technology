#Q3 ----
install.packages("pracma")
library(pracma)

#The characteristic function of Black-Scholes model
cha<-function(S0,mu,sig,Tao,u){
  i=complex(real=0,imaginary=1)
  x=exp(i*u*(log(S0)+(mu-((sig**2)/2))*T)-(((sig**2)*Tao*(u**2))/2))
  return(x)
}

fftfunc <- function(r,S0,mu,sig,Tao,alpha,K)
  {
    i=complex(real=0,imaginary=1)
    A <- function(v)
    {
      Re(cha(S0,mu,sigma,Tao,v-i)*exp(-i*v*log(K))/(i*v*cha(S0,mu,sig,Tao,-i)))
    }
    B <- function(v)
    {
      Re(cha(S0,mu,sig,Tao,v)*exp(-i*v*log(K))/(i*v))
    }
    pi1=1/2+1/pi*simpadpt(A,a = 0,b = 2^11,tol=1e-6)
    pi2=1/2+1/pi*simpadpt(B,a=0,b=2^11,tol=1e-6)
    return(S0*pi1-K*exp(-r*Tao)*pi2)
}

#Black scholes
BS<-function(S0, K, Tao, r, sig){
  d1<-(log(S0/K)+r*Tao+(sig^2)*0.5*Tao)/(sig*sqrt(Tao))
  d2<-d1-sig*sqrt(Tao)
  
  value<-S0*pnorm(d1)-exp(-r*Tao)*K*pnorm(d2)
  return(value)
}

error <- fftfunc(r=0.01,S0=1,mu=0.01,sig=0.5,Tao=1,alpha=2,K=1)-
  BS(S0=1,K=1,Tao=1,r=0.01,sig=0.5)
error
