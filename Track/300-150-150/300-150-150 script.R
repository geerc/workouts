# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
feb.16.2017 <- read.csv("~/GitHub/workouts/Track/300-150-150/feb 16 2017.csv")
mar.14.2017 <- read.csv("~/GitHub/workouts/Track/300-150-150/mar 14 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
feb.16.2017 <- mutate(feb.16.2017, Moving.Time = Time)
mar.14.2017 <- mutate(mar.14.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
feb.16.2017 <- feb.16.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), ] %>% select(Split, Moving.Time)
mar.14.2017 <- mar.14.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(feb.16.2017)[names(feb.16.2017) == "Moving.Time"] <- "Time"
names(mar.14.2017)[names(mar.14.2017) == "Moving.Time"] <- "Time"

# Rename splits to go count up from 1
feb.16.2017[1, 1] <- 1
feb.16.2017[2, 1] <- 2
feb.16.2017[3, 1] <- 3
feb.16.2017[4, 1] <- 4
feb.16.2017[5, 1] <- 5
feb.16.2017[6, 1] <- 6
feb.16.2017[7, 1] <- 7
feb.16.2017[8, 1] <- 8
feb.16.2017[9, 1] <- 9

mar.14.2017[1, 1] <- 1
mar.14.2017[2, 1] <- 2
mar.14.2017[3, 1] <- 3
mar.14.2017[4, 1] <- 4
mar.14.2017[5, 1] <- 5
mar.14.2017[6, 1] <- 6
mar.14.2017[7, 1] <- 7
mar.14.2017[8, 1] <- 8
mar.14.2017[9, 1] <- 9

# Reindex rows to correct numbering
rownames(feb.16.2017) <- 1:nrow(feb.16.2017)
rownames(mar.14.2017) <- 1:nrow(mar.14.2017)

# Join sets together
all.workouts <- full_join(feb.16.2017, mar.14.2017, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Feb 16 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Mar 14 2017"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Feb 16 2017`, `Mar 14 2017`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()