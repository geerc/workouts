# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
grove.city.2016 <- read.csv("~/workouts/races/grove city 2016.csv")
wooster.2016 <- read.csv("~/workouts/races/wooster 2016.csv")
chatham.2017 <- read.csv("~/workouts/races/chatham 2017.csv")
wooster.2017 <- read.csv("~/workouts/races/wooster 2017.csv")

# Copy Time data to Moving.Time so that unneeded splits can be deleted
grove.city.2016 <- mutate(grove.city.2016, Moving.Time = Time)
wooster.2016 <- mutate(wooster.2016, Moving.Time = Time)
chatham.2017 <- mutate(chatham.2017, Moving.Time = Time)
wooster.2017 <- mutate(wooster.2017, Moving.Time = Time)

# Delete all splits, leaving just the final time
grove.city.2016 <- grove.city.2016[-c(1:4), ] %>% select(Split, Moving.Time)
wooster.2016 <- wooster.2016[-c(1:4), ] %>% select(Split, Moving.Time)
chatham.2017 <- chatham.2017[-c(1:4), ] %>% select(Split, Moving.Time)
wooster.2017 <- wooster.2017[-c(1), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(grove.city.2016)[names(grove.city.2016) == "Moving.Time"] <- "Time"
names(wooster.2016)[names(wooster.2016) == "Moving.Time"] <- "Time"
names(chatham.2017)[names(chatham.2017) == "Moving.Time"] <- "Time"
names(wooster.2017)[names(wooster.2017) == "Moving.Time"] <- "Time"

# Reindex rows to correct numbering
rownames(grove.city.2016) <- 1:nrow(grove.city.2016)
rownames(wooster.2016) <- 1:nrow(wooster.2016)
rownames(chatham.2017) <- 1:nrow(chatham.2017)
rownames(wooster.2017) <- 1:nrow(wooster.2017)

# Join data sets together
all.workouts <- full_join(grove.city.2016, wooster.2016, by = "Split") %>%
  full_join(chatham.2017, by = "Split") %>%
  full_join(wooster.2017, by = "Split")

# Rename column headers to name of race
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Grove City 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Wooster 2016"
names(all.workouts)[names(all.workouts) == "Time.x.x"] <- "Chatham 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y"] <- "Wooster 2017"

# Mak new data table for plotting
all.workouts.plot <- gather(all.workouts, `Wooster 2017`, `Chatham 2017`, `Wooster 2016`, `Grove City 2016`, key = "Race", value = "Time")

# Make split column count up from 1
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3
all.workouts.plot[4, 1] <- 4

# Conver split to double
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Reverse order so most recent race is last
all.workouts.plot <- arrange(all.workouts.plot, desc(Split))

# Make split column count up from 1
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3
all.workouts.plot[4, 1] <- 4

# New variable to allow grouping for plot
all.workouts.plot[1, 4] <- 1
all.workouts.plot <- fill(all.workouts.plot, V4)

# Plot
ggplot(data = all.workouts.plot, mapping= aes(x = Split, y = Time, group = V4)) +
  geom_path() +
  geom_vline(xintercept = 2.5)
