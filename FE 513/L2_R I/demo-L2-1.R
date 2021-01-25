############################
#L2- R Session I
#Author: Xingjia Zhang
#Content: 
# 1. object types: array, factor, data frame , list
# 2. operators
# 3. functions
# 4. packages
###########################



# Object types(array, data frame, list) ---------------------------------------
# 1. array: is a vector with one or more dimensions
# array(data = NA, dim = length(data), dimnames = NULL)
# create an array
a1 = array(c(1,2,3))# Create an one dimension array
a1 = array(1,2,3)# wrong! 'dimnames' must be a list
# array cannot contain different data types
a = 2
b = "world"
a2 = array(c(a,b))# all non-character elements would be transferred to character
a2
c = T
a2 = array(c(a,c))# logical elements would be tranferred to number
a2
a2 = array(0,dim = c(2,3))# create a 2*3 matrix. two dimension array is almost the same as a matrix
a2
a3 = array(0, c(2,3)) # simplified syntax

vector1 = c(1,2,3)
vector2 = c(4,5,6,7,8,9)
a3 = array(c(vector1, vector2),dim = c(3,3)) # add two vectors into an array. pay attention to the order of numbers
print (a3)
a3 = array(c(vector1, vector2),dim = c(3,3,2)) # add two vectors into an array. pay attention to the order of numbers
print (a3)

# display elements in array
print(a3[1,3,2])# print the element in first row and third column of the second matrix
print(a3[1,,2])# print the first row of the second matrix

# replace elements in array
a4 = array(dim=c(3,3)) # create an empty matrix
a4
a4[,2:3] = vector2
a4
# name columns and rows
colName = c("c1","c2","c3") 
rowName = c("r1","r2","r3")
a4 = array(c(vector1, vector2), dim = c(3,3,1), dimnames = list(rowName,colName)) 
a4
colName = c("c01","c02","c03")
rowName = c("r01", "r02", "r03")
rownames(a4) = rowName# Retrieve or set the row names of a matrix-like object.
colnames(a4) = colName
a4
a4["r01","c02",] = NA # replace elements by name
a4
# transfer object type
matrix1 = a3[,,1] # transfer array to matrix
class(matrix1) # array is made up matrices in multiple dimensions
list1 = as.list(a3)
class(list1)

# apply(x,margin,function): Returns a vector or array or list of values obtained by applying a 
# function to margins of an array or matrix 
# margin is the name of the dataset used. 1 indicates rows, 2 indicates columns, 3 indicates matrix
#app1 = apply(a3,3, sum) # get sum of elements for matrix 
#app2 = apply(a3[,,1], 1 , mean) # sort the elements for rows


# 2. factor: is used to categorize the data and store it as levels. They can store both strings and integers.
# they are useful in the columns which have a limited number of unique values. Like "Male, "Female" and True, False
data <- c("East","West","East","North","North","East","West","West","West","East","North")
fctr1 = factor(data)
fctr1
fctr2 = factor(fctr1,levels = c("East","West","North")) # change the order of levels
fctr3 = gl(n = 2,k = 3, labels = c("T","F")) # generate factor levels using gl(n = number of levels, k = number of replications, labels) 
fctr3
# statistical example: calculate word frequency
mons = c("March","April","January","November","January", "September","October","September","November","August",
          "January","November","November","February","May","August",
           "July","December","August","August","September","November",
           "February","April")
mons = factor(mons)
table(mons)


# 3. dataframe: Can be regarded as a table. 
# each column holds the same type, and the columns can have header names.
a = c(1,2,3)# one observation can be regarded as one column
b= c("beta","gamma")
df1 = data.frame(a,b) # create a data frame
print(df1)
# attention: number of values in a and b must be of the same

names = c("Tom","Bob","Amy")# name columns
ages = c(20,53,12)
df2 = data.frame(Name = names, Age = ages)
df2$Name# access one observation by name
df2$Name[-2] # get all the elements except the second one

df2 = cbind(df2, Male=c(T,T,F)) # Add a new column

#df2["Name"] = lapply(df2["Name"], as.character) # transfer factor to character in a data frame
df2 = rbind(df2, list("Garry", 34, T)) # Add a new row using vector


