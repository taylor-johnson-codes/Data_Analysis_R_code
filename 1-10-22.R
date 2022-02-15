# Ctrl+Enter (or Run button) runs the line of code the cursor is on
# Ctrl+Shift+Enter or # Ctrl+Shift+S (or Source button) runs all the code in the R file

x <- rnorm(20)  # rnorm(number of observations, mean = 0, standard deviation = 1)
x  # see values in console
summary(x)  # returns min, median, mean, max
hist(x)  # shows visual histogram

y = 1:10  # assign values 1 through 10
y  # see values in console
cumsum(y)  # cumulative sum
cumprod(y)  # cumulative product
summary(y)
z = median(y)  # assign median value
z  # see value in console

print("Hello world!")

# Ctrl+L in the console window clears it out

ls()  # lists all variables in the environment

load("county.rda")  # dataset is already in this project folder

summary(county)
# shows number of NAs in each column
# shows the min and max values in each column

str(county)
# shows the number of observations (rows) and number of variables (columns)
# shows the data type of each variable
# shows the first few observations in the dataset


# install.packages("dplyr")
# only need to install a package when the package isn't previously installed on the computer (installation called in another R script installs it on the computer)
# after the initial installation, it'll be available on all future RStudio projects by using library()

library(dplyr)  # need this to use glimpse()
glimpse(county)  # similar output as str()
# shows the number of observations (rows) and number of variables (columns)
# shows the data type of each variable
# shows the first few observations in the dataset