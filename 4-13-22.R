# slide deck: Logistic Regression
# This model is used for models with a binary outcome. As an example, we will consider the problem of identifying gender based on other variables. 

library(tidyverse)
library(pROC)

load("cdc2.Rdata")

# We could base our model on gender, but it is best to create a target which is either 0/1 or True/False. This leaves no doubt about which value we are predicting.
# Create a boolean variable is_male. It is true if the gender is “m”. Do a table of is_male and gender.

cdc2 = cdc2 %>% 
  mutate(is_male = gender == "m")

table(cdc2$gender, cdc2$is_male)
##     FALSE  TRUE
##   m     0  9566
##   f 10431     0

# For today’s exercise we will not split the data into train and test. If we were really serious, we would do this.

# For our first model, we’ll use just the variable height. Create model as a logistic regression model predicting is_male on the basis of height. Do a summary of model.
# Use glm() instead of lm()
# Include the argument “family = ‘binomial’” in the call.

model = glm(is_male ~ height, data = cdc2, family = "binomial")
summary(model)

# Create predicted probabilities for the observations in cdc2 using model. Include type = “response” to get probabilities as prediction. Call this vector probs.
probs = predict(model, data = cdc2, type = "response")

# We now have the probability that each of the observations has gender “m”. To convert the probability that an observation is male, we need a threshold probability, above which we will predict that is_male is true. 
# The sensible solution is to use the mean of is_male. Compute this and use it to get a vector of predictions, preds.
threshold = mean(cdc2$is_male)
preds = probs > threshold

# Now we can compute a value of accuracy by comparing preds with cdc2$is_male. Do this.
accuracy = mean(preds == cdc2$is_male)
accuracy  # 0.8507776

# The value of accuracy depends on both the model and the chosen threshold. The AUC, which depends on the ROC depends on the model alone. Recall the steps to construct this from the Datacamp course.
ROC = roc(cdc2$is_male, probs)

plot(ROC, col = "blue")

auc(ROC)  # Area under the curve: 0.9233
# perfect AUC is 1

# Put all of the steps above into a single block of code. Then use the code to examine another model, in which smoke100 has been added to the model. What happens to accuracy and AUC.
model = glm(is_male ~ height + smoke100, data = cdc2, family = "binomial")
summary(model)

probs = predict(model, data = cdc2, type = "response")

threshold = mean(cdc2$is_male)
preds = probs > threshold

accuracy = mean(preds == cdc2$is_male)
accuracy  # 0.8456769

ROC = roc(cdc2$is_male, probs)

plot(ROC, col = "blue")

auc(ROC)  # Area under the curve: 0.9247

# Try various combinations of variables and see if you can improve on the AUC.
# (repeat lines 50-65 for this; it will be an assignment)