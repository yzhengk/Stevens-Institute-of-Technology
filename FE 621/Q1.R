
##a ----

library(Sim.DiffProc)
data <- read.csv("sample_data.csv")
data <- data.frame(data)

data1 <- data[,1]
data1<- ts(data1,frequency  = 365)

data2 <- data[,2]
data2 <- ts(data2,frequency  = 365)

data3 <- data[,3]
data3<- ts(data3,frequency  = 365)

data4 <- data[,4]
data4<- ts(data4,frequency  = 365)

data5 <- data[,5]
data5<- ts(data5,frequency  = 365)

#First column ----
# Model 1
fx <- expression( theta[1]*x )
gx <- expression( theta[2]*x^theta[3] )
mod <- fitsde(data=data1,drift=fx,diffusion=gx,start = 
                    list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 2
fx1 <- expression( theta[1]+theta[2]*x )
gx1 <- expression( theta[3]*x^theta[4] )
mod1 <- fitsde(data=data1,drift=fx1,diffusion=gx1,start = 
                 list(theta1=1, theta2=1,theta3=1,theta4=1),pmle="euler")
# Model3
fx2 <- expression( theta[1]+theta[2]*x )
gx2 <- expression( theta[3]*sqrt(x) )
mod2 <- fitsde(data=data1,drift=fx2,diffusion=gx2,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
## Model 4
fx3 <- expression( theta[1] )
gx3 <- expression( theta[2]*x^theta[3] )
mod3 <- fitsde(data=data1,drift=fx3,diffusion=gx3,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 5
fx4 <- expression( theta[1]*x )
gx4 <- expression( theta[2]+ theta[3]*x^theta[4] )
mod4 <- fitsde(data=data1,drift=fx4,diffusion=gx4,start=
                 list(theta1=1,theta2=1,theta3=1,theta4=1),pmle="euler")

#  Computes AIC
AIC <- c(AIC(mod),AIC(mod1),AIC(mod2),AIC(mod3),AIC(mod4))
Test <- data.frame(AIC,row.names = c("Mod1","Mod2","Mod3", "Mod4","Mod5"))
Test
Bestmod1 <- rownames(Test)[which.min(Test[,1])]
Bestmod1

# Best mod is Mod 1

#Second column ----
fx <- expression( theta[1]*x )
gx <- expression( theta[2]*x^theta[3] )
mod <- fitsde(data=data2,drift=fx,diffusion=gx,start = 
                list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 2
fx1 <- expression( theta[1]+theta[2]*x )
gx1 <- expression( theta[3]*x^theta[4] )
mod1 <- fitsde(data=data2,drift=fx1,diffusion=gx1,start = 
                 list(theta1=1, theta2=1,theta3=1,theta4=1),pmle="euler")
# Model3
fx2 <- expression( theta[1]+theta[2]*x )
gx2 <- expression( theta[3]*sqrt(x) )
mod2 <- fitsde(data=data2,drift=fx2,diffusion=gx2,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
## Model 4
fx3 <- expression( theta[1] )
gx3 <- expression( theta[2]*x^theta[3] )
mod3 <- fitsde(data=data2,drift=fx3,diffusion=gx3,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 5
fx4 <- expression( theta[1]*x )
gx4 <- expression( theta[2]+ theta[3]*x^theta[4] )
mod4 <- fitsde(data=data2,drift=fx4,diffusion=gx4,start=
                 list(theta1=1,theta2=1,theta3=1,theta4=1),pmle="euler")

#  Computes AIC
AIC <- c(AIC(mod),AIC(mod1),AIC(mod2),AIC(mod3),AIC(mod4))
Test <- data.frame(AIC,row.names = c("Mod1","Mod2","Mod3", "Mod4","Mod5"))
Test
Bestmod2 <- rownames(Test)[which.min(Test[,1])]
Bestmod2

# Best mod is mod1

#Third column ----
# Model 1
fx <- expression( theta[1]*x )
gx <- expression( theta[2]*x^theta[3] )
mod <- fitsde(data=data3,drift=fx,diffusion=gx,start = 
                    list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 2
fx1 <- expression( theta[1]+theta[2]*x )
gx1 <- expression( theta[3]*x^theta[4] )
mod1 <- fitsde(data=data3,drift=fx1,diffusion=gx1,start = 
                 list(theta1=1, theta2=1,theta3=1,theta4=1),pmle="euler")
# Model3
fx2 <- expression( theta[1]+theta[2]*x )
gx2 <- expression( theta[3]*sqrt(x) )
mod2 <- fitsde(data=data3,drift=fx2,diffusion=gx2,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
## Model 4
fx3 <- expression( theta[1] )
gx3 <- expression( theta[2]*x^theta[3] )
mod3 <- fitsde(data=data3,drift=fx3,diffusion=gx3,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 5
fx4 <- expression( theta[1]*x )
gx4 <- expression( theta[2]+ theta[3]*x^theta[4] )
mod4 <- fitsde(data=data3,drift=fx4,diffusion=gx4,start=
                 list(theta1=1,theta2=1,theta3=1,theta4=1),pmle="euler")

#  Computes AIC
AIC <- c(AIC(mod),AIC(mod1),AIC(mod2),AIC(mod3),AIC(mod4))
Test <- data.frame(AIC,row.names = c("Mod1","Mod2","Mod3", "Mod4","Mod5"))
Test
Bestmod3 <- rownames(Test)[which.min(Test[,1])]
Bestmod3
# Best mod is mod 1, mod3, mod4

#Forth column ----
# Model 1
fx <- expression( theta[1]*x )
gx <- expression( theta[2]*x^theta[3] )
mod <- fitsde(data=data4,drift=fx,diffusion=gx,start = 
                list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 2
fx1 <- expression( theta[1]+theta[2]*x )
gx1 <- expression( theta[3]*x^theta[4] )
mod1 <- fitsde(data=data4,drift=fx1,diffusion=gx1,start = 
                 list(theta1=1, theta2=1,theta3=1,theta4=1),pmle="euler")
# Model3
fx2 <- expression( theta[1]+theta[2]*x )
gx2 <- expression( theta[3]*sqrt(x) )
mod2 <- fitsde(data=data4,drift=fx2,diffusion=gx2,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
## Model 4
fx3 <- expression( theta[1] )
gx3 <- expression( theta[2]*x^theta[3] )
mod3 <- fitsde(data=data4,drift=fx3,diffusion=gx3,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 5
fx4 <- expression( theta[1]*x )
gx4 <- expression( theta[2]+ theta[3]*x^theta[4] )
mod4 <- fitsde(data=data4,drift=fx4,diffusion=gx4,start=
                 list(theta1=1,theta2=1,theta3=1,theta4=1),pmle="euler")

#  Computes AIC
AIC <- c(AIC(mod),AIC(mod1),AIC(mod2),AIC(mod3),AIC(mod4))
Test <- data.frame(AIC,row.names = c("Mod1","Mod2","Mod3", "Mod4","Mod5"))
Test
Bestmod4 <- rownames(Test)[which.min(Test[,1])]
Bestmod4
# Best mod is Mod 5

#Fifth column ----
# Model 1
fx <- expression( theta[1]*x )
gx <- expression( theta[2]*x^theta[3] )
mod <- fitsde(data=data5,drift=fx,diffusion=gx,start = 
                list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 2
fx1 <- expression( theta[1]+theta[2]*x )
gx1 <- expression( theta[3]*x^theta[4] )
mod1 <- fitsde(data=data5,drift=fx1,diffusion=gx1,start = 
                 list(theta1=1, theta2=1,theta3=1,theta4=1),pmle="euler")
# Model3
fx2 <- expression( theta[1]+theta[2]*x )
gx2 <- expression( theta[3]*sqrt(x) )
mod2 <- fitsde(data=data5,drift=fx2,diffusion=gx2,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
## Model 4
fx3 <- expression( theta[1] )
gx3 <- expression( theta[2]*x^theta[3] )
mod3 <- fitsde(data=data5,drift=fx3,diffusion=gx3,start = 
                 list(theta1=1, theta2=1,theta3=1),pmle="euler")
# Model 5
fx4 <- expression( theta[1]*x )
gx4 <- expression( theta[2]+ theta[3]*x^theta[4] )
mod4 <- fitsde(data=data5,drift=fx4,diffusion=gx4,start=
                 list(theta1=1,theta2=1,theta3=1,theta4=1),pmle="euler")

#  Computes AIC
AIC <- c(AIC(mod),AIC(mod1),AIC(mod2),AIC(mod3),AIC(mod4))
Test <- data.frame(AIC,row.names = c("Mod1","Mod2","Mod3", "Mod4","Mod5"))
Test
Bestmod5 <- rownames(Test)[which.min(Test[,1])]
Bestmod5
# Best mod is Mod1



#b----
#First column (Mod1)----
modE1 <- fitsde(data1,drift = fx,diffusion = gx,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1))
modK1 <- fitsde(data1,drift = fx,diffusion = gx,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1))
modO1 <- fitsde(data1,drift = fx,diffusion = gx,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1))
modS1 <- fitsde(data1,drift = fx,diffusion = gx,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1))
aic <- c(AIC(modE1),AIC(modK1),AIC(modO1),AIC(modS1))
bic <- c(BIC(modE1),BIC(modK1),BIC(modO1),BIC(modS1))
coef1 <- data.frame(coef(modE1),coef(modK1),coef(modO1),coef(modS1))
coef1[4,] <- aic
coef1[5,] <- bic
rownames(coef1) <- c("theta1","theta2","theta3","AIC","BIC")
colnames(coef1) <- c("Euler","Kessler","Ozaki","Shoji")
coef1
#Euler the best method


#Second column (Mod1)----
modE2 <- fitsde(data2,drift = fx,diffusion = gx,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1))
modK2 <- fitsde(data2,drift = fx,diffusion = gx,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1))
modO2 <- fitsde(data2,drift = fx,diffusion = gx,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1))
modS2 <- fitsde(data2,drift = fx,diffusion = gx,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1))
aic <- c(AIC(modE2),AIC(modK2),AIC(modO2),AIC(modS2))
bic <- c(BIC(modE2),BIC(modK2),BIC(modO2),BIC(modS2))
coef2 <- data.frame(coef(modE2),coef(modK2),coef(modO2),coef(modS2))
coef2[4,] <- aic
coef2[5,] <- bic
rownames(coef2) <- c("theta1","theta2","theta3","AIC","BIC")
colnames(coef2) <- c("Euler","Kessler","Ozaki","Shoji")
coef2
#Bestmethod is Kessler

#Third column (Mod1,3,4)----
modE3 <- fitsde(data3,drift = fx,diffusion = gx,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1))
modK3 <- fitsde(data3,drift = fx,diffusion = gx,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1))
modO3 <- fitsde(data3,drift = fx,diffusion = gx,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1))
modS3 <- fitsde(data3,drift = fx,diffusion = gx,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1))
aic <- c(AIC(modE3),AIC(modK3),AIC(modO3),AIC(modS3))
bic <- c(BIC(modE3),BIC(modK3),BIC(modO3),BIC(modS3))
coef3 <- data.frame(coef(modE3),coef(modK3),coef(modO3),coef(modS3))
coef3[4,] <- aic
coef3[5,] <- bic
rownames(coef3) <- c("theta1","theta2","theta3","AIC","BIC")
colnames(coef3) <- c("Euler","Kessler","Ozaki","Shoji")
coef3
#Can't tell which method is best.

modE33 <- fitsde(data3,drift = fx2,diffusion = gx2,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1))
modK33 <- fitsde(data3,drift = fx2,diffusion = gx2,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1))
modO33 <- fitsde(data3,drift = fx2,diffusion = gx2,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1))
modS33 <- fitsde(data3,drift = fx2,diffusion = gx2,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1))
aic <- c(AIC(modE33),AIC(modK33),AIC(modO33),AIC(modS33))
bic <- c(BIC(modE33),BIC(modK33),BIC(modO33),BIC(modS33))
coef33 <- data.frame(coef(modE33),coef(modK33),coef(modO33),coef(modS33))
coef33[4,] <- aic
coef33[5,] <- bic
rownames(coef33) <- c("theta1","theta2","theta3","AIC","BIC")
colnames(coef33) <- c("Euler","Kessler","Ozaki","Shoji")
coef33

