
############################
#L3- R Session II
#Author: Xingjia Zhang
#Content: 
# 1. decision making
# 2. loop
# 3. input/output of data
# 4. visualization
###########################



######################### Decision making ##########################################
# if
a = 2
if(a>1){print("a is larger than 1")}
if(a>1){print("a is larger than 1")}else{print("a is not larger than 1")}

# if elseif else
x = c(21,32,5,43,6,2,66,12,22,43) # if we want to see if any number less than 3 is in x

if(1 %in% x) {# 
  print("x contains 1")
} else if ("2" %in% x) {
  print("x contains 2")
} else {
  print("all number in x is larger than 2")
}
#------ additional infomation for %in% --------------
1:10 %in% c(1,3,5,9)# %in% returns a logical vector indicating if there is a match or not for its left operand
sstr = c("c","ab","B","bba","c",NA,"@","bla","a","Ba","%")
sstr %in% c(letters, LETTERS)
sstr[sstr %in% c(letters, LETTERS)]

aVec = c(4,5,6) 
aVec[c(1,2)] # return first two values in a
aVec[c(TRUE,TRUE,FALSE)]# return first two values in a 


-------------------------------------
# switch
x = switch( # if the value evaluated is a number, that item of the list is returned
  3,
  "first",
  "second",
  "third",
  "fourth"
)
x = switch( # if the value is out of range, NULL is returned
  5,
  "first",
  "second",
  "third",
  "fourth"
)

x = switch(
  "first",
  first="0",
  second="00",
  third="000",
  fourth="0000"
) # matching named item's value is returned

centre <- function(x, type) {
  switch(type,
         mean = mean(x),
         median = median(x),
         trimmed = mean(x, trim = .1))
}
x <- rcauchy(50)#  generate 50 random numbers based on he Cauchy distribution
centre(x, "mean")
centre(x, "median")
centre(x, "trimmed")

###################### Loop ############################3
# repeat loop
a = c("Hello")
cnt = 1

repeat{
  print(a)
  cnt = cnt + 1
  if(cnt>5){break} # When the break is inside a loop, the loop is immediately terminated, and...
  # goes to the next statement following the loop
}

# while loop
a = c(1,23,4,5,5)
cnt = 1
while(cnt<length(a)){
  print(a[cnt])
  cnt = cnt+1
}

# repeat vs while
# repeat loop checks the condition at the end of each iteration while while loop checks it at 
# the beginning of each iteration. So repeat loop executes at least one iteration while while 
# loop may not execute any iterations if the condition is not fulfilled.

# for loop
for (i in seq(1,5)){ # seq(from = , to = ) generates regular sequences
  print (i/2)
}

for (i in 1:5){
  print(i)
}

# while vs for loop? 


# nesting for loop
# matrix1 = matrix(nrow=3,ncol=3)

for(i in 1:3){
  print(paste("row",i))
  for (j in 1:3){
    print (paste("column",j))
  }
}

# example: matrix dot product
dotProduct = function(m1,m2){ # matrix multiplication
  mat = matrix(nrow = dim(m1)[1], ncol = dim(m2)[2])
  for(i in 1:dim(m1)[1]){
    for (j in 1:dim(m2)[2]){
      mat[i,j] = sum(m1[i,]*m2[,j])
    }
  }
  return(mat)
}  


mat1 = matrix( 
     c(2, 4, 3, 1, 5, 7), # the data elements 
     nrow=2,              # number of rows 
     ncol=3,              # number of columns 
     byrow = TRUE)

mat2 = matrix( 
     c(2, 4, 3, 1, 5, 7), # the data elements 
     nrow=3,              # number of rows 
     ncol=2,              # number of columns 
     byrow = TRUE)

dotProduct(mat1, mat2)

############################### Loop control statement ################################33
# break: When inside a loop, the loop is immediately terminated and program control resumes at 
# the next statement following the loop.

for(i in 1:5){
  if(i<3){print(i)}
  else{break}
}


# next: skips further evaluation and starts next iteration of the loop.
v <- LETTERS[1:6]
for ( i in v) {
  if (i == "D") {
    next
  }
  print(i)
}

################################## Reading data in a file ###############################3
# 1. read from RData
datdata <- load("c:/users/xingjia zhang/desktop/test.Rdata")
# 2. read from txt a data table can resides in a text file. the cells inside the table are separated by blank characters.
tabledata = read.table("c:/users/xingjia zhang/desktop/tabledata.txt")
# if the format of txt is not easy to read
txtdata = readLines("c:/users/xingjia zhang/desktop/tabledata.txt") # returns a character vector with one element for each line
# 3. read from excel
install.packages("XLConnect") # The XLConnect package requires Java to be pre-installed. 
library(XLConnect) # load package
myfile = loadWorkbook("c:/users/xingjia zhang/desktop/mydata.xlsx")
mysheet = readWorksheet(myfile, sheet = "Sheet1")
# 4. from csv
appl = read.csv(file = "c:/users/xingjia zhang/desktop/AAPL.csv", head = TRUE, sep = ",") 


