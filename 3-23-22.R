# slide deck: Twitter 1

library(tidyverse)
library(rtweet)
library(httpuv)

# First run the code from Datacamp.
twts_emmy <- search_tweets("#Emmyawards", n = 200, include_rts = TRUE, lang = "en")

# View output for the first 5 columns and 10 rows
# this is base R; we're going to use dplyr
head(twts_emmy[,1:5], 10)

# I would rather work with dplyr than base R. I would also prefer to get some useful information.
# Use the dataframe to glimpse for the contents of a tweet and grab a few items of useful information. Then use select to extract these bits.

glimpse(twts_emmy)

# I’ll use screen_name, created_at, text, and location.
twts_emmy %>% 
  select(screen_name, created_at, text, location)

# First run the code from Datacamp.
# Extract tweets posted by the user @Cristiano
get_cris <- get_timeline("@Cristiano", n = 320)

# View output for the first 5 columns and 10 rows
# this is base R; we're going to use dplyr
head(get_cris[,1:5], 10)

# Use select() to get some more useful information.
get_cris %>% 
  select(screen_name, created_at, text, location)

# First the code from Datacamp. We need to get the dataframe of tweets about artificial intelligence ourselves.
tweets_ai = search_tweets("Artificial Intelligence", n = 200, include_rts = TRUE, lang = "en")

# Now run the code from Datacamp. 
# Create a table of users and tweet counts for the topic
sc_name <- table(tweets_ai$screen_name)

# Sort the table in descending order of tweet counts
sc_name_sort <- sort(sc_name, decreasing = TRUE)

# View sorted table for top 10 users
head(sc_name_sort, 10)

# Do the same thing with tidyverse code.
sc_name = tweets_ai %>% 
  group_by(screen_name) %>% 
  summarize(count = n()) %>% 
  ungroup() %>% 
  arrange(desc(count))

head(sc_name)

# Try to run the Datacamp code.
# Extract user data for the twitter accounts of 4 news sites

# The following line won't run
# users <- lookup_users("nytimes", "CNN", "FoxNews", "NBCNews")

# We need to do the following.

usrs = c("nytimes", "CNN", "FoxNews", "NBCNews")
users = lookup_users(usrs)

# Create a data frame of screen names and follower counts
user_df <- users[,c("screen_name","followers_count")]

# Display and compare the follower counts for the 4 news sites
user_df