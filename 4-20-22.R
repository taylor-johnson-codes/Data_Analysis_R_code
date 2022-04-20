# slide deck: Caret

library(class)
library(caret)
library(caTools)
library(ggplot2)
library(plyr)
library(dplyr)
library(e1071)
library(MASS)
library(mboost)
library(xgboost)
library(ranger)
library(gbm)

load("cdc2.Rdata")

# The task is to predict the gender of a person based on other characteristics?
# This document works through several models using the caret package. It uses the cleaned version of the cdc data.

# Use the function createDataPartition from the caret package to split the cdc2 data frame into traindf and testdf using an 80/20 split. 
# Use table to examine the distribution of gender in cdc, train, and test. The distributions should be very similar.

set.seed(123)
inTrain = createDataPartition(cdc2$gender, p =0.8, list=F)
traindf = cdc2[inTrain,]
testdf = cdc2[-inTrain,]
table(cdc2$gender)/nrow(cdc2)

table(traindf$gender)/nrow(traindf)

table(testdf$gender)/nrow(testdf)

# Use the train function in caret to create a model, glm, based on the data in traindf. In this model use only height to predict gender. Use the method “glm”.
# Use only the essentials in the call to train. Display the model.

glm = train(gender~height,
            data = traindf,
            method = "glm")

glm

# Create a vector of predictions, pred_glm for the data in testdf. Look at the head of the predictions.

pred_glm = predict(glm, testdf)
head(pred_glm)

# Show the confusion matrix for the test data.

confusionMatrix(pred_glm, testdf$gender)

# Look at the caret model list and search for models related to glm. You will find one you can use under the method name “glmboost”. 
# You do need to have the plyr and mboost packages loaded. Estimate the model and display it. This time, extend the variable list to include weight, exerany, and smoke100.

glmboost = train(gender~height + weight + exerany + smoke100,
                 data = traindf,
                 method ="glmboost")

glmboost

# Produce predictions for the test data in pred_glmboost.

pred_glmboost = predict(glmboost, testdf)
head(pred_glmboost)

# Create the confusion matrix for the test data and predictions.

confusionMatrix(pred_glmboost, testdf$gender)

# Try the gradient boosting model using method “gbm”. In the call to train, set verbose = FALSE. Do the usual.
# 1. Estimate the model
# 2. Display it
# 3. Make predictions for the test data
# 4. Make a confusion matrix for the test data

gbm = train(gender~height + weight + exerany + smoke100, data = traindf, 
            method = "gbm", 
            verbose = FALSE)
gbm

pred_gbm = predict(gbm, testdf)

confusionMatrix(pred_gbm, testdf$gender)

# Try a random forest using “ranger”.

ranger = train(gender~height + weight + exerany + smoke100, data = traindf, 
                method = "ranger", 
                verbose = FALSE)

ranger

pred_ranger = predict(ranger, testdf)

confusionMatrix(pred_ranger, testdf$gender)