getwd() # default working directory is "c:/windows/system"
# method 1: specify file directory
appl = read.csv(file = "C:/Users/Xingjia Zhang/Dropbox/My document/2. Teaching/1. FE513/FE513/L3-R II/AAPL.csv", head = TRUE, sep = ",")
# method 2: change working directory
setwd("C:/Users/Xingjia Zhang/Dropbox/My document/2. Teaching/1. FE513/FE513/L3-R II")
goog = read.csv(file = "GOOG.csv", head = T)

# 5. from web
thepage = readLines("http://stevensducks.com/schedule.aspx?path=baseball")
mypattern = 'img class="lazy" alt='#  search for matches to argument 
datalines = grep(mypattern,thepage,value=TRUE)# now get the lines where our data is. grep() searches for matches to argument pattern within each element of a character vector
getString = function(data){
  for (val in data){
    index1 = gregexpr(pattern = '=', val)[[1]][2]# get index of = in the string
    index2 = gregexpr(pattern = '=', val)[[1]][3]
    str = substring(val, index1+2, index2-6)
    print (str)
  }
}
getString(datalines)



###############################33 Visualization ###############################
# two lines
# Create data:
a=c(1:5)
b=c(5,3,4,5,5)
c=c(4,5,4,3,1)

# Make a basic graph
# type: p-points, l-lines, b-both
plot( b~a , type="o" , col = rgb(0/255,80/255,230/255,255/255), lwd=3 ) 
# the thing on the left of the tild(~) is the response and the things on the right of the tild are the explanatory variables

#Possible types are:
#"l" for lines,
#"p" for points,
#"b" for both,
#"c" for the lines part alone of "b",
#"o" for both 'overplotted',
#"h" for 'histogram' like (or 'high-density') vertical lines,
#"s" for stair steps
# lwd = line width
# rgb(red, green, blue, alpha): the optional alpha values range from 0 (fully transparent) to 1 (opaque).
# RGB color system constructs all the colors from the combination of the Red, Green and Blue colors.
# The red, green and blue have integer values from 0 to 255. This makes 256*256*256=16777216 possible colors.
# rgb color code: http://www.rapidtables.com/web/color/RGB_Color.htm

lines(c ~a  , col = rgb(0/255,0/255,153/255,255/255), lwd=3 , type="l" )

# Add a legend
legend("bottomleft", 
       col = c(rgb(1,1,0,1),  rgb(0,0,1,1)),
       legend = c("line 1", "line 2"),
       lwd = c(3,3))

# position keywords: bottom, bottomright,bottomleft, left, right, center, top, topright 

# Use the title( ) function to add labels to a plot
title(main="main title", sub = "sub title",
      xlab="x-axis label", ylab="y-axis label")
dev.off()

plot( b~a , type="l" , col = rgb(0/255,80/255,230/255,255/255), lwd=3, 
      main="main title", sub = "sub title",xlab="x-axis label", ylab="y-axis label") 
dev.off()

# xlim, ylim can set the ranges of axis
plot( b~a , type="l" , col = rgb(150/255,10/255,100/255,255/255), lwd=3,
      xlim=c(0, 5), ylim=c(0, 10)) 


# histogram: visualize variable distribution 
rand = rnorm(100) # generate random numbers whose distribution is normal
hist(rand) # histogram of the data. main = title. xlab = label of x axis. 
histinfo = hist(rand)
histinfo
dev.off()
# Here I specify plot=FALSE because I just want the histogram output, not the plot
histinfo2 = hist(rand, plot = FALSE)
histinfo2
# R chooses how to bin your data for you by default using an algorithm, 
# but if you want coarser or finer groups, there are a number of ways to do this
# number of bins may significantly change the shape of distribution
hist(rand, breaks =20) # set number of bins. 
# If you want more control over exactly the breakpoints between bins, you can be more precise with the breaks() option and give it a vector of breakpoints, like this:
hist(rand, breaks=c(-5,-3,-1,1,3,5))
hist(rand, breaks=seq(-5,5,by=2))
hist(rand, breaks =20, main = "Histogram of normal distribution")
hist(rand, breaks = 20, main = "Histogram of normal distribution", xlim=c(0,10)) # xlim= size of domain

