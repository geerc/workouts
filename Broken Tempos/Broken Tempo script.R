# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Sep.5.2017 <- read.csv("~/Running Data/Broken Tempos/Sep 5 2017.csv")

# Copy Time to Moving.Time so we can delete rest splits
Sep.5.2017 <- mutate(Sep.5.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Sep.5.2017 <- Sep.5.2017[-c(1, 2, 3, 6, 8, 10, 12, 14, 16, 17, 19, 21, 23, 25, 26, 27, 28), ] %>% select(Split, Moving.Time)