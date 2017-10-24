# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Oct.27.2016 <- read.csv("~/Running Data/400-200-200/Oct 27 2016.csv") # Alden Computers

Oct.27.2016 <- read.csv("~/Running Data/400-200-200/Oct 27 2016.csv") # My Laptop


# Copy Time data to Moving.Time, so we can delete rest splits
Oct.27.2016 <- mutate(Oct.27.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
Oct.27.2016 <- Oct.27.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 19), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(Oct.27.2016)[names(Oct.27.2016) == "Moving.Time"] <- "Time"

#Renaming splits so as not go by 2s
Oct.27.2016[2, 1] <- 2
Oct.27.2016[3, 1] <- 3
Oct.27.2016[4, 1] <- 4
Oct.27.2016[5, 1] <- 5
Oct.27.2016[6, 1] <- 6
Oct.27.2016[7, 1] <- 7
Oct.27.2016[8, 1] <- 8
Oct.27.2016[9, 1] <- 9

# Reindex the rows to correct numbering
rownames(Oct.27.2016) <- 1:nrow(Oct.27.2016)

# Join data sets together
all_workouts = full_join(Oct.27.2016, , header = TRUE, sep = ",")

# Rename the headers of each workout to the year from Time.x and Time.y
names(all_workouts)[names(all_400_200_200) == "Time.x"] <- "Oct.27.2016"

# Plot data
ggplot(data = all_workouts, mapping = aes(x = Split, y = Time, group = Date, Color = Date)) + 
  geom_path()

