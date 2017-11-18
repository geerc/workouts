# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets
spire.2017 <- read.csv("~/workouts/400s/spire.csv")
ashland.2017 <- read.csv("~/workouts/400s/ashland.csv")
conferences.2017 <- read.csv("~/workouts/400s/conferences.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
spire.2017 <- mutate(spire.2017, Moving.Time = Time)
ashland.2017 <- mutate(ashland.2017, Moving.Time = Time)
conferences.2017 <- mutate(conferences.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
spire.2017 <- spire.2017[-c(2), ] %>% select(Split, Moving.Time)
ashland.2017 <- ashland.2017[-c(2), ] %>% select(Split, Moving.Time)
conferences.2017 <- conferences.2017[-c(2), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(spire.2017)[names(spire.2017) == "Moving.Time"] <- "Time"
names(ashland.2017)[names(ashland.2017) == "Moving.Time"] <- "Time"
names(conferences.2017)[names(conferences.2017) == "Moving.Time"] <- "Time"

# Join data sets together
all.workouts <- full_join(spire.2017, ashland.2017, by = "Split") %>%
  full_join(conferences.2017, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Spire 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Ashland 2017"
names(all.workouts)[names(all.workouts) == "Time"]   <- "Conferences 2017"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Spire 2017`, `Ashland 2017`, `Conferences 2017`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Convert split column to doubles
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Make split count up so it can be used as x-asix for plot
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3

# New variable to allow grouping for plot
all.workouts.plot[1, 4] <- 1
all.workouts.plot <- fill(all.workouts.plot, V4)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = V4)) +
  geom_path() +
  geom_point() +
  geom_vline(xintercept = 3.5)