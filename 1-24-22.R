# Slide deck: Logical Values

# Dealing with NA Values
7 == NA  # prints NA
NA == NA  # prints NA
# The key principle is that any expression involving NA is NA.

# is.na() returns TRUE or FALSE
is.na(7) # prints FALSE
is.na(NA) # prints TRUE

# Truth Table
# Given two logical variables, P and Q, there are four possible combinations of truth values. 
# The table below is implemented as a dataframe and shows the value of P & Q for each of the four possibilities.
P = c(T,T,F,F)
Q = c(T,F,T,F)
P_and_Q = P & Q

df_tt_and = data.frame(P,Q,P_and_Q)
df_tt_and

# Following the example above construct a truth table for the or operator which is written “|” in R.
P = c(T,T,F,F)
Q = c(T,F,T,F)
P_or_Q = P | Q

df_tt_or= data.frame(P,Q,P_or_Q)
df_tt_or

# Not, written ! in R is a unary operator, so its truth table only needs two rows. Create this table yourself.
P1 = c(T,F)
not_P1 = !P1

df_tt_not = data.frame(P1,not_P1)
df_tt_not

# Logical Equivalence
# Two logical expressions are equivalent if they have the same truth value for every possible combination of the basic values of their lowest level components. 
# The way we do this in Math. courses is to build a truth table with columns containing the truth values for the two expressions. 
# Then we visually examine the two columns. If the two columns are identical, the expressions are logically equivalent.
# As an example consider the following two logical expressions
# Exp1: not (P and Q)
# Exp2: (not P) or (not Q)
# Exercise: Let’s build a truth table containing these.
P = c(T,T,F,F)
Q = c(T,F,T,F)

Exp1 = !(P & Q)
Exp2 = !P | !Q

tt_df = data.frame(P,Q,Exp1,Exp2)
tt_df

# Yes! they are identical. We can see that visually, but did we need to look?
# Could we just compare the two logical vectors? Exercise: Do that.
Exp1 == Exp2  # prints TRUE TRUE TRUE TRUE

# We still had to look and see that every position in the logical vector contained the value TRUE. How could we simplify the conclusion?
# The idea is that we want to see if the count of TRUE values in the logical vectors is the same as its length. Exercise: Do that.
sum(Exp1 == Exp2)  # prints 4
length(Exp1 == Exp2)  # prints 4  

# Yes, they are the same. Of course I could ask this question even more directly. Do that.
sum(Exp1 == Exp2) == length(Exp1 == Exp2)  # prints TRUE

# A Distributive Law
# In the algebra of real numbers, we know that the following is true. For any three numbers, x, y and z
# x(y+z) = xy+xz
# There are two similar laws in Boolean algebra. We’ll just look at one of them. For any three logical values P, Q and R The following expressions are equivalent.
# Exp1 = P and (Q or R)
# Exp2 = (P and Q) or (P and R)
# A truth table would contain eight rows and be a tedious chore. But computing the values of the two logical expressions for every possible combination of P, Q and R would be easy using nested for loops. Do that.
TV = c(T,F)
for(P in TV){
  for(Q in TV){
    for(R in TV){
      Exp1 = P & (Q | R)
      Exp2 = (P & Q) | (P & R)
      print(Exp1 == Exp2)
    }
  }
}

TV  # prints TRUE FALSE for me; prints TRUE 8 times for him

# That’s a very not so R-ish way to do things. Experienced R users do manipulations with vectors instead of for loops.
# We can generate the base columns of the 8-row truth table as follows using simple brute strength.
P = c(T,T,T,T,F,F,F,F)
Q = c(T,T,F,F,T,T,F,F)
R = c(T,F,T,F,T,F,T,F)

base_cols = data.frame(P,Q,R)
base_cols

# Then we can create the expressions we want using vector operations and test the equality of the two.
Exp1 = P & (Q | R)
Exp2 = (P & Q) | (P & R)
Exp1 == Exp2  # prints TRUE TRUE TRUE TRUE TRUE TRUE TRUE TRUE

# You could also build the base columns using the replicate function rep().
P = rep(c(T,F),each = 4)
Q = rep(c(T,T,F,F),times = 2)
R = rep(c(T,F),times = 4)

tt_df = data.frame(P,Q,R)
tt_df