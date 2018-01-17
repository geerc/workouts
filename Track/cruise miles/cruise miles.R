# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
jan.16.2018 <- read.csv("~/workouts/track/cruise miles/jan 16 2018.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
jan.16.2018 <- mutate(jan.16.2018, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
jan.16.2018 <- jan.16.2018[-c(2, 4, 6, 8, 10, 12, 14, 15), ] %>% 
  select(Split, Moving.Time)

# Rename Moving.Time to Time
names(jan.16.2018)[names(jan.16.2018) == "Moving.Time"] <- "Time"

# Renaming splits so as not to go by 2s
jan.16.2018[1, 1] <- 1
jan.16.2018[2, 1] <- 2
jan.16.2018[3, 1] <- 3
jan.16.2018[4, 1] <- 4
jan.16.2018[5, 1] <- 5
jan.16.2018[6, 1] <- 6
jan.16.2018[7, 1] <- 7

# Reindex rows to correct numbering
rownames(jan.16.2018) <- 1:nrow(jan.16.2018)

# Join data sets together
#all.workouts <- full_join(jan.16.2018, , by = "Split")

# Rename column headers to date of workout
#names(all.workouts)[names(all.workouts) == "Time.x"] <- "Jan 16 2018"

# Make data table optimized for plotting
#all.workouts.plot <- all.workouts %>% gather(`Jan 16 2018`, , key = "Date", value = "Time") %>% 
#  arrange(Split)

# Plot
ggplot(data = jan.16.2018, mapping = aes(x = Split, y = Time)) +
  geom_path() +
  geom_point()