# Instead of counting the number of datapoints per bin, R can give the probability densities using the freq=FALSE option:
hist(rand, freq=FALSE) # the height of each rectangle is proportional to the number of points falling into the cell, and thus the sum of the probability densities adds up to 1.
#  add a nice normal distribution curve to this plot using the curve() function
curve(dnorm(x, mean=mean(rand), sd=sd(rand)), add=TRUE, lwd=2) 

# boxplots: provides a graphical view of the median, quartiles, maximum, and minimum of a data set
boxplot(rand)

boxplot(rand, main = "Boxplot of rand")

df = data.frame(APPL = appl$Close)
boxplot(df)
# Outliers are either  more above the third quartile or more below the first quartile.

# scatter plots: provides a graphical view of the relationship between two sets of numbers
cor(appl$Adj.Close, goog$Adj.Close)
plot(appl$Adj.Close, goog$Adj.Close, xlab = "APPL adj.close price", ylab = "GOOG adj.close price", main = "Relationship between AAPL and GOOG prices")


# bar chart
barplot(appl$Volume, width = 200)
dev.off()

# multiple data sets on one plot --------------------------------------
# 1. If you only want to add series of points/lines that have the same x and y ranges, 
# points() or lines() will do the job
x <- c(1,2,3,4,5,6)
y <- c(3,5,2,4,1,4)
z <- c(2,3,4,3,2,1)
plot(x,y,type="b")
points(x,z,col="red",type="b")
dev.off()


# If the first data series plotted has a smaller range than subsequent ones, 
# you will have to include a ylim= argument on the first plot to fit them all in:
x1 <- c(1,2,3,4,5,6)
y <- c(3,5,2,4,1,4)
x2 <- c(1,2,3,4,5,6,7,8,9,10)
z <- c(2,3,4,3,5,2,6,7,2,4)
plot(x1,y,type="b",xlim=c(0,10),ylim=c(0,8))
points(x2,z,col="red",type="b")
dev.off()

# 2. If you only want to overlay data series on the same axes, it is sufficient to specify that 
# you don't want to "erase" the first plot and suppress display of the axes after the first plot:
# 2.1 method 1:
x2 = hist(rnorm(1000, mean = 3))
y2 = hist(rnorm(1000,  mean = 5))
plot(x2)
plot(y2, col = rgb(1,0,1,1/4), add = T) 
dev.off()

# 2.2 method 2:
x2 = hist(rnorm(1000, mean = 3))
y2 = hist(rnorm(1000,  mean = 5))
plot(x2)
par(new=T)
plot(y2, col = rgb(1,0,1,1/4))
dev.off()


# dual ordinates
upvar<-rnorm(10)+seq(1,1.9,by=0.1)
downvar<-rnorm(20)*5+19:10
par(mar=c(5,4,4,4))
plot(6:15,upvar,pch=1,col=3,xlim=c(1,20),xlab="Occasion",ylab="",main="Dual ordinate plot")
mtext("upvar",side=2,line=2,col=3)

abline(lm(upvar~I(1:10)),col=3)#adds one or more straight lines through the current plot

par(new=T)#plot the second set of data without erasing the first plot.
plot(downvar,axes=F,xlab="",ylab="",pch=2,col=4)#The second plot is without axes and labels, so that they don't get mixed up with the first plot
axis(side=4)# adding the second axis on the right side.  1=below, 2=left, 3=above and 4=right
abline(lm(downvar~I(1:20)),col=4)
mtext("downvar",side=4,line=2,col=4)
dev.off()
# multiple graphs on one image ---------------------------------------
par(mfrow = c(1,2))# mfrow has two entries, 1st is the number of rows of images. 2nd is the number of columns. 
rand1 = rnorm(1000,sd = 0.2)
rand2 = rnorm(1000,sd = 2)
rand3 = rnorm(1000, sd = 1)
hist(rand1, main = "first plot")
hist(rand2, main = "second plot")
dev.off()

########################### ggplot2 ###################################

install.packages("ggplot2")# install packages
library(ggplot2)# load the package into r environment

# qplot -----------------------------------------
qplot(a,c)# qplot is a shortcut designed to be familiar if you're used to base plot(). 
# It's a convenient wrapper for creating a number of different types of plots using a consistent calling scheme
# format of qplot: 
# qplot(x, y, data=, color=, shape=, size=, alpha=, geom=, method=, formula=, facets=, xlim=, ylim= xlab=, ylab=, main=, sub=)

# load r built-in data:
# mtcars dataset description: https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/mtcars.html
# create factors with value labels 
mtcars$gear <- factor(mtcars$gear,levels=c(3,4,5),
                      labels=c("3gears","4gears","5gears")) 
