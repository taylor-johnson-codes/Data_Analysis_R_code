# slide deck: Twitter 3

library(plyr)
library(tidyverse)
library(rtweet)
library(httpuv)
library(lubridate)

# Compare #rstats and #pandas
# Compare the two hashtags on the rate of posting. Use n = 500.
time_to_get = function(term, ntweets){
  search_tweets(term, n = ntweets) %>% 
    filter(is.na(reply_to_screen_name) &
             is_retweet == FALSE &
             is_quote == FALSE) %>% 
    summarize(max(created_at) - min(created_at))
}

time_to_get("#rstats", 500)
time_to_get("#pandas", 500)

# Compare Originality
# Use fract_original() to compare the originality of the postings for these two hashtags.
fract_original = function(term, ntweets){
  search_tweets(term, n = ntweets) %>% 
    mutate(is_orig = is.na(reply_to_screen_name) &
             is_retweet == FALSE &
             is_quote == FALSE) %>%
    summarize(mean(is_orig))
}

fract_original("#rstats", 500)
fract_original("#pandas", 500)

# Examine the distribution of languages for these two hashtags. Use n = 2000.

search_tweets("rstats",n = 2000) %>% 
  ggplot(aes(x = lang)) +
  geom_bar() +
  ggtitle("Language Distribution for #rstats")

search_tweets("pandas",n = 2000) %>% 
  ggplot(aes(x = lang)) +
  geom_bar() +
  ggtitle("Language Distribution for #pandas")

# Use get_timeline() to get and display the followers_count, friends_count and the golden ratio for the following screen names.
# @HadleyWickham  @juliasilge  @wesmckinn
tl = get_timeline(c("@HadleyWickham","@juliasilge","@wesmckinn"), n = 100)

tl %>% 
  group_by(screen_name) %>% 
  summarize(followers = mean(followers_count),
            friends = mean(friends_count)) %>% 
  ungroup() %>% 
  mutate(golden_ratio = followers/friends)

# Get the current trending topics in New York. Display the top 10.
get_trends("New York") %>% 
  arrange(desc(tweet_volume)) %>% 
  select(query, tweet_volume) %>% 
  distinct %>% 
  head(10)

# I found a topic that I knew nothing about in my results. At that time it was “SaudiArabianGP”. 
# How would I look at the text of some of the tweets on that topic. Do the same thing for something you don’t understand.
search_tweets("SaudiArabianGP", n = 10) %>% 
  select(text)

search_tweets("Hollywood", n = 10) %>% 
  select(text)

search_tweets("Will Smith", n = 10) %>% 
  select(text)

# Time Series Data from DataCamp
walmart_twts <- search_tweets("#walmart", n = 300, include_rts = FALSE, retryonratelimit = TRUE)
head(walmart_twts)
ts_plot(walmart_twts, by = "hours", color = "blue")

# Use the hour() and wday() functions from the lubridate package to see how these tweets vary over a week.
walmart_twts = walmart_twts %>% 
  select(created_at) %>% 
  mutate(day = wday(created_at, label = TRUE, abbr = TRUE), 
         hour = factor(hour(created_at)))  
# sometimes numeric values on the x axis show as fractional values; factor() turns the fractional values into whole numbers

walmart_twts %>% 
  ggplot(aes(x = hour, y = day)) +
  geom_count() +
  ggtitle("Walmart Tweets by Day of Week and Hour")