# Slide deck: Factors

# Let’s create a simple dataframe using data.frame.
Name = c("Tom","Dick","Harry","Mary","Sally","Susan")  # vector/1-D array
Gender = c("m","m","m","f","f","f")  # vector/1-D array
People = data.frame(Name,Gender)
People  # prints name and gender columns with their values
str(People)  # prints some more info about the data frame

# How can we turn People$Gender into a factor? 
# I’ll create the factor version as a separate variable.
People$GenderFactor = factor(People$Gender)  # adds GenderFactor column to the data set
People
str(People)
# results from the new column: GenderFactor: Factor w/ 2 levels "f","m": 2 2 2 1 1 1
# 1 represents "f", 2 represents "m"
# GenderFactor is a numeric value in the dataframe and a separate table of values which maps the numeric values to the character string values. 
# Gender column data type is "chr", GenderFactor column data type is "Factor"

# Watch what happens when we create numeric versions of these two values using as.numeric().
# with vector:
GenderNum = as.numeric(People$Gender)  # Warning message: NAs introduced by coercion 
GenderNum # prints NA NA NA NA NA NA
# with factor:
GenderFactorNum = as.numeric(People$GenderFactor)  # no warning message
GenderFactorNum  # prints 2 2 2 1 1 1

# Can we treat GenderF as a numeric variable? No.
People$GenderFactor + 1  # prints numeric(0) for me; for him prints Warning message: In Ops.factor(People$GenderF, 1) : ‘+’ not meaningful for factors THEN PRINTS NA NA NA NA NA NA
People$GenderFactor  # prints NULL for me

# What about using different character strings to represent our factor? We can select the values as we create the factor with the labels argument of the factor function.
People$GenderFactor = factor(People$Gender,labels = c("Female","Male"))
People  # values in GenderFactor column now say Male and Female instead of m and f

# Note that the sorted values of the Gender vector are used to set the numeric values in the factor. We can override this using the levels argument of the factor function.
People$GenderFactor = factor(People$Gender,levels = c("m","f"))
People

str(People$GenderFactor)  
# prints Factor w/ 2 levels "m","f": 1 1 1 2 2 2
# It looks the same, but the str() reveals that the numeric value 1 now means “m”, not “f”.

# This is important if we use the levels() function to assign new string values after the factor has been created. Suppose we forget and think in terms of the natural sorted order of values.
levels(People$GenderFactor) = c("Woman","Man")
People  # now Gender column says m but GenderFactor says Woman; doesn't match up correctly


# Here’s an example with the county data. First load the data
load("county.rda")
str(county)

# We see that the variable state is a factor. Let’s get a count of counties in each state using the table command.
table(county$state)

# Let’s create a smaller dataframe, pnw.
pnw = county[county$state %in% c("Washington", "Oregon", "Idaho"),]
str(pnw)

# Note that the state factor in the smaller dataframe has all of the original levels. Look at what happens when we try to get a table of the state variable from pnw.
table(pnw$state)

# Using as.character() followed by factor() drops the extraneous levels.
# Note that the factor has a specific order. The default ordering of a factor is alphabetical. We can override this with the levels argument of factor().
# Note the order that results is whatever we want.
pnw$state = factor(as.character(pnw$state))
table(pnw$state)

pnw$state = factor(as.character(pnw$state),
                   levels = c("Washington",
                              "Oregon",
                              "Idaho"))
table(pnw$state)

# And if you want to use postal codes instead of names, use the labels argument.
pnw$state = factor(as.character(pnw$state),
levels = c("Washington",
           "Oregon",
           "Idaho"),
labels = c("WA","OR","ID")                      )

table(pnw$state)

# What happens if we convert the factor variable back to a string variable?
pnw$state = as.character(pnw$state)
table(pnw$state)