# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Sep.22.2017 <- read.csv("~/workouts/Marathon Tempos/Sep 22 2017.csv")
Sep.23.2016 <- read.csv("~/workouts/Marathon Tempos/Sep 23 2016.csv")

# Delete rest splits and remove unnecessary columns
Sep.22.2017 <- Sep.22.2017[-c(1, 3, 4), ] %>% select(Split, Avg.Pace)
Sep.23.2016 <- Sep.23.2016[-c(1, 2, 8, 9, 10, 11), ] %>% select(Split, Avg.Pace)

# Rename Moving.Time to Time
names(Sep.22.2017)[names(Sep.22.2017) == "Moving.Time"] <- "Time"
names(Sep.23.2016)[names(Sep.23.2016) == "Moving.Time"] <- "Time"

# Renaming splits so as not to go by 2s
Sep.22.2017[1, 1] <- 1

Sep.23.2016[1, 1] <- 1
Sep.23.2016[2, 1] <- 2
Sep.23.2016[3, 1] <- 3
Sep.23.2016[4, 1] <- 4
Sep.23.2016[5, 1] <- 5

# Reindex rows to correct numbering
rownames(Sep.22.2017) <- 1:nrow(Sep.22.2017)
rownames(Sep.23.2016) <- 1:nrow(Sep.23.2016)

# Join data sets together
all.workouts <- full_join(Sep.22.2017, Sep.23.2016, by = "Split")

# Fill splits for Sep 22 workout
all.workouts <- fill(all.workouts, Avg.Pace.x)

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Avg.Pace.x"] <- "Sep 22 2017"
names(all.workouts)[names(all.workouts) == "Avg.Pace.y"] <- "Sep 23 2016"

# New table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Sep 22 2017`, `Sep 23 2016`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()