mtcars$am <- factor(mtcars$am,levels=c(0,1),
                    labels=c("Automatic","Manual")) 
mtcars$cyl <- factor(mtcars$cyl,levels=c(4,6,8),
                     labels=c("4cyl","6cyl","8cyl")) 


x <- 1:10; y = x*x
# Basic plot
qplot(x,y)
# Add line
qplot(x, y, geom=c("point", "line"), colour="red")
# Use data from a data frame
qplot(mpg, wt, data=mtcars)
qplot(mpg, wt, data = mtcars, geom = "auto")
# geom vector specifying geom(s) to draw. Defaults to "point" if x and y are specified, and "histogram" if only x is specified.

# Smoothing
qplot(mpg, wt, data = mtcars, geom = c("point", "smooth"))

# Change the size of points according to the values of a continuous variable
qplot(mpg, wt, data = mtcars, size = mpg)
qplot(mpg, wt, data = mtcars, label = rownames(mtcars), 
      geom=c("point", "text"),
      hjust=0, vjust=0)

# Basic box plot from a numeric vector
x <- "1"
y <- rnorm(100)
qplot(x, y, geom="boxplot")
# Basic box plot from data frame
qplot(group, weight, data = PlantGrowth, 
      geom=c("boxplot"))
# Basic histogram
mydata = data.frame(
  sex = factor(rep(c("F", "M"), each=200)),
  weight = c(rnorm(200, 55), rnorm(200, 58)))
# Basic histogram
qplot(weight, data = mydata, geom = "histogram") # input data must be a dataframe
# Change histogram fill color by group (sex)
qplot(weight, data = mydata, geom = "histogram", fill = sex)
qplot(mydata$weight, geom="histogram",fill = mydata$sex)
# change line type
qplot(weight, data = mydata, geom = "density",
      color = sex, linetype = sex)

# ggplot --------------------------------------------------------------
#The basic structure is data + layouts
# "+" is required to connect different layers, 
# it must be at the end of each line

# There are three common ways to invoke ggplot:
  
# 1. ggplot(data=df, mapping=aes(x, y, <other aesthetics>)) 
# The method is recommended if all layers use the same data and the same set of 
# aesthetics, although this method can also be used to add a layer using data from another
# data frame. mapping is a default list of aesthetic mappings to use for plot. 
# If not specified, must be suppled in each layer added to the plot.
# 2. ggplot(df) The is useful when one data frame is used predominantly as layers are 
# added, but the aesthetics may vary from one layer to another. 
# 3. ggplot() The  method is useful when multiple data frames are used to produce different 
# layers, as is often the case in complex graphics.

# Generate some sample data, then compute mean and standard deviation
# in each group
df <- data.frame(
  gp = factor(rep(letters[1:3], each = 10)),
  y = rnorm(30)
)
ds <- plyr::ddply(df, "gp", plyr::summarise, mean = mean(y), sd = sd(y))
ds
library(plyr)
ds <- ddply(df, "gp", summarise, mean = mean(y), sd = sd(y))

# ddply(.data, .variables, .fun): for each subset of a data frame, apply function then combine results into a data frame
# package pkg, pkg::name returns the value of the exported variable name in namespace pkg
# when functions in different packages have same name, we need to specify which package the function comes from

# example 1. The summary data frame ds is used to plot larger red points on top
# of the raw data. Note that we don't need to supply `data` or `mapping`
# in each layer because the defaults from ggplot() are used.
ggplot(df, aes(gp, y)) + # Aesthetic mappings describe how variables are mapped to visual properties (aesthetics) of geoms
  geom_point() +
  geom_point(data = ds, aes(y = mean), colour = 'red', size = 3)

aes(x = mpg, y = wt)
# example 2. Same plot as above, declaring only the data frame in ggplot().
# Note how the x and y aesthetics must now be declared in
# each geom_point() layer.
ggplot(df) +
  geom_point(aes(gp, y)) +
  geom_point(data = ds, aes(gp, mean), colour = 'red', size = 3)

# example 3. Alternatively we can fully specify the plot in each layer. This
# is not useful here, but can be more clear when working with complex
# mult-dataset graphics
ggplot() +
  geom_point(data = df, aes(gp, y)) +
  geom_point(data = ds, aes(gp, mean), colour = 'red', size = 3) +
  geom_errorbar(
    data = ds,
    aes(gp, mean, ymin = mean - sd, ymax = mean + sd),
    colour = 'red',
    width = 0.4
  )


