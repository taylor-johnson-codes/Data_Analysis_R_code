# slide deck: Regression 2

library(tidyverse)

# Use glimpse() to look at mpg.
glimpse(mpg)

# There are several categorical variables which might be useful in predicting highway gas mileage. 
# Get tables of class, trans, fl and year.
table(mpg$class)
table(mpg$trans)
table(mpg$fl)  # fuel type (c?, diesel, ethanol, premium, regular)
table(mpg$year)

# Build a model to predict hwy (highway mpg)
# Our first model was an equation of the form: hwy = intercept + slope ∗ displ
# To refresh our minds, run the basic model. Then put the residuals from the model into the mpg dataframe and do a scatterplot of residuals against displ.
model1 = lm(hwy~displ, data = mpg)

mpg$residuals = model1$residuals

mpg %>% 
  ggplot(aes(x = displ, y=residuals)) +
  geom_point()
# successful models don't have a pattern

# Non-Linearity
# The graphical analysis of residuals shows that a quadratic model might be more appropriate than a linear model. 
# Create the variable displ2, which is the square of displ. Add this variable to the dataframe. Then run a second model with the quadratic term. 
# Compare the two on the basis of the standard error of the residuals (the RMSE - root mean square error).
mpg = mpg %>% 
  mutate(displ2 = displ^2)

model2 = lm(hwy~displ + displ2, data = mpg)

summary(model1)
summary(model2)

# Adding the quadratic term reduces the RMSE from about 3.8 to about 3.4. This is good, but what does this model imply?
# Create predicted values of hwy for values of displ from .5 liters to 10 liters. Create predictions from these values using model2 and graph them.
displ = seq(from = 0.5, to = 10, by = 0.5)  # could use c() instead of seq()

displ2 = displ^2

new = data.frame(displ, displ2)

preds = predict(model2, new)

results = cbind(new, preds)

results %>% 
  ggplot(aes(x = displ, y = preds)) +
  geom_point()
# Hmmmm? A 10 liter engine would get 40 mpg? 

# We got a better fit to the data we had, but with new data outside the range we had, the model fails. We should look at other ways to improve our model.

# What are some other features that might influence hwy?
# What about vehicle class, drive type, or fuel type?

# Use geom_jitter to see how class effects hwy.
mpg %>% 
  ggplot(aes(x = class, y = hwy)) + 
  geom_jitter()
# What do you see? pickup and SUV are gas hogs

# What about fuel type? Repeat the exercise with fl.
mpg %>% 
  ggplot(aes(x = fl, y = hwy)) + 
  geom_jitter()
# What do you see? most fuel types are regular fuel; not enough data for other some other fuel types

# Repeat the exercise for transmission (trans).
mpg %>% 
  ggplot(aes(x = trans, y = hwy)) + 
  geom_jitter()
# What do you see? nothing useful for making predictions

# What about year?
mpg %>% 
  ggplot(aes(x = year, y = hwy)) + 
  geom_jitter()
# What do you see? year is numerical variable instead of factor so the x-axis values are incorrect because there are only two years in the dataset

# What about drivetrain (drv)?
mpg %>% 
  ggplot(aes(x = drv, y = hwy)) + 
  geom_jitter()
# What do you see? front wheel drives are the best (front wheel drives might be more compact cars; rear wheel might be more trucks/SUVs)

# How could we see the relationship between a categorical variable and the residuals?
# Use color in a scatterplot of residuals against displ in model1. Do this for drv.
mpg %>% 
  ggplot(aes(x = displ, y = residuals, color = drv)) +
  geom_point()
# rear wheel drive in upper right have better gas mileage (maybe high performance car with big engine/light body)

# Do the same for class.
mpg %>% 
  ggplot(aes(x = displ, y = residuals, color = class)) +
  geom_point()
# 2-seaters in upper right have better gas mileage 