# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
feb.2.2017 <- read.csv("~/GitHub/workouts/Track/150 repeats/feb 2 2017.csv")
apr.25.2017 <- read.csv("~/GitHub/workouts/Track/150 repeats/apr 25 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
feb.2.2017 <- mutate(feb.2.2017, Moving.Time = Time)
apr.25.2017 <- mutate(apr.25.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
feb.2.2017 <- feb.2.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 21), ] %>% select(Split, Moving.Time)
apr.25.2017 <- apr.25.2017[-c(2, 4, 6, 8, 10, 12, 14, 15), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(feb.2.2017)[names(feb.2.2017) == "Moving.Time"] <- "Time"
names(apr.25.2017)[names(apr.25.2017) == "Moving.Time"] <- "Time"

# Rename splits to go count up from 1
feb.2.2017[1, 1] <- 1
feb.2.2017[2, 1] <- 2
feb.2.2017[3, 1] <- 3
feb.2.2017[4, 1] <- 4
feb.2.2017[5, 1] <- 5
feb.2.2017[6, 1] <- 6
feb.2.2017[7, 1] <- 7
feb.2.2017[8, 1] <- 8
feb.2.2017[9, 1] <- 9
feb.2.2017[10, 1] <- 10

apr.25.2017[1, 1] <- 1
apr.25.2017[2, 1] <- 2
apr.25.2017[3, 1] <- 3
apr.25.2017[4, 1] <- 4
apr.25.2017[5, 1] <- 5
apr.25.2017[6, 1] <- 6
apr.25.2017[7, 1] <- 7


# Reindex rows to correct numbering
rownames(feb.2.2017) <- 1:nrow(feb.2.2017)
rownames(apr.25.2017) <- 1:nrow(apr.25.2017)

# Join sets together
all.workouts <- full_join(feb.2.2017, apr.25.2017, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Feb 2 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Apr 25 2017"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Feb 2 2017`, `Apr 25 2017`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Convert splits to doubles
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Sort by split
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()