#Best method is Euler.

modE34 <- fitsde(data3,drift = fx3,diffusion = gx3,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1))
modK34 <- fitsde(data3,drift = fx3,diffusion = gx3,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1))
modO34 <- fitsde(data3,drift = fx3,diffusion = gx3,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1))
modS34 <- fitsde(data3,drift = fx3,diffusion = gx3,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1))
aic <- c(AIC(modE34),AIC(modK34),AIC(modO34),AIC(modS34))
bic <- c(BIC(modE34),BIC(modK34),BIC(modO34),BIC(modS34))
coef34 <- data.frame(coef(modE34),coef(modK34),coef(modO34),coef(modS34))
coef34[4,] <- aic
coef34[5,] <- bic
rownames(coef34) <- c("theta1","theta2","theta3","AIC","BIC")
colnames(coef34) <- c("Euler","Kessler","Ozaki","Shoji")
coef34

#Cannot tell.

#Forth column (Mod5)----
modE4 <- fitsde(data4,drift = fx4,diffusion = gx4,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1,theta4=1))
modK4 <- fitsde(data4,drift = fx4,diffusion = gx4,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1,theta4=1))
modO4 <- fitsde(data4,drift = fx4,diffusion = gx4,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1,theta4=1))
modS4 <- fitsde(data4,drift = fx4,diffusion = gx4,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1,theta4=1))
aic <- c(AIC(modE4),AIC(modK4),AIC(modO4),AIC(modS4))
bic <- c(BIC(modE4),BIC(modK4),BIC(modO4),BIC(modS4))
coef4 <- data.frame(coef(modE4),coef(modK4),coef(modO4),coef(modS4))
coef4[5,] <- aic
coef4[6,] <- bic
rownames(coef4) <- c("theta1","theta2","theta3","theta4","AIC","BIC")
colnames(coef4) <- c("Euler","Kessler","Ozaki","Shoji")
coef4
#Best method is Euler


#Fifth column (Mod1)----
modE5 <- fitsde(data5,drift = fx,diffusion = gx,pmle = "euler",
                start = list(theta1=1,theta2=1,theta3=1))
modK5 <- fitsde(data5,drift = fx,diffusion = gx,pmle = "kessler",
                start = list(theta1=1,theta2=1,theta3=1))
modO5 <- fitsde(data5,drift = fx,diffusion = gx,pmle = "ozaki",
                start = list(theta1=1,theta2=1,theta3=1))
modS5 <- fitsde(data5,drift = fx,diffusion = gx,pmle = "shoji",
                start = list(theta1=1,theta2=1,theta3=1))
aic <- c(AIC(modE5),AIC(modK5),AIC(modO5),AIC(modS5))
bic <- c(BIC(modE5),BIC(modK5),BIC(modO5),BIC(modS5))
coef5 <- data.frame(coef(modE5),coef(modK5),coef(modO5),coef(modS5))
coef5[4,] <- aic
coef5[5,] <- bic
rownames(coef5) <- c("theta1","theta2","theta3","AIC","BIC")
colnames(coef5) <- c("Euler","Kessler","Ozaki","Shoji")
coef5
#Best method is Kessler





