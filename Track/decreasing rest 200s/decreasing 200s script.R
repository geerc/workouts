# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
mar.16.2017 <- read.csv("~/workouts/Track/decreasing rest 200s/mar 16 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
mar.16.2017 <- mutate(mar.16.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
mar.16.2017 <- mar.16.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 29), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(mar.16.2017)[names(mar.16.2017) == "Moving.Time"] <- "Time"

# Renaming splits so as not to go by 2s
mar.16.2017[1, 1] <- 1
mar.16.2017[2, 1] <- 2
mar.16.2017[3, 1] <- 3
mar.16.2017[4, 1] <- 4
mar.16.2017[5, 1] <- 5
mar.16.2017[6, 1] <- 6
mar.16.2017[7, 1] <- 7
mar.16.2017[8, 1] <- 8
mar.16.2017[9, 1] <- 9
mar.16.2017[10, 1] <- 10
mar.16.2017[11, 1] <- 11
mar.16.2017[12, 1] <- 12
mar.16.2017[13, 1] <- 13
mar.16.2017[14, 1] <- 14

# Reindex rows to correct numbering
rownames(mar.16.2017) <- 1:nrow(mar.16.2017)

# Join sets together
all.workouts <- full_join(mar.16.2017, , by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Mar 16 2017"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Mar 16 2017`, ``, key = "Date", value = "Time") %>% 
  arrange(Split)

# Convert split to double
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()