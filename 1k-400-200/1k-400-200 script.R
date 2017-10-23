# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
oct_19_2017 <- read.csv("~/Running Data/1k-400-200/oct_19_2017.csv")
oct_20_2016 <- read.csv("~/Running Data/1k-400-200/oct_20_2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
oct_19_2017 <- mutate(oct_19_2017, Moving.Time = Time)
oct_20_2016 <- mutate(oct_20_2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
oct_19_2017 <- oct_19_2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22), ] %>% select(Split, Moving.Time)
oct_20_2016 <- oct_20_2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(oct_19_2017)[names(oct_19_2017) == "Moving.Time"] <- "Time"
names(oct_20_2016)[names(oct_20_2016) == "Moving.Time"] <- "Time"

# Insert blank row for extra 200 during oct 19 workout
split <- data.frame(Split = "4", Time = NA)
oct_20_2016 <- rbind(oct_20_2016[1:3, ], split, oct_20_2016[-(1:3), ])

#Renaming splits so as not go by 2s
oct_19_2017[2, 1] <- 2
oct_19_2017[3, 1] <- 3
oct_19_2017[4, 1] <- 4
oct_19_2017[5, 1] <- 5
oct_19_2017[6, 1] <- 6
oct_19_2017[7, 1] <- 7
oct_19_2017[8, 1] <- 8
oct_19_2017[9, 1] <- 9
oct_19_2017[10,1] <- 10

oct_20_2016[2, 1] <- 2
oct_20_2016[3, 1] <- 3
oct_20_2016[4, 1] <- 4
oct_20_2016[5, 1] <- 5
oct_20_2016[6, 1] <- 6
oct_20_2016[7, 1] <- 7
oct_20_2016[8, 1] <- 8
oct_20_2016[9, 1] <- 9
oct_20_2016[10,1] <- 10

# Reindex the rows to correct numbering
rownames(oct_19_2017) <- 1:nrow(oct_19_2017)
rownames(oct_20_2016) <- 1:nrow(oct_20_2016)

# Join data sets together
all_workouts <- full_join(oct_20_2016, oct_19_2017, by = "Split")

# Rename the headers of each workout to the year from Time.x and Time.y
names(all_workouts)[names(all_workouts) == "Time.x"] <- "October 19 2016"
names(all_workouts)[names(all_workouts) == "Time.y"] <- "October 20 2017"

# Makes new data table, optimized for plotting
all_workouts_plot <- all_workouts %>% gather(`October 19 2016`, `October 20 2017`, key = "Date", value = "Time") %>% arrange(Split)
