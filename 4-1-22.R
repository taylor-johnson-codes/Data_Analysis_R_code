# slide deck: Regression 1

library(tidyverse)

# Examine the dataframe mpg (from ggplot2).
glimpse(mpg)

# Build a model to predict hwy (highway mpg)
# Our first model is an equation of the form
# hwy = intercept + slope ∗ displ
# (displacement: the bigger the engine, the worse gas mileage we predict)

# Use lm() to create model1.
model1 = lm(hwy ~ displ, data = mpg)  # predict hwy with displ data

# Now use summary to look at model1.
summary(model1)

# What are the values of intercept and slope (from the summary output)?
# intercept = 35.6977
# slope = -3.5306

# Write down the equation
# hwy = 35.6977 - 3.5306 * displ

# Use this equation to calculate the value of hwy when displ = 2. call this hwy2.
hwy2 = 35.6977 - 3.5306 * 2
hwy2

# Do the same for an engine with 3 liters displacement.
hwy3 = 35.6977 - 3.5306 * 3
hwy3

# Subtract hwy2 from hwy3.
hwy3 - hwy2  # result is the slope (going from 2-liter engine to 3-liter decreases hwy mpg 3.5306)

# Note the interpretation.
# Increasing the displ by 1 “adds” the value of slope to hwy

# The data does not lie exactly on the line we have estimated.
# Show this graphically using a scatterplot of hwy and displ. Add a smoother with method = “lm”.
mpg %>% 
  ggplot(aes(x = displ, y = hwy)) +
  geom_point(color = "blue") +  # the plot points are actual data points
  geom_smooth(method = "lm", color = "red")  # the line is the prediction

# We summarize the relationship in general.
# Actual = Predicted + Residual

# Look at the contents of model1 using str().
str(model1)

# Extract the item residuals from the model and see what it is using str().
residuals = model1$residuals
str(residuals)

# Create mpg_augment by adding the vector of residuals using cbind.
mpg_augment = cbind(mpg, residuals)

# Now create a scatterplot of displ and residuals.
mpg_augment %>% 
  ggplot(aes(x = displ, y = residuals)) +
  geom_point(color = "blue") +
  geom_smooth(method = "lm", color = "red")

# We did something pretty crude when we copied numbers manually from the output os summary to build an equation to make predictions. 
# There is a function predict() which will take a model and a dataframe of new values of the independent variable(s) to make predictions.

displ = c(1,2,3,4,5)
newdata = data.frame(displ)  # it has to be a data frame for predict()
predictions = predict(model1, newdata)  # column names have to be the same in the data frames in predict()

results = data.frame(displ, predictions)
results