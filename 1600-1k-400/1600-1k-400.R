# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Sep.19.2017 <- read.csv("~/workouts/1600-1k-400/Sep 19 2017.csv")
Sep.20.2016 <- read.csv("~/workouts/1600-1k-400/sep 20 2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
Sep.19.2017 <- mutate(Sep.19.2017, Moving.Time = Time)
Sep.20.2016 <- mutate(Sep.20.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Sep.19.2017 <- Sep.19.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), ] %>% select(Split, Moving.Time)
Sep.20.2016 <- Sep.20.2016[-c(2, 3, 5, 6, 8, 10, 12, 14, 16, 18, 20, 21, 22), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(Sep.19.2017)[names(Sep.19.2017) == "Moving.Time"] <- "Time"
names(Sep.20.2016)[names(Sep.20.2016) == "Moving.Time"] <- "Time"

#Renaming splits so as not go by 2s
Sep.19.2017[2, 1] <- 2
Sep.19.2017[3, 1] <- 3
Sep.19.2017[4, 1] <- 4
Sep.19.2017[5, 1] <- 5
Sep.19.2017[6, 1] <- 6
Sep.19.2017[7, 1] <- 7
Sep.19.2017[8, 1] <- 8
Sep.19.2017[9, 1] <- 9

Sep.20.2016[2, 1] <- 2
Sep.20.2016[3, 1] <- 3
Sep.20.2016[4, 1] <- 4
Sep.20.2016[5, 1] <- 5
Sep.20.2016[6, 1] <- 6
Sep.20.2016[7, 1] <- 7
Sep.20.2016[8, 1] <- 8
Sep.20.2016[9, 1] <- 9

# Reindex the rows to correct numbering
rownames(Sep.19.2017) <- 1:nrow(Sep.19.2017)
rownames(Sep.20.2016) <- 1:nrow(Sep.20.2016)

# Join data sets together
all.workouts <- full_join(Sep.19.2017, Sep.20.2016, by = "Split")

# Rename columns of table
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Sep 19 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Sep 20 2016"

# Makes new data table, optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Sep 19 2017`, `Sep 20 2016`, key = "Date", value = "Time") %>% arrange(Split)

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot it (vertical lines to distinguish different length splits)
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point() +
  geom_vline(xintercept = 2.5) +
  geom_vline(xintercept = 5.5)
