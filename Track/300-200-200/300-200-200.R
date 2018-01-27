# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
jan.25.2018 <- read.csv("~/workouts/track/300-200-200/jan 25 2018.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
jan.25.2018 <- mutate(jan.25.2018, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
jan.25.2018 <- jan.25.2018[-c(1:18), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(jan.25.2018)[names(jan.25.2018) == "Moving.Time"] <- "Time"

# Reindex rows to correct numbering
rownames(jan.25.2018) <- 1:nrow(jan.25.2018)

# Join data sets together
all.workouts <- full_join(jan.25.2018, , by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Jan 25 2018"
names(all.workouts)[names(all.workouts) == "Time.y"] <- ""

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Jan 25 2018`, 
                                             ``, 
                                             key = "Date", value = "Time")

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = V4)) +
  geom_path() +
  geom_point()s
