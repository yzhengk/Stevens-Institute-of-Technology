#Constants 
S0=100
V0 = 0.010201
C0 = 6.8061
kappa = 6.21
theta = 0.019
sigma = 0.61
rho = -0.7
r = 3.19/100
K=100
Tm=1

Absorption = function(S0, V0,C0,kappa,theta,sigma,rho, r, K,Tm, n, m)
{
  t1 = Sys.time()
  dt = Tm/n
  lnS = V = Vtemp = matrix(0, nrow = m, ncol = n+1)
  V[,1] = Vtemp[,1] = V0
  lnS[,1] = log(S0)
  C = c()
  for (i in 1:m)
  {
    for (j in 1:n)
    {
      epsilon = rnorm(1)
      dwt1 = epsilon * sqrt(dt)
      dwt2 = (rho * epsilon + sqrt(1-rho^2)*rnorm(1))*sqrt(dt)
      Vtemp[i,j+1] = max(Vtemp[i,j],0) - kappa*dt*(max(Vtemp[i,j],0) - theta)+ sigma*sqrt(max(Vtemp[i,j],0)) * dwt2 
      V[i,j+1] = max(Vtemp[i,j+1],0)
      lnS[i,j+1] = lnS[i,j]+(r-0.5*V[i,j])*dt + sqrt(V[i,j])*dwt1
    }
    C[i] = max(exp(lnS[i,n+1])-K, 0)*exp(-r*Tm)
  }
  price = mean(C)
  bias = mean(C) - C0
  RMSE = sqrt(bias^2+var(C))
  t2 = Sys.time()
  Time = as.numeric(t2-t1,units = "secs")
  result = list(price = price, bias = bias, 
                RMSE = RMSE, Time = Time)
  return(result)
}

