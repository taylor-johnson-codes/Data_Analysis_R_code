# slide deck: Regression Workflow 1 (on how to get the cdc2 dataset)
# slide deck: Model Building 2

library(broom)
library(ggplot2)
library(dplyr)
library(formula.tools)

load("cdc2.Rdata")
summary(cdc2)

# Can we predict how much weight people want to lose or gain?
# We’ll build a number of models, saving the results in an organized way. Finally, we’ll combine the key results in a dataframe and compare them.

# Splitting the data
# We want to split our data into train and test. We will build the model on train and evaluate its performance on test. Randomly select about 75% of the data for train and 25% for test.
# Follow the process in the Mount-Zumel course in Datacamp to create train and test.
print(N <- nrow(cdc2))
print(target <- round(.75 * N))

set.seed(123)
gp <- runif(N)
train = cdc2[gp < .75,]
test = cdc2[gp >= .75,]

nrow(train)
nrow(test)

# Model 1
# Focus on predicting DesActRatio. For our first model, we will use only BMI as a predictor. Create lm1 using train. Then use tidy() and glance() to examine it. Store the formula in the glance dataframe, which you should name glance1.
# Use lm1 to create the variable pred1 in the dataframe test.
fml1 = DesActRatio ~ BMI
lm1 = lm(fml1, data = train)
tidy1 = tidy(lm1)
tidy1$formula = as.character(fml1)  # formula not needed here, just in glance below
tidy1

glance1 = glance(lm1)
glance1$formula = as.character(fml1)
glance1

test$pred1 = predict(lm1, newdata = test)

# Create an R function RMSE() with parameters predicted and actual to compute the root mean squared error. We will use this to compare the performance of our models on the test data. This is the value sigma from the glance() output.
# Use the function to compare the actual and predicted values from the test dataframe. save the result as test_RMSE in glance1.
RMSE = function(actual, predicted){
  Residual = actual - predicted
  result = sqrt(mean(Residual^2))
  return(result)
}

glance1$test_RMSE = RMSE(test$DesActRatio, test$pred1)
glance1
# Our results for lm1 are very similar for train and test. Overfitted models show a significant drop in performance from train to test.

# Create a model lm2 by adding the categorical variable gender to lm1. Store the formula in glance2 as you did with Model 1.
fml2 = DesActRatio ~ BMI + gender
lm2 = lm(fml2, data = train)
tidy2 = tidy(lm2)
tidy2$formula = as.character(fml2)
tidy2

glance2 = glance(lm2)
glance2$formula = as.character(fml2)
glance2

# Examine the performance of Model 2 on the test data using the function we created and add the results to glance2.
test$pred2 = predict(lm2, newdata = test)

glance2$test_RMSE = RMSE(test$DesActRatio, test$pred2)
glance2

# Repeat the entire exercise for a third model by adding genhlth. Do everything in one step.
fml3 = DesActRatio ~ BMI + gender + genhlth
lm3 = lm(fml3, data = train)
tidy3 = tidy(lm3)
tidy3$formula = as.character(fml3)
tidy3

glance3 = glance(lm3)
glance3$formula = as.character(fml3)
test$pred3 = predict(lm3, newdata = test)

glance3$test_RMSE = RMSE(test$DesActRatio, test$pred3)
glance3

# Model 4 is similar to Model 3, but the third variable is ageCat instead of genhlth.
# Repeat everything and produce glance4 for comparison.
fml4 = DesActRatio ~ BMI + gender + ageCat
lm4 = lm(fml4, data = train)
tidy4 = tidy(lm4)
tidy4$formula = as.character(fml4)
tidy4

glance4 = glance(lm4)
glance4$formula = as.character(fml4)
test$pred4 = predict(lm4, newdata = test)

glance4$test_RMSE = RMSE(test$DesActRatio, test$pred4)
glance4

# Include gender, genhlth, and ageCat in the model. Rerun everything to produce glance5.
fml5 = DesActRatio ~ BMI + gender + ageCat + genhlth
lm5 = lm(fml5, data = train)
tidy5 = tidy(lm5)
tidy5$formula = as.character(fml5)
tidy5

glance5 = glance(lm5)
glance5$formula = as.character(fml5)
test$pred5 = predict(lm5, newdata = test)

glance5$test_RMSE = RMSE(test$DesActRatio, test$pred5)
glance5

# So far, we have always included gender as one of the categorical variables. In Model 6, just include genhlth and ageCat. Repeat all of the steps and produce glance6.
fml6 = DesActRatio ~ BMI + ageCat + genhlth
lm6 = lm(fml6, data = train)
tidy6 = tidy(lm6)
tidy6$formula = as.character(fml6)
tidy6

glance6 = glance(lm6)
glance6$formula = as.character(fml6)
test$pred6 = predict(lm6, newdata = test)

glance6$test_RMSE = RMSE(test$DesActRatio, test$pred6)
glance6

# Use rbind() to combine glance1,…, glance6 in one dataframe. Keep only the formula and the test performance statistics. use arrange() to order the dataframe by test_RMSE. Which model is best?
all6 = rbind(glance1, glance2, glance3, glance4, glance5, glance6) %>% 
  select(formula, test_RMSE) %>% 
  arrange(test_RMSE)

all6

# Model 5 is the best (lowest RMSE):
# formula                                       test_RMSE
# <chr>                                             <dbl>
#   1 DesActRatio ~ BMI + gender + ageCat + genhlth    0.0662

# Graphical Evaluation Look at the relationship between predicted and actual values using ggplot2. Use the dataframe test with the predicted values from the best model. Use ggplot2 to make a scatterplot of the actual and predicted values. Map the predicted values to x.
# Set alpha to a low value like .1 in your geom_point().
# Add the line y = x using geom_abline(). Color it red.
# Add a default smoother using geom_smooth(). Color it blue.
# Note what you see.

test %>% 
  ggplot(aes(x = pred5, y = DesActRatio)) +
  geom_point(alpha= 0.1) +
  geom_abline(color = "red") +
  geom_smooth(color = "blue") + 
  ggtitle("Performance of Model 5")
# high points in upper right mean ratio is too large