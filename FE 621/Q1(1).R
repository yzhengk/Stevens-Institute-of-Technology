
# (a)----
SMC = function(isCall, r, div, sig, S0, K, Tm, N, M)
{
    t1 = Sys.time()
    lnS = matrix(0, nrow = M, ncol = N+1)
    V = c()
    dt = Tm / N
    lnS[,1] = log(S0)
    cp = ifelse(isCall, 1, -1)
    nudt = (r-div-0.5*sig^2)*dt
    sigdt = sig * sqrt(dt)
    
    for (i in 1:M)
    {
        for (j in 1:N)
        {
            lnS[i,j+1] = lnS[i,j] + nudt + sigdt*rnorm(1)
        }
        V[i] = max( cp * ( exp(lnS[i,N+1]) - K), 0)*exp(-r*Tm) #discounted option value
        
    }
    value = mean(V)
    SD = sqrt((sum(V^2) - sum(V)^2/M) * exp(-2*r*Tm)/(M-1))
    SE = SD/sqrt(M)
    t2= Sys.time()
    return(list(value=value,SE = SE, time = t2 - t1))
}



# (b)----
AVMC <- function(isCall, r, div, sig, S0, K, Tm, N, M)
{
    t1 = Sys.time()
    lnS1 = lnS2 = matrix(0, nrow = M, ncol = N+1)
    V=c()
    dt = Tm/N
    lnS1[,1] = log(S0)
    lnS2[,1] = log(S0)
    cp = ifelse(isCall, 1, -1)
    nudt = (r-div-0.5*sig^2)*dt
    sigdt = sig*sqrt(dt)
    
    for( i in 1:M)
    {
        for(j in 1:N)
        {
            lnS1[i,j+1] = lnS1[i,j] + nudt + sigdt*rnorm(1)
            lnS2[i,j+1] = lnS2[i,j] + nudt + sigdt*(-rnorm(1))
        }
        V[i] = exp(-r*Tm)*(0.5 * (max( cp * ( exp(lnS1[i,N+1]) - K), 0) +max( cp * ( exp(lnS2[i,N+1]) - K), 0)) )
    }
    value = mean(V)
    SD = sqrt((sum(V^2) - sum(V)^2/M) * exp(-2*r*Tm)/(M-1))
    SE = SD/sqrt(M)
    t2 = Sys.time()
    return(list(value=value,SE = SE, time = t2 - t1))
}


BSDelta = function(isCall,S0, K, Tm, r, div, sig)
{
    cp = ifelse(isCall, 1, -1)
    d1 = (log(S0/K)+Tm*(r-div+0.5*sig^2))/(sig*sqrt(Tm))
    return(cp*pnorm(cp*d1))
}

Delta_based = function(isCall, r, div, sig, S0, K, Tm, N, M)
{
    t1 = Sys.time()
    dt = Tm/ N
    nudt = (r-div-0.5*sig^2) * dt
    sigdt = sig * sqrt(dt)
    erddt = exp((r-div) *dt)
    beta1 = -1
    S = matrix(0, nrow = M, ncol = N+1)
    S[,1] = S0
    V=c()
    cp = ifelse(isCall, 1, -1)
    
    for(i in 1:M)
    {
        cv = 0
        for (j in 1:N)
        {
            t = (j-1) *dt
            delta = BSDelta(isCall, S0 = S[i,j], K, Tm, r, div, sig)
            S[i,j+1] = S[i,j]*exp(nudt+sigdt*rnorm(1))
            cv = cv + delta*(S[i,j+1]-S[i,j]*erddt)
            
        }
        V[i] = (max(0, cp*(S[i,N+1]-K)) + beta1 * cv)*exp(-r*Tm)
    }
    value = mean(V)
    SD = sqrt((sum(V^2) - sum(V)^2/M) * exp(-2*r*Tm)/(M-1))
    SE = SD/sqrt(M)
    t2 = Sys.time()
    return(list(value=value,SE = SE, time = t2 - t1))
}

ADelta_based = function(isCall, r, div, sig, S0, K, Tm, N, M)
{
    t1 = Sys.time()
    dt = Tm/ N
    nudt = (r-div-0.5*sig^2) * dt
    sigdt = sig * sqrt(dt)
    erddt = exp((r-div) *dt)
    beta1 = -1
    S1 = S2 = matrix(0, nrow = M, ncol = N+1)
    S1[,1] = S0
    S2[,1] = S0
    V=c()
    cp = ifelse(isCall, 1, -1)
    for(i in 1:M)
    {
        cv1 = 0
        cv2 = 0
        for (j in 1:N)
        {
            t = (j-1) *dt
            delta1 = BSDelta(isCall, S0=S1[i,j], K, Tm, r, div, sig)
            delta2 = BSDelta(isCall, S0=S2[i,j], K, Tm, r, div, sig)
            S1[i,j+1] = S1[i,j]*exp(nudt+sigdt*rnorm(1))
            S2[i,j+1] = S2[i,j]*exp(nudt-sigdt*rnorm(1))
            cv1 = cv1 + delta1*(S1[i,j+1]-S1[i,j]*erddt)
            cv2 = cv2 + delta2*(S2[i,j+1]-S2[i,j]*erddt)
            
        }
        V[i] = (((max(0, cp*(S1[i,N+1]-K)) + beta1 * cv1) +
                    (max(0, cp*(S2[i,N+1]-K)) + beta1 * cv2))*0.5)*exp(-r*Tm)
    }
    value = mean(V)
    SD = sqrt((sum(V^2) - sum(V)^2/M) * exp(-2*r*Tm)/(M-1))
    SE = SD/sqrt(M)
    t2 = Sys.time()
    return(list(value=value,SE = SE, time = t2 - t1))
}

# generate a result table
set.seed(2018)
SMC_call = SMC( isCall = T ,r = 0.06, div = 0.03, sig = 0.2,
                S0 = 100, K = 100, Tm = 1, N = 300, M = 1000000)
set.seed(2018)
SMC_put = SMC( isCall = F ,r = 0.06, div = 0.03, sig = 0.2,
                S0 = 100, K = 100, Tm = 1, N = 300, M = 1000000)

set.seed(2018)
AVMC_call = AVMC(isCall = T ,r = 0.06, div = 0.03, sig = 0.2,
                S0 = 100, K = 100, Tm = 1, N = 300, M = 1000000)
set.seed(2018)
AVMC_put = AVMC(isCall = F ,r = 0.06, div = 0.03, sig = 0.2,
                S0 = 100, K = 100, Tm = 1, N = 300, M = 1000000)

set.seed(2018)
Delta_call = Delta_based(isCall = T ,r = 0.06, div = 0.03, sig = 0.2,
                S0 = 100, K = 100, Tm = 1, N = 300, M = 1000000)
set.seed(2018)
Delta_put = Delta_based(isCall = F ,r = 0.06, div = 0.03, sig = 0.2,
                S0 = 100, K = 100, Tm = 1, N = 300, M = 1000000)

set.seed(2018)
Anti_Delta_call = ADelta_based(isCall = T ,r = 0.06, div = 0.03, sig = 0.2,
                             S0 = 100, K = 100, Tm = 1, N = 300, M = 100000)
set.seed(2018)
Anti_Delta_put = ADelta_based(isCall = F ,r = 0.06, div = 0.03, sig = 0.2,
                             S0 = 100, K = 100, Tm = 1, N = 300, M = 100000)

price = rbind(SMC_call,AVMC_call,Delta_call,Anti_Delta_call,
              SMC_put,AVMC_put,Delta_put,Anti_Delta_put)
seed = c(rep(2018,8))
price = cbind(price,seed)
print(price)