# 4. list can hold items of different types
list1 = list("a", 1) # create a list
list1
list2 = list(c(1,2,3), c(T,F))
list2
list2[3] = 3 # add element to list
class(list2[3])# sublist of a list is also a list. Attention: won't get number 3
class(list2[[3]]) # access values of a list
list2[[1]] # return type = num
list2[[1]][1]

# [] vs [[]]
x[2][1]
x[[2]][1]#[[]] is used when getting contents of the list


# an example: banking system
bankName = c("BOA", "Chase", "JPMorgan") 
bankEquity = c(210,230,304)
bankLinks = matrix(c(1,1,1,0,1,1,0,0,1), nrow = 3) 
bankLinks
bankInfo = list(bankName, bankEquity, bankLinks)  # add elements in list.
names(bankInfo) = c("Names", "Equities", "Links") # give names to the elements in a list
print(bankInfo$Names) # display with name. equals to print (x[1])



# transferring ------------------------
a = c(1,2,3)
lista = as.list(a)
class(lista)
dfa = as.data.frame(lista)
class(dfa)

############################## Operations ##################################3
# arithmetic operators(+-*/)
num1 = 3 # operations of two data
num2 = 4
num1+num2  # 
num1 %% num2 # modulo operation

v1 = c(1,2,3,4) # operators in a vector
v1+5 # every element in vector plus 5
v2 = c(2,2,2,2) # operations of two vectors
v1 + v2

mat1 = matrix(c(v1,v2), nrow = 2, byrow = FALSE)
mat2 = matrix(c(v1,v2), nrow = 2, byrow = TRUE)
mat1+mat2


# comparison operators(<, <= >= == !=)
num1<num2
num1==num2 # different from a=b
num1!=num2 

v = c(2,5.5,6,9)
t = c(8,2.5,14,9)
print(v>t)

# logical operators(! & |)
a = 3
a<5 & a>1 
1<a<5 # wrong. it's necessary to use & 
a<5 & a<1
a<5 | a<1
a>5 | a<1


3 & 4# attention: different from 3+4


###############################  Functions #############################
# built-in functions on numbers
a = 3 
sqrt(a) # square root
exp(a) # exoponential 
log(a) # logarithm

# built-in functions on vectors
c = c(1,2,3,4,5)
log(c)
min(c) # minimum number in a vector
min(c,d)
max(c) # maximum number
var(c) # variance
sd(c) # standard deviation
median(c)
quantile(c)
summary(c)
sum(c)

sort(c) # sort a vector/array
sort(c, decreasing = TRUE)
order(c)# order number of elements in a vector/array

union(x, y)
intersect(x, y)
setdiff(x, y)
setequal(x, y) # common elements in different vectors

diag(m)# diagonal of a matrix

format(Sys.time(), "%m-%d-%y") # format a date
format(Sys.time(), "%m-%d-%Y") # 

# user-defined function
myfunc1 = function(){ # define a function without an argument
  a = c(1,2,3)
  print (a*2)
}
myfunc1()
myfunc1(c(1,2))# error: unused argument

myfunc2 = function(arg1, arg2){ # define a function with an argument
  a = arg1*arg2
  print (a)
  
}

myfunc2(c,c) # call the new function
myfunc2()# Error in myfunc2() : argument "arg1" is missing, with no default

myfunc3 = function(arg1 = 1, arg2 = 2){ # define a function with default argument
  a = arg1*arg2
  print (a)
}

myfunc3(2,2)
myfunc3()
myfunc3(5)# first argument is replaced by 5
myfunc3(arg2=6)


myfunc4 = function(arg1 = 1, arg2 = 2){ # define a function with returns
  a = arg1*arg2
  return (a)
}


result = myfunc4(3,4) # result is stored in memory

#########################  Packages ########################################
time = c("00:00:01", "01:02:00", "09:30:01", "14:15:25")
class(time)
chron(times=time) # Error: could not find function "chron"

#.libPaths()# get library locations containing R packages

# 1. install a new package
install.packages("chron") # package 'chron' successfully unpacked and MD5 sums checked

# 2. load library
library("chron") 

x = chron(times=time) # Error: could not find function "chron"
class(x)

library() # check list of all the packages installed
search() # get all packages currently loaded in the R environment


