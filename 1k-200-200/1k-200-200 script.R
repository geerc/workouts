# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
aug.30.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Aug 30 2016.csv")
sep.12.2017 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 12 2017.csv")
sep.13.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 13 2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
aug.30.2016 <- mutate(aug.30.2016, Moving.Time = Time)
sep.12.2017 <- mutate(sep.12.2017, Moving.Time = Time)
sep.13.2016 <- mutate(sep.13.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
aug.30.2016 <- aug.30.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 2, 28, 30, 31), ] %>% select(Split, Moving.Time)
sep.12.2017 <- sep.12.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 2, 28, 30, 31), ] %>% select(Split, Moving.Time)
sep.13.2016 <- sep.13.2016[-c(1, 2, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 40), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(aug.30.2016)[names(aug.30.2016) == "Moving.Time"] <- "Time"
names(sep.12.2017)[names(sep.12.2017) == "Moving.Time"] <- "Time"
names(sep.13.2016)[names(sep.13.2016) == "Moving.Time"] <- "Time"

# Renaming splits so as not to go by 2s
aug.30.2016[1, 1] <- 1
aug.30.2016[2, 1] <- 2
aug.30.2016[3, 1] <- 3
aug.30.2016[4, 1] <- 4
aug.30.2016[5, 1] <- 5
aug.30.2016[6, 1] <- 6
aug.30.2016[7, 1] <- 7
aug.30.2016[8, 1] <- 8
aug.30.2016[9, 1] <- 9
aug.30.2016[10, 1] <- 10
aug.30.2016[11, 1] <- 11
aug.30.2016[12, 1] <- 12
aug.30.2016[13, 1] <- 13
aug.30.2016[14, 1] <- 14
aug.30.2016[15, 1] <- 15

sep.12.2017[1, 1] <- 1
sep.12.2017[2, 1] <- 2
sep.12.2017[3, 1] <- 3
sep.12.2017[4, 1] <- 4
sep.12.2017[5, 1] <- 5
sep.12.2017[6, 1] <- 6
sep.12.2017[7, 1] <- 7
sep.12.2017[8, 1] <- 8
sep.12.2017[9, 1] <- 9
sep.12.2017[10, 1] <- 10
sep.12.2017[11, 1] <- 11
sep.12.2017[12, 1] <- 12
sep.12.2017[13, 1] <- 13
sep.12.2017[14, 1] <- 14
sep.12.2017[15, 1] <- 15

sep.13.2016[1, 1] <- 1
sep.13.2016[2, 1] <- 2
sep.13.2016[3, 1] <- 3
sep.13.2016[4, 1] <- 4
sep.13.2016[5, 1] <- 5
sep.13.2016[6, 1] <- 6
sep.13.2016[7, 1] <- 7
sep.13.2016[8, 1] <- 8
sep.13.2016[9, 1] <- 9
sep.13.2016[10, 1] <- 10
sep.13.2016[11, 1] <- 11
sep.13.2016[12, 1] <- 12
sep.13.2016[13, 1] <- 13
sep.13.2016[14, 1] <- 14
sep.13.2016[15, 1] <- 15
sep.13.2016[16, 1] <- 16
sep.13.2016[17, 1] <- 17
sep.13.2016[18, 1] <- 18
