# Slide deck: Exercises on Functions
# (A random number generator is used here so output will differ when a new set of random numbers is generated.)

# Create a function my_range() that returns the value of the range of a numeric vector.
my_range = function(x){
  return(max(x) - min(x))
}

# rnorm() generates a random number using a normal (bell curve) distribution. 
# rnorm() simulates random variates having a specified normal distribution.
random_nums = rnorm(100)  # 100 random numbers
random_nums

range(random_nums)  # built-in function prints -2.721918  2.865279 (smallest number largest number)

my_range(random_nums)  # my function above prints 5.587197 (difference between smallest number and largest number)

# Create a function range_95() that returns the difference between the 95th percentile and the 5th percentile of a numeric vector.
range_95 = function(x){
  return(quantile(x, 0.95) - quantile(x, 0.05))
}
# quantile() produces sample quantiles corresponding to the given probabilities. 
# The smallest observation corresponds to a probability of 0 and the largest to a probability of 1.
range_95(random_nums)  # prints 95%  3.257299 

# Create a function range_85() that returns the difference between the 85th percentile and the 15th percentile of a numeric vector.
range_85 = function(x){
  return(quantile(x, 0.85) - quantile(x, 0.15))
}

range_85(random_nums)  # prints 85%  2.098839 

# We’ve created separate functions range_85() and range_95(). In addition we have the built-in function IQR(), which is essentially range_75().
# Create a function gen_range(x,pct), where the parameter pct takes the place of the 75, 85, and 95 in our examples.
gen_range = function(x, pct){
  top = quantile(x, pct/100)
  bottom = quantile(x, 1 - pct/100)
  return(top - bottom)
}

gen_range(random_nums,85)  # prints 85%  2.100505
range_85(random_nums)  # prints 85%   2.100505

# Create a function rmsd(x,y) which returns the square root of the mean of the squares of the differences between x and y.
rmsd = function(x,y){
  diffs = x-y
  diffs_sq = diffs^2
  mdiffs_sq = mean(diffs_sq)
  return(sqrt(mdiffs_sq))
}

x = rnorm(10)
x
y = rnorm(10)
y
rmsd(x, y)

# Create a function mad(x,y) which returns the mean of the absolute values of the differences between x and y.
mad = function(x,y){
  diffs = x-y
  abs_diffs = abs(diffs)
  return(mean(abs_diffs))
}

x = c(1,2,3,4)
x
y = c(2,1,4,3)
y
mad(x,y)  # prints 1

# You probably noticed that the quantile() function produces a named vector as a result. You may want to know why. 
# The answer is that its second argument may be a vector of percentiles. In that case, the labels would be important.
random_nums = rnorm(1000)
values = quantile(random_nums, c(.1,.25,.5,.75,.9))
values

# Create an inverse of the quantile() function, qinv(x,val). The parameter x is a numeric vector.The parameter val is a single number. 
# The function returns the fraction of the values of x that are less than val.
qinv = function(x, val){
  return( mean(x < val) )
}

random_nums = rnorm(1000)
qinv(random_nums, 2)