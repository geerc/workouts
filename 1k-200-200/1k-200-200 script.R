# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
aug.30.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Aug 30 2016.csv")
sep.12.2017 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 12 2017.csv")
sep.13.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 13 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
aug.30.2016 <- mutate(aug.30.2017, Moving.Time = Time)
sep.12.2017 <- mutate(sep.12.2017, Moving.Time = Time)
sep.13.2016 <- mutate(sep.13.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
aug.30.2016 <- aug.30.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 2, 28, 30, 31), ] %>% select(Split, Moving.Time)
sep.12.2017 <- aug.12.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 2, 28, 30, 31), ] %>% select(Split, Moving.Time)
sep.13.2016 <- sep.13.2016[-c(1, 2, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 40), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(aug.30.2016)[names(aug.30.2016) == "Moving.Time"] <- "Time"
names(sep.12.2017)[names(sep.12.2017) == "Moving.Time"] <- "Time"
names(sep.13.2016)[names(sep.13.2016) == "Moving.Time"] <- "Time"

# Renaming splits so as not to go by 2s
aug.30.2016[1, 1] <- 1
