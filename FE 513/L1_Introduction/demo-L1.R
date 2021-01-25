############################
#L1- Introduction
#Author: Xingjia Zhang
###########################
############################### creating, listing and deleting the objects in memory #######################

x <- 2  # assign operator, display results in memory
x <- 2+ 4 # the previous value is erased
xx <- rnorm(1) # generates a normal random variate N(0,1)
10*3 #  not stored in memory

ls() # list names of objects
ls(pat="x") # objects containing a given character in their name
ls.str() # display details
rm(y) # remove values
remove(y) # remove values
rm(list = ls()) # remove all values

?lm # online help for function lm()
cat("\014") # clear console. same as ctrl+L


#################################### Data types ###########################
a<-100 # 
mode(a) # data type
length(a)

b<-1:3
mode(b) # numeric class is a more general class than the integer class
c <- TRUE
mode(c)
d <- 1i 
mode(d)
e <- "apple" 
mode(e)

# data type conversions
cha1 = "10"
as.numeric(cha1)
num1= 20
as.character(num1)
cha2 = "True"
as.logical(cha2)
cha3 = "10"
as.logical(cha3)
as.logical(num1)
as.logical(as.numeric(cha3))


z <- as.character(x) #transfer from numeric to char
as.numeric(z) #char to num might have error
z <- as.numeric(z)
is.na(z) # Check NA value
c(1, 'a', FALSE) # If you combine char with other type into one vector, the values are all treated like char
c(1.5, FALSE)# If you combine numeric and logical, the logical will become numbers (T to 1, F to 0)



################################### Object types #########################
vector1 <- vector(mode="logical", 3) # build a vector
vector <- c(1, 2.2, 3,3.1) #numeric vector
vector[2] # display the second element from the vector
vector[c(2,4)] # display the second and fourth elements from the vector
vector[c(2:4)]# display the second, third and fourth elements from the vector
vector[-1] # display all elements, except the last element.It doesn't remove elements for vector!
vector2 <- vector[-1] # remove the first element! don't forget to replace the old vector!
c(1, 'a', FALSE) # If you combine char with other type into one vector, the values are all treated like char
c(1.5, FALSE)# If you combine numeric and logical, the logical will become numbers (T to 1, F to 0)

# add elements into a vector
v1 = c()
v1[1] = 1 
v1[2] = 2
v1[c(3,4)] = c(3,4) # add elements into a vector
v1 = append(v1,5) # add an element into a vector
v1 = append(v1, c(8,9)) # add elements into a vector

# replace elements in a vector
v1[1] = 6 # replace an element in a vector 
v1[c(1,2)] = c(3,4) # replace elements in a vector



matrix1 = matrix(c(T,F,T,T,T,T), ncol=3) # build a matrix
matrix2 = matrix(c(T,F,T,T,T,T), ncol = 3, byrow = TRUE) # order by row
matrix1[1,] # first row of matrix
matrix1[,1] # first columns of matrix
matrix1[2,] # second row of matrix
matrix1[1:2,] # first two rows of matrix
matrix1[c(1,2),c(1)] # Get 1st, 2nd rows, then only keep 1st columns. 

as.matrix(c(1:2)) #transfering to matrix

# name columns and rows
dimnames(matrix1) = list( 
    c("row1", "row2"),         # row names 
   c("col1", "col2", "col3")) # column names

print(matrix1)
# access elements by names
matrix1['row1',] # # first row of matrix
