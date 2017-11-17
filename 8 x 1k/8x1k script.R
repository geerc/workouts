# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Oct.12.2016 <- read.csv("~/workouts/8 x 1k/Oct 12 2016.csv") # My Laptop
Sep.26.2017 <- read.csv("~/workouts/8 x 1k/Sep 26 2017.csv")
Sep.28.2016 <- read.csv("~/workouts/8 x 1k/Sep 28 2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
Oct.12.2016 <- mutate(Oct.12.2016, Moving.Time = Time)
Sep.26.2017 <- mutate(Sep.26.2017, Moving.Time = Time)
Sep.28.2016 <- mutate(Sep.28.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Oct.12.2016 <- Oct.12.2016[-c(2, 4, 6), ] %>% select(Split, Moving.Time)
Sep.26.2017 <- Sep.26.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 17), ] %>% select(Split, Moving.Time)
Sep.28.2016 <- Sep.28.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(Oct.12.2016)[names(Oct.12.2016) == "Moving.Time"] <- "Time"
names(Sep.26.2017)[names(Sep.26.2017) == "Moving.Time"] <- "Time"
names(Sep.28.2016)[names(Sep.28.2016) == "Moving.Time"] <- "Time"

#Renaming splits so as not go by 2s
Oct.12.2016[2, 1] <- 2
Oct.12.2016[3, 1] <- 3

Sep.26.2017[2, 1] <- 2
Sep.26.2017[3, 1] <- 3
Sep.26.2017[4, 1] <- 4
Sep.26.2017[5, 1] <- 5
Sep.26.2017[6, 1] <- 6
Sep.26.2017[7, 1] <- 7
Sep.26.2017[8, 1] <- 8

Sep.28.2016[2, 1] <- 2
Sep.28.2016[3, 1] <- 3
Sep.28.2016[4, 1] <- 4
Sep.28.2016[5, 1] <- 5
Sep.28.2016[6, 1] <- 6

# Reindex the rows to correct numbering
rownames(Oct.12.2016) <- 1:nrow(Oct.12.2016)
rownames(Sep.26.2017) <- 1:nrow(Sep.26.2017)
rownames(Sep.28.2016) <- 1:nrow(Sep.28.2016)

# Join the workouts together
first.join <- full_join(Oct.12.2016, Sep.26.2017, by = "Split")
all.workouts <- full_join(first.join, Sep.28.2016, by = "Split")
rm(first.join)

# Renames column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Oct 12 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Sep 26 2017"
names(all.workouts)[names(all.workouts) == "Time"]   <- "Sep 28 2016"

# Remove 1:50 1k
all.workouts[3, 2] <- NA

# Makes new data table, optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Oct 12 2016`, `Sep 26 2017`, `Sep 28 2016`, key = "Date", value = "Time") %>% arrange(Split)

# Convert Split column to doubles from characters, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot the table
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()
