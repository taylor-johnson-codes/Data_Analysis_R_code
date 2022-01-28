load("cdc.Rdata")
summary(cdc)

#1-24-22:

NA == NA
is.na(NA==NA)

P=c(T,T,F,F)
Q=c(T,F,T,F)
P_and_Q = P & Q
df_tt_and = data.frame(P,Q,P_and_Q)
P_or_Q = P | Q
df_tt_or = data.frame(P,Q,P_or_Q)
df_tt_and
df_tt_or

R=c(T,F)
not_R = !R
#finish code from slide 11

Exp1 = !(P&Q)
Exp2 = !P | !Q

tt_df = data.frame(P,Q,Exp1,Exp2)
tt_df

Exp1 == Exp2

sum(Exp1==Exp2)
length(Exp1==Exp2)

sum(Exp1==Exp2) == length(Exp1==Exp2)

mean(Exp1) == mean(Exp2)

# do code for slide 17 and 18, slide deck Logical Values

# class 1-26-22:

# Create a function my_range() that returns the value of the range of a numeric vector.

my_range = function(x){
  
  return(max(x) - min(x))
}

rn = rnorm(1000)
# The rnorm() function in R generates a random number using a normal(bell curve) distribution. 
# Thus, the rnorm() function simulates random variates having a specified normal distribution.

my_range(rn)


# Create a function range_95() that returns the difference between the 95th percentile and the 
# 5th percentile of a numeric vector.

range_95 = function(x){
  
  return(quantile(x,.95) - quantile(x,.05))
}
# The generic function quantile produces sample quantiles corresponding to the given probabilities. 
#The smallest observation corresponds to a probability of 0 and the largest to a probability of 1.

range_95(rn)


# Create a function range_85() that returns the difference between the 85th percentile and the 
# 15th percentile of a numeric vector.

range_85 = function(x){
  
  return(quantile(x,.85) - quantile(x,.15))
}

range_85(rn)

quantile(rn, .85)

# 1-28-22:

#8 of 17 slide deck unknown
# We've created separate functions for range_85() and range_95(). In addition we have the built-in function IQR(), which is
# essentially range_75(). Create a function gen_range(x,pct), where the parameter pct takes the place of 75, 85, and 95 in our examples.

gen_range = function(x, pct){
  top = quantile(x,pct/100)
  bottom = quantile(x,1 - pct/100)
  #finish code from slide 9
  
  
  
}

#slide 10:
# Create a function rmsd(x,y) which returns the square root of the mean of the squares of values of the differences 
# between x and y.

#my code:
rmsd = function(x,y){
  difference = x-y
  sqrtOfDiff = sqrt(difference)
  return (mean(sqrtOfDiff))
}
rmsd(150,100)

#his code:  slide 11

#slide 12:
# Create a function mad(x,y) which returns the mean of the absolute values of the differences between x and y.

#my code:
mad = function(x,y){
  difference = x-y
  absValue = abs(difference)
  return(mean(absValue))
}
x = rnorm(1000)
y = rnorm(1000)
mad(x,y)
  
#his code slide 13
