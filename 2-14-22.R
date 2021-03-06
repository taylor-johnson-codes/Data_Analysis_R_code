# Slide deck: Importing Weather Data
# weather data/csv file obtained from NOAA website 
# (order/use shopping cart to select what you want then the file will be emailed to you, it's free)

library(tidyverse)
library(readr)

# load .csv file
# Environment tab - Import dataset - From Text(readr) - Browse and select file - Import

# Use readr and change the type of the Date column to “character”.
oly_airport <- read_csv("olympia_weather.csv", col_types = cols(DATE = col_character()))

# Use glimpse() on oly_airport.
glimpse(oly_airport)

# The character column DATE contains dates in ISO-8601 format. Use as.date() to convert it and run glimpse again.
oly_airport$DATE = as.Date(oly_airport$DATE)
glimpse(oly_airport)

# Do a summary() and check for anomalies.
summary(oly_airport)

# Inspect the NA values and drop these records.
oly_airport %>% 
  filter(is.na(TMAX) | is.na(TMIN))  # view NA values in TMAX and TMIN columns

oly_airport = oly_airport %>% 
  drop_na()  # drop observations with NA values

summary(oly_airport)

library(ggplot2)

# Get density with rug plots for TMAX and TMIN.
oly_airport %>% 
  ggplot(aes(x = TMAX)) +
  geom_density() +
  geom_rug() +
  ggtitle("TMAX")
# Note the peak at a moderate temperature and a shoulder with a secondary peak to the right of the primary peak.

oly_airport %>% 
  ggplot(aes(x = TMIN)) +
  geom_density() +
  geom_rug() +
  ggtitle("TMIN")
# Note the pronounced left skew and the single primary peak with weak shoulders to the left and right.

# Load the package lubridate. Then use the functions year(), month() and day() to create the variables yr, mo, and dy. 
# Make these variables factors. Use glimpse() and summary() to verify the results.
library(lubridate)

oly_airport  = oly_airport %>% 
  mutate(yr = factor(year(DATE)),
         mo = factor(month(DATE)),
         dy = factor(day(DATE)))

glimpse(oly_airport)
summary(oly_airport)

# Save the File. You will be able to get the data without rerunning this.
save(oly_airport, file = "oly_airport_saved_from_2-14-22.Rdata")