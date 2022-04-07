# slide deck: Regression 3

library(tidyverse)

# A dummy variable has only two values, 0 and 1 or (FALSE or TRUE). This device is used in regression to mark the presence or absence of a condition.
# If one of these is used in the list of independent variables, the value of its coefficient is the amount added to the predicted value in the case of presence. I’ll build an example with the cdc dataset.

load("cdc.Rdata")

cdc = cdc %>% 
  mutate(male_bool = gender == "m",
         male_numeric = ifelse(gender == "m", 1, 0))

table(cdc$male_bool, cdc$male_numeric)

# Create models bool_model and numeric_model using these two variables in addition to height, to predict weight.
bool_model = lm(weight~height + male_bool, data = cdc)
print(bool_model)

numeric_model = lm(weight~height + male_numeric, data = cdc)
print(numeric_model)
# Here’s what either of these models tells you.
# To predict weight, use the intercept and slope for the height coefficient to get a value for someone who is not a male, then add 12.011 pounds if the person is a male.

# We might also consider a dummy to label females. Do this and then run a model using the female dummy. Look at the result.
cdc = cdc %>% 
  mutate(female_bool = gender == "f")

bool_model_f = lm(weight~height + female_bool, data = cdc)
print(bool_model_f)

# What do we get in our coefficient if a dummy is the only variable in the model.
model_dummy = lm(weight~male_bool, data = cdc)
print(model_dummy)

# If a person is not male, the predicted weight is 151.67. If a person is male, the predicted weight is 151.67 + 37.66 = 189.33.

# Look at the mean weights of males and females using tapply().
tapply(cdc$weight, cdc$gender, mean)

# What happens if we include both a male dummy and a female dummy in a regression model?
model_both = lm(weight ~ male_bool + female_bool, data = cdc)
print(model_both)
# This model fails in a non-spectacular way. Most regression procedures will refuse to run with a complete set of dummies. One always has to be left out.

# What happens if we just put gender in the model and forget about constructing dummy variables.
model_gender = lm(weight~gender, data = cdc)
print(model_gender)

# Look at the levels of the factor variable gender.
levels(cdc$gender)
# The “reference level” is “m”. The reference level is always omitted to avoid completeness. These levels are not the default levels since “f” is before “m” alphabetically.

# What happens if you include gender*height in the regression formula?
interaction_model = lm(weight~gender*height, data = cdc)
print(interaction_model)
# You get different slopes and different intercepts.

# -----------------------------------------------------------------------------------------------

# try to create the best possible adjusted R-squared value by playing with the mpg variables
# (the more variables added to the model, the better the score)
glimpse(mpg)
summary(mpg)

# trying to improve the adjusted R-squared from model1 here:
mpg = mpg %>% 
  mutate(displ2 = displ^2)

model1 = lm(hwy~displ + displ2, data = mpg)
summary(model1)  # Adjusted R-squared:  0.6696 

model2 = lm(hwy~displ + displ2 + manufacturer + model + year + cyl + trans + drv + cty + hwy + fl + class, data = mpg)
summary(model2)  # Adjusted R-squared:  0.9747 