a <- diamonds
diamonds <- a[1:200, ]
g <- ggplot(diamonds, aes(x, y)) + 
  geom_point(color = "firebrick") + 
  geom_smooth() #with a trend line
g

#histogram & bars
ggplot(diamonds, aes(clarity, fill=cut)) + geom_bar()
ggplot(diamonds, aes(carat)) + geom_histogram(breaks=seq(0, 1.5, by =0.1))


#line plot
x <- 100 * rnorm(100)
e <- rnorm(100)
y <- x + 50*e
data = data.frame(x = x, y = y)
ggplot(data, aes(x, y)) + 
  geom_line() + 
  geom_point()

#show label text instead of dot by adding a label.
ggplot(data, aes(x, y, label = rownames(data))) + 
  geom_point() + 
  geom_text()

####################################
#Title, label, format, legend and annotation
####################################

#ggtitle for adding plot title
#labs for adding name for x and y axis
g <- g + ggtitle("Title Here")
g + labs(x = "Xlab Here", y = "ylab Here")


#theme() is used for adjust the format of title and labs
b <- a + theme(plot.title = element_text(size=20, face="bold", vjust=1.5),
               axis.text.x = element_text(angle = 50, size = 16),
               axis.text.y = element_text(size = 16, color = "forestgreen"),
               legend.title = element_text(color = "red"),
               panel.background = element_rect(fill = "#FFFFFF"))
b
# Change name of legend, by default, the name is the column name of group element.
b + labs(shape = "Name for shape", color = "Name for color")

#Multiple plots in one. 
#ggplot can help you handle multiple plots grouped by specific column, similar to par()
a <- ggplot(diamonds, aes(x, y, color = factor(clarity))) + 
  geom_point(aes(shape = cut))
a
a + facet_wrap(facets = ~cut, nrow = 3)# facet is either a formula or character vector. 
# Use either a one sided formula, ~a + b, or a character vector, c("a", "b")

#Adding annotation to the plot by using "grid" package
#Annotation format and position can be adjusted
library(grid)
my_grob <- grobTree(textGrob("New annotation", x=0.1,  y=0.5, hjust=0,
                             gp=gpar(col="red", fontsize=15, fontface="italic")))
a + annotation_custom(my_grob)


# master example: Scatterplot With Encircling
# When presenting the results, sometimes I would encirlce certain special group of points
# or region in the chart so as to draw the attention to those peculiar cases. 
# This can be conveniently done using the geom_encircle() in ggalt package.
# Within geom_encircle(), set the data to a new dataframe that contains only the points (rows) or interest. Moreover, You can expand the curve so as to pass just outside the points. The color and size (thickness) of the curve can be modified as well. See below example.

# install 'ggalt' pkg
# devtools::install_github("hrbrmstr/ggalt")
options(scipen = 999)
install.packages("ggalt")
library(ggalt)
midwest_select <- midwest[midwest$poptotal > 350000 & 
                            midwest$poptotal <= 500000 & 
                            midwest$area > 0.01 & 
                            midwest$area < 0.1, ]

# Plot
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state, size=popdensity)) +   # draw points
  geom_smooth(method="loess", se=F) + 
  xlim(c(0, 0.1)) + 
  ylim(c(0, 500000)) +   # draw smoothing line
  geom_encircle(aes(x=area, y=poptotal), 
                data=midwest_select, 
                color="red", 
                size=2, 
                expand=0.08) +   # encircle
  labs(subtitle="Area Vs Population", 
       y="Population", 
       x="Area", 
       title="Scatterplot + Encircle", 
       caption="Source: midwest")

########################## save plots ##############################
#1. save to jpeg file
jpeg("C:/Users/xingjia zhang/desktop/pic.jpg", type="cairo") #create the new file, including extension. for type = "cairo", giving the type of anti-aliasing (if any) to be used for fonts and lines (but not fills)
plot(x2) #do any plot function
dev.off() #dev.off() will close the plot panel and file. 

# 
plot(x2)
dev.copy(jpeg,"C:/Users/xingjia zhang/desktop/pic2.jpg")
dev.off()

# 2. save to png
png("C:/Users/xingjia zhang/desktop/pic.jpg")
plot(x2)
dev.off()

#3. save to pdf
pdf("pic.pdf") #create pdf file
plot(a)
dev.off() 

# save picture by different dimension
jpeg("pic1.jpg", height = 200, width = 200)
plot(a)
dev.off() 
#Note: if the picture is too large to fit small picture you need to adjust the size of output picture.

# Change background, by default it is white. 
jpeg("pic1.jpg", bg = "yellow") 
plot(a) 
dev.off() 
#Note: if there is one file with the same name existed, 
#the plot will replace the existed file. 


