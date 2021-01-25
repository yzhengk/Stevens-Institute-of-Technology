
# coding: utf-8

# In[10]:


import numpy as np
from math import log,sqrt,exp
from scipy.stats import norm

class BSM_option_pricing:
    def opt_price(self,t,S0,K,r,sigma,Type):
        d1 = (log(S0/K) + ((r + ((sigma**2)/2))*t))/(sigma*sqrt(t))
        d2 = (log(S0/K) + ((r - ((sigma**2)/2))*t))/(sigma*sqrt(t))
        if Type == 'call':
            return S0*norm.cdf(d1) - K*exp((-r)*t)*norm.cdf(d2)
        elif Type == 'put':
            return K*exp((-r)*t)*norm.cdf(-d2) - S0*norm.cdf(-d1)
        else:
            return 'Please type in the correct type of option!'


# In[7]:


call1 = BSM_option_pricing('call')
print('%.2f' % call1.opt_price(30/252,100,100,0.05,0.2))
put1 = BSM_option_pricing('put')
print('%.2f' % put1.opt_price(30/252,100,100,0.05,0.2))
error = BSM_option_pricing('Call')
error.opt_price(30/252,100,100,0.05,0.2)


# In[11]:


########### check put-call parity holds
class check_putcall_parity(BSM_option_pricing):
    def check(self,t,S0,K,r,sigma):
        call = BSM_option_pricing.opt_price(self,t=t,S0=S0,K=K,r=r,sigma=sigma,Type='call')
        put = BSM_option_pricing.opt_price(self,t=t,S0=S0,K=K,r=r,sigma=sigma,Type='put')
        if (call-put) == (S0 - K*exp(-r*t)):
            print('Put Call Parity holds!')
        else:
            print('Put Call Parity does not hold!')


# In[12]:


chk1 = check_putcall_parity()


# In[13]:


chk1.check(30/252,100,100,0.05,0.2)


# In[19]:


import pandas as pd
goog_data = pd.read_csv('google.csv')
print(goog_data.head(30))


# In[33]:


### bisection method
def BSM_option(t,S0,K,r,sigma,Type):
    d1 = (log(S0/K) + ((r + ((sigma**2)/2))*t))/(sigma*sqrt(t))
    d2 = (log(S0/K) + ((r - ((sigma**2)/2))*t))/(sigma*sqrt(t))
    if Type == 'call':
        return S0*norm.cdf(d1) - K*exp((-r)*t)*norm.cdf(d2)
    elif Type == 'put':
        return K*exp((-r)*t)*norm.cdf(-d2) - S0*norm.cdf(-d1)
    else:
        return 'Please type in the correct type of option!'


def bisec(func,a,b,tol):
    iter_time = 0
    temp = b - a
    while(temp>=tol):
        c = np.mean([a,b])
        if func(c)*func(a) > 0:
            a = c
        elif func(c)*func(b) > 0:
            b = c 
        else:
            break
        iter_time += 1
        temp = b - a
    return [c,iter_time]
'''
def implied_vol(price,t,S0,K,r,Type='call',a=-1,b=1,tol=1e-6):
    def func1(x):
        return BSM_option(t,S0,K,r,x,Type)-price
    output = bisec(func1,a,b,tol)
    return output
goog_data['imp_vol'] = goog_data.apply(implied_vol,axis=1,
                                      args = ('last price',
                                             'maturity',
                                             'S0','strike','r'))
'''

def iv(data,Type='call',a=-1,b=1,tol=1e-6):
    def func1(x):
        return BSM_option(data['maturity'],data['S0'],data['strike'],
                          data['r'],x,Type)-data['last price']
    output = bisec(func1,a,b,tol)[0]
    return output
goog_data['imp_vol'] = goog_data.apply(iv,axis=1)


# In[35]:


### secant method
def secant(func,a,b,tol):
    iter_time = 0
    temp = b - a
    while(abs(temp)>=tol):
        c = b - func(b)*(b-a)/(func(b)-func(a))
        a = b
        b = c
        temp = b - a
        iter_time += 1
    return [c,iter_time]
        
def iv2(data,Type='call',a=-1,b=1,tol=1e-6):
    def func1(x):
        return BSM_option(data['maturity'],data['S0'],data['strike'],
                          data['r'],x,Type)-data['last price']
    output = secant(func1,a,b,tol)[0]
    return output   
goog_data['imp_vol2'] = goog_data.apply(iv2,axis=1)


# In[39]:


get_ipython().run_line_magic('matplotlib', 'inline')
dif = goog_data['imp_vol'] - goog_data['imp_vol2']
dif.plot()


# In[1]:


# cal greeks
from math import pi,log,sqrt,exp
from scipy.stats import norm
def greek_calculation(t,S0,K,r,sigma):
    d1 = (log(S0/K)+((r+((sigma**2)/2))*t))/(sigma*sqrt(t))
    delta = norm.cdf(d1)
    gamma = exp(-(d1**2)/2)/(S0*sigma*sqrt(t*2*pi))
    vega = S0*sqrt(t/2/pi)/exp(-(d1**2)/2)
    return [delta,gamma,vega]
greek_calculation(30/252,100,100,0.05,0.2)


# # Question 2

# In[28]:


# trapezoid Rule
from math import sin
def trapezoid(a,b,func,n):
    dx = (b-a)/n
    inner = []
    for i in range(n+1):
        if i==0:
            inner.append(func(a))
        elif i == n:
            inner.append(func(b))
        else:
            inner.append(2*func(a+i*dx))
    return (dx/2)*sum(inner)

def f(x):
    return 1 if x==0 else sin(x)/x