Reflection = function(S0, V0,C0,kappa,theta,sigma,rho, r, K,Tm, n, m  )
{
  t1 = Sys.time()
  dt = Tm/n
  lnS = V = Vtemp = matrix(0, nrow = m, ncol = n+1)
  V[,1] = Vtemp[,1] = V0
  lnS[,1] = log(S0)
  C = c()
  for (i in 1:m)
  {
    for (j in 1:n)
    {
      epsilon = rnorm(1)
      dwt1 = epsilon * sqrt(dt)
      dwt2 = (rho * epsilon + sqrt(1-rho^2)*rnorm(1))*sqrt(dt)
      Vtemp[i,j+1] = abs(Vtemp[i,j]) - kappa*dt*(abs(Vtemp[i,j]) - theta)+ sigma*sqrt(abs(Vtemp[i,j])) * dwt2
      V[i,j+1] = abs(Vtemp[i,j+1])
      lnS[i,j+1] = lnS[i,j]+(r-0.5*V[i,j])*dt + sqrt(V[i,j])*dwt1
    }
    C[i] = max(exp(lnS[i,n+1])-K, 0)*exp(-r*Tm)
  }
  price = mean(C)
  bias = mean(C) - C0
  RMSE = sqrt(bias^2+var(C))
  t2 = Sys.time()
  Time = as.numeric(t2-t1,units = "secs")
  result = list(price = price, bias = bias, 
                RMSE = RMSE, Time = Time)
  return(result)
}
Highman = function(S0, V0,C0,kappa,theta,sigma,rho, r, K,Tm, n, m  )
{
  t1 = Sys.time()
  dt = Tm/n
  lnS = V = Vtemp = matrix(0, nrow = m, ncol = n+1)
  V[,1] = Vtemp[,1] = V0
  lnS[,1] = log(S0)
  C = c()
  for (i in 1:m)
  {
    for (j in 1:n)
    {
      epsilon = rnorm(1)
      dwt1 = epsilon * sqrt(dt)
      dwt2 = (rho * epsilon + sqrt(1-rho^2)*rnorm(1))*sqrt(dt)
      Vtemp[i,j+1] = Vtemp[i,j] - kappa*dt*(Vtemp[i,j] - theta)+ sigma*sqrt(abs(Vtemp[i,j])) * dwt2
      V[i,j+1] = abs(Vtemp[i,j+1])
      lnS[i,j+1] = lnS[i,j]+(r-0.5*V[i,j])*dt + sqrt(V[i,j])*dwt1
    }
    C[i] = max(exp(lnS[i,n+1])-K, 0)*exp(-r*Tm)
  }
  price = mean(C)
  bias = mean(C) - C0
  RMSE = sqrt(bias^2+var(C))
  t2 = Sys.time()
  Time = as.numeric(t2-t1,units = "secs")
  result = list(price = price, bias = bias, 
                RMSE = RMSE, Time = Time)
  return(result)
}
PartialTrun = function(S0, V0,C0,kappa,theta,sigma,rho, r, K,Tm, n, m  )
{
  t1 = Sys.time()
  dt = Tm/n
  lnS = V = Vtemp = matrix(0, nrow = m, ncol = n+1)
  V[,1] = Vtemp[,1] = V0
  lnS[,1] = log(S0)
  C = c()
  for (i in 1:m)
  {
    for (j in 1:n)
    {
      epsilon = rnorm(1)
      dwt1 = epsilon * sqrt(dt)
      dwt2 = (rho * epsilon + sqrt(1-rho^2)*rnorm(1))*sqrt(dt)
      Vtemp[i,j+1] = Vtemp[i,j] - kappa*dt*(Vtemp[i,j] - theta)+ sigma*sqrt(max(Vtemp[i,j],0)) * dwt2
      V[i,j+1] = max(Vtemp[i,j+1],0)
      lnS[i,j+1] = lnS[i,j]+(r-0.5*V[i,j])*dt + sqrt(V[i,j])*dwt1
    }
    C[i] = max(exp(lnS[i,n+1])-K, 0)*exp(-r*Tm)
  }
  price = mean(C)
  bias = mean(C) - C0
  RMSE = sqrt(bias^2+var(C))
  t2 = Sys.time()
  Time = as.numeric(t2-t1,units = "secs")
  result = list(price = price, bias = bias, 
                RMSE = RMSE, Time = Time)
  return(result)
}
FullTrun = function(S0, V0,C0,kappa,theta,sigma,rho, r, K,Tm, n, m  )
{
  t1 = Sys.time()
  dt = Tm/n
  lnS = V = Vtemp = matrix(0, nrow = m, ncol = n+1)
  V[,1] = Vtemp[,1] = V0
  lnS[,1] = log(S0)
  C = c()
  for (i in 1:m)
  {
    for (j in 1:n)
    {
      epsilon = rnorm(1)
      dwt1 = epsilon * sqrt(dt)
      dwt2 = (rho * epsilon + sqrt(1-rho^2)*rnorm(1))*sqrt(dt)
      Vtemp[i,j+1] = Vtemp[i,j] - kappa*dt*(max(Vtemp[i,j],0) - theta)+ sigma*sqrt(max(Vtemp[i,j],0)) * dwt2
      V[i,j+1] = max(Vtemp[i,j+1],0)
      lnS[i,j+1] = lnS[i,j]+(r-0.5*V[i,j])*dt + sqrt(V[i,j])*dwt1
    }
    C[i] = max(exp(lnS[i,n+1])-K, 0)*exp(-r*Tm)
  }
  price = mean(C)
  bias = mean(C) - C0
  RMSE = sqrt(bias^2+var(C))
  t2 = Sys.time()
  Time = as.numeric(t2-t1,units = "secs")
  result = list(price = price, bias = bias, 
                RMSE = RMSE, Time = Time)
  return(result)
}


Abs <- Absorption(S0,V0,C0,kappa,theta,sigma,rho,r,K,Tm,300,1000000)
Ref <-Reflection(S0,V0,C0,kappa,theta,sigma,rho,r,K,Tm,300,1000000)
Hig <-Highman(S0,V0,C0,kappa,theta,sigma,rho,r,K,Tm,300,1000000)
Par <- PartialTrun(S0,V0,C0,kappa,theta,sigma,rho,r,K,Tm,300,1000000)
Ful <-FullTrun(S0,V0,C0,kappa,theta,sigma,rho,r,K,Tm,300,1000000)


value<- rbind(Abs,Ref,Hig,Par,Ful)

value
