# Giving us an overview of some things we'll learn in this course.

# Slide deck: A Sample Data Analysis/Gender Height and Weight
# Explore the relationships among age, gender, height, and weight.

# I’ll use a sample of records from the Behavioral Risk Factors Surveillance System (BRFSS) conducted by the Centers for Disease Control (CDC).
# The data I used is available from Openintro.org. See https://www.openintro.org/book/statdata/?data=cdc.

load("cdc.Rdata")

# Determine the structure of the object CDC.
str(cdc)

# Add New Variables (adds these columns to the dataset):
# BMI: The actual BMI
# BMICat: A categorical version of BMI
# BMIDes: The desired BMI based on wtdesire
# BMIDesCat: A categorical version of the desired BMI
# DesActRatio: The ratio of the desired BMI to the actual BMI. Note that a person who is satisfied with their current rate has a ratio of 1.0.

cdc$BMI = (cdc$weight*703)/(cdc$height)^2

cdc$BMIDes = (cdc$wtdesire*703)/(cdc$height)^2

cdc$DesActRatio = cdc$BMIDes/cdc$BMI

cdc$BMICat = cut(cdc$BMI,c(18,5,24.9,29.9,39.9,200),labels = 
  c("Underweight","Normal","Overweight", "Obese","Morbidly Obese"),include.lowest=T)

cdc$BMIDesCat = cut(cdc$BMIDes,c(18,5,24.9,29.9,39.9,200),labels = 
  c("Underweight","Normal","Overweight", "Obese","Morbidly Obese"),include.lowest=T)

cdc$ageCat = cut_number(cdc$age,n=4,labels=c("18-31","32-43","44-57","58-99"))

table(cdc$BMICat,cdc$BMIDesCat)

# Examine the data and look for anomalies.
summary(cdc)

# Look at the records which have unusual values.
cdc[cdc$height==93,]
cdc[cdc$weight==68,]
cdc[cdc$wtdesire==680,]
cdc[cdc$BMIDes > 50,]
cdc[cdc$BMIDes < 10,]

# Remove Anomalies
Rejects = cdc$BMIDes < 10 | 
  (cdc$BMIDes > 50 & cdc$DesActRatio > 1.0) 

table(Rejects)

Keepers = !Rejects

table(Keepers)

cdc = cdc[Keepers,]

summary(cdc)


# The following graphics demonstrate the ggplot2 package.
library(ggplot2)

ggplot(data = cdc,aes(gender,height)) + 
  geom_boxplot() +
  ggtitle("Men are Taller")

ggplot(data = cdc,aes(gender,weight)) + 
  geom_boxplot() +
  ggtitle("Men are Heavier")

ggplot(data = cdc,aes(gender,BMI)) + 
  geom_boxplot() +
  ggtitle("BMI Reduces the Gender Gap")

# BOX PLOTS
# To compare the distribution of a numeric variable among several categories
# The whole box represents half of the distribution (25th to 75th percentile)
# The thick line in the box represents the median
# The vertical lines on the top and bottom of the box are called whiskers
# The dots at the end of the whiskers are outliers


# Do a scatterplot of height and weight.
ggplot(data = cdc,(aes(x = height,y = weight))) +
  geom_point()

# The large number of points obscures the detail, but some upward drift to the right is apparent. It makes sense to create a linear model.
# lm() provides us the linear regression equation which helps us to predict the data.
lm1 = lm(weight~height,data = cdc)

summary(lm1)

# This model has a residual standard error of 33.32. Think of this as the typical error made by the model. 
# The estimated coefficient of height indicates that an extra inch of height adds an average 5.40 pounds.

# Let’s see what adding gender to the model does.
lm2 = lm(weight~height+gender,data = cdc)

summary(lm2)

# There is a small reduction of the residual standard error. The increase in weight associated with an extra inch of height is reduced to 4.37, and 
# we see that after accounting for height, we should reduce the predicted weight for a female by 11.93 pounds.


# Examine an Aggregate Relationship
# This section demonstrates some features added to R in the dplyr package, including piping.
library(dplyr)

cdc %>%
  select(height,gender,weight) %>%
  group_by(height,gender) %>%
  summarize(mean_weight = mean(weight),
            sd_weight = sd(weight),
            n=n() )%>%
  ungroup() -> c2

c2  # shows the data in a tibble in the console
# When you print a tibble, it only shows the first ten rows and all the columns that fit on one screen. 
# It also prints an abbreviated description of the column type, and uses font styles and color for highlighting.

p = ggplot(c2, aes(x=height, y=mean_weight, color=gender, size=n))

p + geom_point()

# Look at c2. We’ve restructured our data into a different shape. Look at it.
head(c2,10)
tail(c2,10)

c2 %>% 
  ggplot(aes(x = height, y = mean_weight, size = n, color = gender)) + 
  geom_point()


# Note that average BMI varies with age for both genders. It rises until about 60 and then declines. 
# The yellow curve is a “loess” smoother, which summarizes the behavior of the points in the scatterplot.
ggplot(data=cdc,aes(x=age,y=BMI,color=BMI)) +
  geom_point() +
  geom_smooth(method = "loess", color = "yellow") +
  facet_wrap(~gender,nrow=2)


# Exploring Intentions. As before the yellow curve is a loess smoother, which describes the overall pattern in the scatterplot. 
# The red line separates the points which indicate a desire to gain weight (above the line) from those which indicate a desire to lose weight (below the line).
d <- ggplot(data = cdc,aes(x=BMI,y=BMIDes,color=DesActRatio)) 

d1 = d + 
  geom_point(aes(alpha=.1)) +
  geom_smooth(method="loess",color="yellow") +
  geom_abline(slope=1,intercept=0,color="red")

d1

d2 = d1 +
  facet_wrap(~gender,nrow=2) +
  ggtitle("Actual vs Desired BMI by Gender")

d2

d3 = d1 + 
  facet_grid(gender~ageCat) +
  ggtitle("Actual vs Desired BMI by Gender and Age")

d3