trape1 = trapezoid(-1e6,1e6,f,10**6)
print(trape1)


# In[30]:


# simpson's rule
def simpson(a,b,func,n):
    dx = (b-a)/n
    inner = []
    for i in range(n+1):
        if i==0:
            inner.append(func(a))
        elif i == n:
            inner.append(func(b))
        else:
            if i%2 == 0:
                inner.append(2*func(a+i*dx))
            else:
                inner.append(4*func(a+i*dx))
    return (dx/3)*sum(inner)
simp1 = simpson(-1e6,1e6,f,10**6)
print(simp1)
            


# In[33]:


#find out accuracy while N or a,b increase
# N fixed, a,b increase
print('orginal: Trape:{0}, Simp:{1}'.format(trape1-pi,simp1-pi))
a1,b1,N1 = -1e7,1e7,10**6
trape2 = trapezoid(a1,b1,f,N1)-pi
simp2 = simpson(a1,b1,f,N1)-pi
print('a,b increase: Trape:{0}, Simp:{1}'.format(trape2,simp2))
#a,b fixed, N increases
a2,b2,N2 = -1e6,1e6,10**7
trape3 = trapezoid(a2,b2,f,N2)-pi
simp3 = simpson(a2,b2,f,N2)-pi
print('N increase: Trape:{0}, Simp:{1}'.format(trape3,simp3))


# In[39]:


set_diff = 1
epsilon = 1e-4
a = -1e6; b = 1e6
N_now = 10**6
while set_diff>=epsilon:
    set_diff = abs(trapezoid(a,b,f,int(N_now))-trapezoid(a,b,f,int(N_now)-1))
    N_now= N_now*1.01
N_now_1 = int(N_now/1.01)
I1 = trapezoid(a,b,f,N_now_1)
print(I1)


N_now = 10**6;set_diff = 1
while set_diff>=epsilon:
    set_diff = abs(simpson(a,b,f,int(N_now))-simpson(a,b,f,int(N_now)-1))
    N_now= N_now*1.01
N_now_2 = int(N_now/1.01)
I2 = simpson(a,b,f,N_now_2)
print(I2)


# In[42]:


def f2(x):
    return 1+exp(-x)*sin(8*(x**(2/3)))
set_diff = 1
epsilon = 1e-4
a = 0; b = 2
N_now = 10**6
while set_diff>=epsilon:
    set_diff = abs(trapezoid(a,b,f2,int(N_now))-trapezoid(a,b,f2,int(N_now)-1))
    N_now= N_now*1.01
N_now_1 = int(N_now/1.01)
I3 = trapezoid(a,b,f2,N_now_1)
print(I3)


N_now = 10**6;set_diff = 1
while set_diff>=epsilon:
    set_diff = abs(simpson(a,b,f2,int(N_now))-simpson(a,b,f2,int(N_now)-1))
    N_now= N_now*1.01
N_now_2 = int(N_now/1.01)
I4 = simpson(a,b,f2,N_now_2)
print(I4)


# # Question 3
# # Heston Model

# In[57]:


s0 = 1; Mat = 5; r=0; v0=0.1;theta = 0.1; sigma = 0.2;rho=-0.3;lamda=0;
N = 150000; 
kappa = 1; K = 1.5
def heston(phi,s0,Mat,r,kappa,theta,sigma,rho,lamda,v0,j):
    if j == 1:
        b = kappa+lamda-rho*sigma
        u = 0.5
    elif j == 2:
        b = kappa + lamda
        u = -0.5
    d = sqrt((complex(0,rho*sigma*phi)-b)**2-sigma**2*(complex(0,2*u*phi)-phi**2))
    g = (b-complex(0,-rho*sigma*phi)+d)/(b-complex(0,-rho*sigma*phi)-d)
    C = complex(0,r*phi)*Mat + (kappa*theta/sigma**2)*((b-complex(0,rho*sigma*phi)+d)*Mat-
                                                      2*log((1-g*exp(d*Mat))/(1-g)))
    D = ((b-complex(0,rho*sigma*phi)+d)/(sigma**2))*((1-exp(d*Mat))/(1-g*exp(d*Mat)))
    outcome = exp(C+D*v0+complex(0,1)*phi*s0)
    if outcome == np.NAN:
        return complex(0,0)
    else:
        return outcome
limit1 = 1e-10
limit2 = 150
def price(limit1,limit2,N,K,s0,Mat,r,kappa,theta,sigma,rho,lamda,v0):
    def Re1(x):
        xixi = (exp(complex(0,-1)*x*log(K))*heston(x,s0,Mat,r,kappa,theta,sigma,
                                                rho,lamda,v0,1)/(complex(0,1)*x)).real
        
    def Re2(x):
        return (exp(complex(0,-1)*x*log(K))*heston(x,s0,Mat,r,kappa,theta,sigma,
                                                rho,lamda,v0,2)/(complex(0,1)*x)).real
    
        
    P1 = 1/2 + (1/pi)*simpson(limit1,limit2,Re1,N)
    P2 = 1/2 + (1/pi)*simpson(limit1,limit2,Re2,N)
    call = s0*P1 - K*exp(-r*Mat)*P2
    put = call - s0 + K*exp(-r*Mat)
    return [call,put]


# http://www-users.math.umn.edu/~bemis/IMA/MMI2008/calibrating_heston.pdf


# In[58]:


test = price(limit1,limit2,N,K,s0,Mat,r,kappa,theta,sigma,rho,lamda,v0)


# In[55]:


#https://github.com/MacJack24/Heston/blob/master/HestonPricing.ipynb


# In[60]:




