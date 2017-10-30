# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Aug.30.2016 <- read.csv("~/GitHub/workouts/1k-400-200/Aug 30 2017.csv")
Sep.12.2017 <- read.csv("~/GitHub/workouts/1k-400-200/Sep 12 2017.csv")
Sep.13.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 13 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
Aug.30.2016 <- mutate(Aug.30.2016, Moving.Time = Time)
Sep.12.2017 <- mutate(Sep.12.2017, Moving.Time = Time)
Sep.13.2016 <- mutate(Sep.13.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Aug.30.2016 <- Aug.30.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31), ] %>% select(Split, Moving.Time)
Sep.12.2017 <- Sep.12.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31), ] %>% select(Split, Moving.Time)
Sep.13.2016 <- Sep.13.2016[-c(1, 2, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 25, 27, 29, 31, 33, 35, 37, 39, 40), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(Aug.30.2016)[names(Aug.30.2016) == "Moving.Time"] <- "Time"
names(Sep.12.2017)[names(Sep.12.2017) == "Moving.Time"] <- "Time"
names(Sep.13.2016)[names(Sep.13.2016) == "Moving.Time"] <- "Time"

#Renaming splits so as not go by 2s
Aug.30.2016[2, 1] <- 2
Aug.30.2016[3, 1] <- 3
Aug.30.2016[4, 1] <- 4
Aug.30.2016[5, 1] <- 5
Aug.30.2016[6, 1] <- 6
Aug.30.2016[7, 1] <- 7
Aug.30.2016[8, 1] <- 8
Aug.30.2016[9, 1] <- 9
Aug.30.2016[10,1] <- 10
Aug.30.2016[11,1] <- 11
Aug.30.2016[12,1] <- 12
Aug.30.2016[13,1] <- 13
Aug.30.2016[14,1] <- 14
Aug.30.2016[15,1] <- 15

Sep.12.2017[2, 1] <- 2
Sep.12.2017[3, 1] <- 3
Sep.12.2017[4, 1] <- 4
Sep.12.2017[5, 1] <- 5
Sep.12.2017[6, 1] <- 6
Sep.12.2017[7, 1] <- 7
Sep.12.2017[8, 1] <- 8
Sep.12.2017[9, 1] <- 9
Sep.12.2017[10,1] <- 10
Sep.12.2017[11,1] <- 11
Sep.12.2017[12,1] <- 12
Sep.12.2017[13,1] <- 13
Sep.12.2017[14,1] <- 14
Sep.12.2017[15,1] <- 15

Sep.13.2016[1, 1] <- 1
Sep.13.2016[2, 1] <- 2
Sep.13.2016[3, 1] <- 3
Sep.13.2016[4, 1] <- 4
Sep.13.2016[5, 1] <- 5
Sep.13.2016[6, 1] <- 6
Sep.13.2016[7, 1] <- 7
Sep.13.2016[8, 1] <- 8
Sep.13.2016[9, 1] <- 9
Sep.13.2016[10,1] <- 10
Sep.13.2016[11,1] <- 11
Sep.13.2016[12,1] <- 12
Sep.13.2016[13,1] <- 13
Sep.13.2016[14,1] <- 14
Sep.13.2016[15,1] <- 15
Sep.13.2016[16,1] <- 16
Sep.13.2016[17,1] <- 17
Sep.13.2016[18,1] <- 18

# Reindex the rows to correct numbering
rownames(Aug.30.2016) <- 1:nrow(Aug.30.2016)
rownames(Sep.12.2017) <- 1:nrow(Sep.12.2017)
rownames(Sep.13.2016) <- 1:nrow(Sep.13.2016)

# Join data sets together
first.join <- full_join(Aug.30.2016, Sep.12.2017, by = "Split")
all.workouts <- full_join(first.join, Sep.13.2016, by = "Split")
rm(first.join)

# Rename the headers of each workout to the year from Time.x and Time.y
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Aug 20 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Sep 12 2017"
names(all.workouts)[names(all.workouts) == "Time"] <- "Sep 13 2016"

# Makes new data table, optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Aug 20 2016`, `Sep 12 2017`, `Sep 13 2016`, key = "Date", value = "Time") %>% arrange(Split)

# Set split to type double
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Order the data by split
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot it
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) + 
  geom_path()