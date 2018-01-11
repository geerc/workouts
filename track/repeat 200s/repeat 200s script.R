# Importing Libraries
library(tidyverse)
library(dplyr)

# Remember need to edit spreadsheet to put in average split time
# Import data sets for workouts
dec.9.2016 <- read.csv("~/workouts/track/repeat 200s/dec 9 2016.csv")
dec.23.2016 <- read.csv("~/workouts/track/repeat 200s/dec 23 2016.csv")
jan.5.2017 <- read.csv("~/workouts/track/repeat 200s/jan 5 2017.csv")
mar.3.2017 <- read.csv("~/workouts/track/repeat 200s/mar 3 2017.csv")
mar.21.2017 <- read.csv("~/workouts/track/repeat 200s/mar 21 2017.csv")
dec.7.2017 <- read.csv("~/workouts/track/repeat 200s/dec 7 2017.csv")
dec.16.2017 <- read.csv("~/workouts/track/repeat 200s/dec 16 2017.csv")
dec.21.2017 <- read.csv("~/workouts/track/repeat 200s/dec 21 2017.csv")
dec.27.2017 <- read.csv("~/workouts/track/repeat 200s/dec 27 2017.csv")
jan.7.2018 <- read.csv("~/workouts/track/repeat 200s/jan 7 2018.csv")
jan.11.2018 <- read.csv("~/workouts/track/repeat 200s/jan 11 2018.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
dec.9.2016 <- mutate(dec.9.2016, Moving.Time = Time)
dec.23.2016 <- mutate(dec.23.2016, Moving.Time = Time)
jan.5.2017 <- mutate(jan.5.2017, Moving.Time = Time)
mar.3.2017 <- mutate(mar.3.2017, Moving.Time = Time)
mar.21.2017 <- mutate(mar.21.2017, Moving.Time = Time)
dec.7.2017 <- mutate(dec.7.2017, Moving.Time = Time)
dec.16.2017 <- mutate(dec.16.2017, Moving.Time = Time)
dec.21.2017 <- mutate(dec.21.2017, Moving.Time = Time)
dec.27.2017 <- mutate(dec.27.2017, Moving.Time = Time)
jan.7.2018 <- mutate(jan.7.2018, Moving.Time = Time)
jan.11.2018 <- mutate(jan.11.2018, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
dec.9.2016 <- dec.9.2016[-c(1:18), ] %>% select(Split, Moving.Time)
dec.23.2016 <- dec.23.2016[-c(1:11), ] %>% select(Split, Moving.Time)
jan.5.2017 <- jan.5.2017[-c(1:18), ] %>% select(Split, Moving.Time)
mar.21.2017 <- mar.21.2017[-c(1:25), ] %>% select(Split, Moving.Time)
mar.3.2017 <- mar.3.2017[-c(1:26), ] %>% select(Split, Moving.Time)
dec.7.2017 <- dec.7.2017[-c(1:17), ] %>% select(Split, Moving.Time)
dec.16.2017 <- dec.16.2017[-c(1:17), ] %>% select(Split, Moving.Time)
dec.21.2017 <- dec.21.2017[-c(1:17), ] %>% select(Split, Moving.Time)
dec.27.2017 <- dec.27.2017[-c(1:17), ] %>% select(Split, Moving.Time)
jan.7.2018 <- jan.7.2018[-c(1:17), ] %>% select(Split, Moving.Time)
jan.11.2018 <- jan.11.2018[-c(1:17), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(dec.9.2016)[names(dec.9.2016) == "Moving.Time"] <- "Time"
names(dec.23.2016)[names(dec.23.2016) == "Moving.Time"] <- "Time"
names(jan.5.2017)[names(jan.5.2017) == "Moving.Time"] <- "Time"
names(mar.21.2017)[names(mar.21.2017) == "Moving.Time"] <- "Time"
names(mar.3.2017)[names(mar.3.2017) == "Moving.Time"] <- "Time"
names(dec.7.2017)[names(dec.7.2017) == "Moving.Time"] <- "Time"
names(dec.16.2017)[names(dec.16.2017) == "Moving.Time"] <- "Time"
names(dec.21.2017)[names(dec.21.2017) == "Moving.Time"] <- "Time"
names(dec.27.2017)[names(dec.27.2017) == "Moving.Time"] <- "Time"
names(jan.7.2018)[names(jan.7.2018) == "Moving.Time"] <- "Time"
names(jan.11.2018)[names(jan.11.2018) == "Moving.Time"] <- "Time"

# Reindex rows to correct numbering
rownames(dec.9.2016) <- 1:nrow(dec.9.2016)
rownames(dec.23.2016) <- 1:nrow(dec.23.2016)
rownames(jan.5.2017) <- 1:nrow(jan.5.2017)
rownames(mar.3.2017) <- 1:nrow(mar.3.2017)
rownames(mar.21.2017) <- 1:nrow(mar.21.2017)
rownames(dec.7.2017) <- 1:nrow(dec.7.2017)
rownames(dec.16.2017) <- 1:nrow(dec.16.2017)
rownames(dec.21.2017) <- 1:nrow(dec.21.2017)
rownames(dec.27.2017) <- 1:nrow(dec.27.2017)
rownames(jan.7.2018) <- 1:nrow(jan.7.2018)
rownames(jan.11.2018) <- 1:nrow(jan.11.2018)

# Join data sets together
all.workouts <- full_join(dec.9.2016, dec.23.2016, by = "Split") %>%
  full_join(jan.5.2017, by = "Split") %>%
  full_join(mar.3.2017, by = "Split") %>%
  full_join(mar.21.2017, by = "Split") %>%
  full_join(dec.7.2017, by = "Split") %>%
  full_join(dec.16.2017, by = "Split") %>%
  full_join(dec.21.2017, by = "Split") %>%
  full_join(dec.27.2017, by = "Split") %>%
  full_join(jan.7.2018, by = "Split") %>%
  full_join(jan.11.2018, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Dec 9 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Dec 23 2016"
names(all.workouts)[names(all.workouts) == "Time.x.x"] <- "Jan 5 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y"] <- "Mar 3 2017"
names(all.workouts)[names(all.workouts) == "Time.x.x.x"] <- "Mar 21 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y.y"] <- "Dec 7 2017"
names(all.workouts)[names(all.workouts) == "Time.x.x.x.x"] <- "Dec 16 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y.y.y"] <- "Dec 21 2017"
names(all.workouts)[names(all.workouts) == "Time.x.x.x.x.x"] <- "Dec 27 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y.y.y.y"] <- "Jan 7 2018"
names(all.workouts)[names(all.workouts) == "Time"] <- "Jan 11 2018"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Dec 9 2016`, 
                                             `Dec 23 2016`, 
                                             `Jan 5 2017`, 
                                             `Mar 3 2017`, 
                                             `Mar 21 2017`, 
                                             `Dec 7 2017`, 
                                             `Dec 16 2017`, 
                                             `Dec 21 2017`,
                                             `Dec 27 2017`,
                                             `Jan 7 2018`,
                                             `Jan 11 2018`,
                                             key = "Date", value = "Time")

# Give workouts numbers
all.workouts.plot[1, 1] <- 1
all.workouts.plot[2, 1] <- 2
all.workouts.plot[3, 1] <- 3
all.workouts.plot[4, 1] <- 4
all.workouts.plot[5, 1] <- 5
all.workouts.plot[6, 1] <- 6
all.workouts.plot[7, 1] <- 7
all.workouts.plot[8, 1] <- 8
all.workouts.plot[9, 1] <- 9
all.workouts.plot[10, 1] <- 10
all.workouts.plot[11, 1] <- 11

# New variable to allow grouping for plot
all.workouts.plot[1, 4] <- 1
all.workouts.plot <- fill(all.workouts.plot, V4)

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = V4)) +
  geom_path() +
  geom_point() +
  geom_vline(xintercept = 5.5)

