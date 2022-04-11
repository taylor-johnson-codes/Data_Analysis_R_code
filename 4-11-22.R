# slide deck: Classification 1

library(class)
library(naivebayes)
library(broom)
library(ggplot2)
library(dplyr)
library(formula.tools)

# The task is to predict the gender of a person based on other characteristics?
# This document works through two model types, K Nearest Neighbors (KNN) and Naive Bayes.

load("cdc2.Rdata")

# Scaling the data. 
# Height and weight need to be scaled so that both are on a 0 - 1 scale. Use the procedure from the Datacamp course to do this. 
# Check the range of both before and after the rescaling. This task needs to be done before splitting the data.
mean(cdc2$weight)  # 169.676

print(range(cdc2$weight))  # 68 500
print(range(cdc2$height))  # 48 84

cdc2$weight = (cdc2$weight - min(cdc2$weight))/(max(cdc2$weight) - min(cdc2$weight))
cdc2$height = (cdc2$height - min(cdc2$height))/(max(cdc2$height) - min(cdc2$height))

print(range(cdc2$weight))  # 0 1
print(range(cdc2$height))  # 0 1 

mean(cdc2$weight)  # 0.235361

# Splitting the data
# We want to split our data into train and test. We will build the models on train and evaluate their performance on test. Randomly select about 75% of the data for train and 25% for test.
# Follow the process in the Mount-Zumel course in Datacamp to create train and test subsets.
print(N <- nrow(cdc2))  # 19997
print(target <- round(.75 * N))  # 14998

set.seed(123)
gp <- runif(N)
train = cdc2[gp < .75,]
test = cdc2[gp >= .75,]

nrow(train) # 15064
nrow(test)  # 4933

# KNN Model 1
# Use select to create train_a and test_a. These dataframes contain only gender, height and weight in that order.
# Follow the procedure in the Datacamp course to create a knn model for gender with k = 1. Build the model using train and measure its performace on test. 
# Note that the variable gender, which has column index 1, must be removed from the train dataframe and placed in a separate variable called gender. Note the way sign-types was used in the Datacamp course.
# Compute the accuracy of this model using the procedure in the Datacamp course.

train_a = train[c("gender", "height", "weight")]
test_a = test[c("gender", "height", "weight")]
gender = train_a$gender
k_1 <- knn(train = train_a[-1], test = test_a[-1], cl = gender)  # k = 1 is there by default
mean(test_a$gender == k_1)  #  0.8489763

# Repeat the process to create and measure the performance of a model with k = 5.
k_5 <- knn(train = train_a[-1], test = test_a[-1], cl = gender, k = 5)
mean(test_a$gender == k_5)  # 0.8548551

# Try k = 50
k_50 <- knn(train = train_a[-1], test = test_a[-1], cl = gender, k = 50)
mean(test_a$gender == k_50)  # 0.8583012

# Try k = 100
k_100 <- knn(train = train_a[-1], test = test_a[-1], cl = gender, k = 100)
mean(test_a$gender == k_100)  # 0.8552605
# The performance deteriorated between k values of 50 and 100.

# Let’s stick with knn but add some variables to the mix. Create dataframes train_b and test_b. Add genhlth, smoke100 and exerany. Try k values of 1, 5, 50, and 100.
train_b = train[c("gender", "height", "weight", "smoke100", "exerany")]
test_b = test[c("gender", "height", "weight", "smoke100", "exerany")]
gender = train_b$gender

k_1 <- knn(train = train_b[-1], test = test_b[-1], cl = gender, k = 1)
mean(test_b$gender == k_1)  # 0.8343807

k_5 <- knn(train = train_b[-1], test = test_b[-1], cl = gender, k = 5)
mean(test_b$gender == k_5)  # 0.8530306

k_50 <- knn(train = train_b[-1], test = test_b[-1], cl = gender, k = 50)
mean(test_b$gender == k_50)  # 0.8544496

k_100 <- knn(train = train_b[-1], test = test_b[-1], cl = gender, k = 100)
mean(test_b$gender == k_100)  # 0.8532333
# Again, the performance deteriorated between 50 and 100.
# The most successful model was with just height and weight with k = 50.

# The Baseline
# Our data is not evenly divided by gender. Use the simple table command on train and test to see the true distribution of gender. Divide by nrow() to get proportions.
table(train$gender)/nrow(train)  # m: 0.4791556 f: 0.5208444
table(test$gender)/nrow(test)  # m: 0.4759781 f: 0.5240219
# If you were forced to guess a person’s gender with no information on characteristics, you should pick “f” since you’d be right more often than wrong. 
# Your accuracy would be about 52%. Any other reported accuracy should be compared with the accuracy of this totally uninformed guess.

# Let’s consider using one of the categorical variables, smoke100 as a predictor of gender.
# Use naive_bayes with this variable and measure the accuracy on the test data.
NB1 = naive_bayes(gender ~ smoke100, data = train)
NB1_predict = predict(NB1, test)

accuracy = mean(NB1_predict == test$gender)
accuracy  # 0.5552402

# Add a second categorical variable, genhlth. Does this improve the accuracy?
NB2 = naive_bayes(gender ~ smoke100 + genhlth, data = train)
NB2_predict = predict(NB2, test)

accuracy = mean(NB2_predict == test$gender)
accuracy  # 0.5507805
# The accuracy actually had a slight decline. This might seem to be impossible, but it illustrates the importance of using test data to measure accuracy. 
# More complex models frequently do this relative to simpler models. The phenomenon is known as overfitting.

# Let’s use a quantitative variable, height. Do this with naive_bayes and measure the accuracy.
NB3 = naive_bayes(gender ~ height, data = train)
NB3_predict = predict(NB3, test)

accuracy = mean(NB3_predict == test$gender)
accuracy  # 0.8394486
# This is a substantial improvement over the categorical variable models we tried.

# Add a second quantitative variable, weight; then Measure the accuracy.
NB4 = naive_bayes(gender ~ height + weight, data = train)
NB4_predict = predict(NB4, test)

accuracy = mean(NB4_predict == test$gender)
accuracy  # 0.8378269
# Again, we see a slight loss of accuracy with the more complex model.

# Try weight alone. Compare the accuracy with the previous results.
NB5 = naive_bayes(gender ~ weight, data = train)
NB5_predict = predict(NB5, test)

accuracy = mean(NB5_predict == test$gender)
accuracy  # 0.713359
# The best model of this set is clearly height alone.

# We did several variations on two types of models, knn and naive bayes. Which model was the best of all of these?
# KNN with k = 50; worked best with this dataset 