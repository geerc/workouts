# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Oct.27.2016 <- read.csv("~/workouts/Track/400-200-200/Oct 27 2016.csv")
feb.6.2018 <- read.csv("~/workouts/Track/400-200-200/feb.6.2018.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
Oct.27.2016 <- mutate(Oct.27.2016, Moving.Time = Time)
feb.6.2018 <- mutate(feb.6.2018, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Oct.27.2016 <- Oct.27.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), ] %>% select(Split, Moving.Time)
feb.6.2018 <- feb.6.2018[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(Oct.27.2016)[names(Oct.27.2016) == "Moving.Time"] <- "Time"
names(feb.6.2018)[names(feb.6.2018) == "Moving.Time"] <- "Time"

#Renaming splits so as not go by 2s
Oct.27.2016[2, 1] <- 2
Oct.27.2016[3, 1] <- 3
Oct.27.2016[4, 1] <- 4
Oct.27.2016[5, 1] <- 5
Oct.27.2016[6, 1] <- 6
Oct.27.2016[7, 1] <- 7
Oct.27.2016[8, 1] <- 8
Oct.27.2016[9, 1] <- 9

feb.6.2018[2, 1] <- 2
feb.6.2018[3, 1] <- 3
feb.6.2018[4, 1] <- 4
feb.6.2018[5, 1] <- 5
feb.6.2018[6, 1] <- 6
feb.6.2018[7, 1] <- 7
feb.6.2018[8, 1] <- 8
feb.6.2018[9, 1] <- 9

# Reindex the rows to correct numbering
rownames(Oct.27.2016) <- 1:nrow(Oct.27.2016)
rownames(feb.6.2018) <- 1:nrow(feb.6.2018)

# Join data sets together
all.workouts = full_join(Oct.27.2016, feb.6.2018, header = TRUE, sep = ",")

# Rename the headers of each workout to the year from Time.x and Time.y
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Oct 27 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Feb 6 2018"

# New table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Oct 27 2016`, 
                                             `Feb 6 2018`,
                                             key = "Date", 
                                             value = "Time") %>% 
  arrange(Split)

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot data
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()