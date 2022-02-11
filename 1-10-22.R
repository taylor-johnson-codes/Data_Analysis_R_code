x <- rnorm(20)  # rnorm(number of observations, mean = 0, standard deviation = 1)
x  # see values in console
summary(x)  # returns min, median, mean, max
hist(x)  # shows visual histogram
ls()  # lists all variables

y = 1:10  # assign values 1 through 10
y  # see values in console
cumsum(y)  # cumulative sum
cumprod(y)  # cumulative product
summary(y)
z = median(y)  # assign median value
z  # see value in console

print("Hello world!")