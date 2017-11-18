# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets
spire.2017 <- read.csv("~/workouts/800s/spire (1).csv")
mount.union.2017 <- read.csv("~/workouts/800s/Mount Union 2017 (1).csv")
tiffin.2017 <- read.csv("~/workouts/800s/tiffin 2017.csv")
kenyon.2017 <- read.csv("~/workouts/800s/kenyon 2017.csv")
gator.2017 <- read.csv("~/workouts/800s/gator 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
spire.2017 <- mutate(spire.2017, Moving.Time = Time)
mount.union.2017 <- mutate(mount.union.2017, Moving.Time = Time)
tiffin.2017 <- mutate(tiffin.2017, Moving.Time = Time)
kenyon.2017 <- mutate(kenyon.2017, Moving.Time = Time)
gator.2017 <- mutate(gator.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
spire.2017 <- spire.2017[-c(2), ] %>% select(Split, Moving.Time)
mount.union.2017 <- mount.union.2017[-c(2), ] %>% select(Split, Moving.Time)
tiffin.2017 <- tiffin.2017[-c(2), ] %>% select(Split, Moving.Time)
kenyon.2017 <- kenyon.2017[-c(2), ] %>% select(Split, Moving.Time)
gator.2017 <- gator.2017[-c(2), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(spire.2017)[names(spire.2017) == "Moving.Time"] <- "Time"
names(mount.union.2017)[names(mount.union.2017) == "Moving.Time"] <- "Time"
names(tiffin.2017)[names(tiffin.2017) == "Moving.Time"] <- "Time"
names(kenyon.2017)[names(kenyon.2017) == "Moving.Time"] <- "Time"
names(gator.2017)[names(gator.2017) == "Moving.Time"] <- "Time"

# Join data sets together
all.workouts <- full_join(spire.2017, mount.union.2017, by = "Split") %>%
  full_join(tiffin.2017, by = "Split") %>%
  full_join(kenyon.2017, by = "Split") %>%
  full_join(gator.2017, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Spire 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Mount Union 2017"
names(all.workouts)[names(all.workouts) == "Time.x.x"]   <- "Tiffin 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y"] <- "Kenyon 2017"
names(all.workouts)[names(all.workouts) == "Time"] <- "Gator 2017"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Spire 2017`, `Mount Union 2017`, `Tiffin 2017`, `Kenyon 2017`, `Gator 2017`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Convert split column to doubles
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Make split count up so it can be used as x-asix for plot
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3
all.workouts.plot[4, 1] <- 4
all.workouts.plot[5, 1] <- 5

# New variable to allow grouping for plot
all.workouts.plot[1, 4] <- 1
all.workouts.plot <- fill(all.workouts.plot, V4)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = V4)) +
  geom_path() +
  geom_point() +
  geom_vline(xintercept = 5.5)