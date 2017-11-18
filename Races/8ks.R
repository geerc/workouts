# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
oberlin.2017 <- read.csv("~/workouts/races/oberlin 2017.csv")
paul.short.2017 <- read.csv("~/workouts/races/paul short 2017.csv")
allegheny.classic.2017 <- read.csv("~/workouts/races/allegheny classic 2017.csv")
rowan.2016 <- read.csv("~/workouts/races/rowan 2016.csv")
paul.short.2016 <- read.csv("~/workouts/races/paul short 2016.csv")
st.vincent.2016 <- read.csv("~/workouts/races/st vincent 2016.csv")
conferences.2017 <- read.csv("~/workouts/races/conferences 2017.csv")

# Copy Time data to Moving.Time so that unneeded splits can be deleted
oberlin.2017 <- mutate(oberlin.2017, Moving.Time = Time)
paul.short.2017 <- mutate(paul.short.2017, Moving.Time = Time)
allegheny.classic.2017 <- mutate(allegheny.classic.2017, Moving.Time = Time)
rowan.2016 <- mutate(rowan.2016, Moving.Time = Time)
paul.short.2016 <- mutate(paul.short.2016, Moving.Time = Time)
st.vincent.2016 <- mutate(st.vincent.2016, Moving.Time = Time)
conferences.2017 <- mutate(conferences.2017, Moving.Time = Time)

# Delete all splits, leaving just the final time
oberlin.2017 <- oberlin.2017[-c(1), ] %>% select(Split, Moving.Time)
paul.short.2017 <- paul.short.2017[-c(1, 2, 3, 4, 5), ] %>% select(Split, Moving.Time)
allegheny.classic.2017 <- allegheny.classic.2017[-c(1, 2, 3, 4), ] %>% select(Split, Moving.Time)
rowan.2016 <- rowan.2016[-c(1), ] %>% select(Split, Moving.Time)
paul.short.2016 <- paul.short.2016[-c(1), ] %>% select(Split, Moving.Time)
st.vincent.2016 <- st.vincent.2016[-c(1), ] %>% select(Split, Moving.Time)
conferences.2017 <- conferences.2017[-c(1), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(oberlin.2017)[names(oberlin.2017) == "Moving.Time"] <- "Time"
names(paul.short.2017)[names(paul.short.2017) == "Moving.Time"] <- "Time"
names(allegheny.classic.2017)[names(allegheny.classic.2017) == "Moving.Time"] <- "Time"
names(rowan.2016)[names(rowan.2016) == "Moving.Time"] <- "Time"
names(paul.short.2016)[names(paul.short.2016) == "Moving.Time"] <- "Time"
names(st.vincent.2016)[names(st.vincent.2016) == "Moving.Time"] <- "Time"
names(conferences.2017)[names(conferences.2017) == "Moving.Time"] <- "Time"

# Reindex rows to correct numbering
rownames(oberlin.2017) <- 1:nrow(oberlin.2017)
rownames(paul.short.2017) <- 1:nrow(paul.short.2017)
rownames(allegheny.classic.2017) <- 1:nrow(allegheny.classic.2017)
rownames(rowan.2016) <- 1:nrow(rowan.2016)
rownames(paul.short.2016) <- 1:nrow(paul.short.2016)
rownames(st.vincent.2016) <- 1:nrow(st.vincent.2016)
rownames(conferences.2017) <- 1:nrow(conferences.2017)

# Join data sets together
all.workouts <- full_join(st.vincent.2016, paul.short.2016, by = "Split") %>%
  full_join(rowan.2016, by = "Split") %>%
  full_join(allegheny.classic.2017, by = "Split") %>%
  full_join(paul.short.2017, by = "Split") %>%
  full_join(oberlin.2017, by = "Split") %>%
  full_join(conferences.2017, by = "Split")

# Rename column headers to name of race
names(all.workouts)[names(all.workouts) == "Time.x"] <- "St. Vincent 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Paul Short 2016"
names(all.workouts)[names(all.workouts) == "Time.x.x"] <- "Rowan 2016"
names(all.workouts)[names(all.workouts) == "Time.y.y"] <- "Allegheny Classic 2017"
names(all.workouts)[names(all.workouts) == "Time.x.x.x"] <- "Paul Short 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y.y"]   <- "Oberlin 2017"
names(all.workouts)[names(all.workouts) == "Time"] <- "Conferences 2017"

# Mak new data table for plotting
all.workouts.plot <- gather(all.workouts, `Conferences 2017`, `Oberlin 2017`, `Paul Short 2017`, `Allegheny Classic 2017`, `Rowan 2016`, `Paul Short 2016`, `St. Vincent 2016`, key = "Race", value = "Time")

# Make split column count up from 1
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3
all.workouts.plot[4, 1] <- 4
all.workouts.plot[5, 1] <- 5
all.workouts.plot[6, 1] <- 6
all.workouts.plot[7, 1] <- 7

# Conver split to double
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Reverse order so most recent race is last
all.workouts.plot <- arrange(all.workouts.plot, desc(Split))

# Make split column count up from 1
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3
all.workouts.plot[4, 1] <- 4
all.workouts.plot[5, 1] <- 5
all.workouts.plot[6, 1] <- 6
all.workouts.plot[7, 1] <- 7

# New variable to allow grouping for plot
all.workouts.plot[1, 4] <- 1
all.workouts.plot <- fill(all.workouts.plot, V4)

# Plot
ggplot(data = all.workouts.plot, mapping= aes(x = Split, y = Time, group = V4)) +
  geom_path() +
  geom_vline(xintercept = 3.5)