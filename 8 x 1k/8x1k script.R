# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Oct.12.2016 <- read.csv("~/Running Data/8 x 1k/Oct 12 2016.csv")
Sep.26.2017 <- read.csv("~/Running Data/8 x 1k/Sep 26 2017.csv")
Sep.28.2016 <- read.csv("~/Running Data/8 x 1k/Sep 28 2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
Oct.12.2016 <- mutate(Oct.12.2016, Moving.Time = Time)
Sep.26.2017 <- mutate(Sep.26.2017, Moving.Time = Time)
Sep.28.2016 <- mutate(Sep.28.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Oct.12.2016 <- Oct.12.2016[-c(2, 4, 6), ] %>% select(Split, Moving.Time)
Sep.26.2017 <- Sep.26.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 17), ] %>% select(Split, Moving.Time)
Sep.28.2016 <- Sep.28.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time

#Renaming splits so as not go by 2s

# Reindex the rows to correct numbering


