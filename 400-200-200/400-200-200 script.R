# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Oct.27.2016 <- read.csv("~/workouts/400-200-200/Oct 27 2016.csv") # My Laptop

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
#all.workouts = full_join(Oct.27.2016, , header = TRUE, sep = ",")

# Rename the headers of each workout to the year from Time.x and Time.y
#names(all.workouts)[names(all_400_200_200) == "Time.x"] <- "Oct 27 2016"

# New table optimized for plotting
#all.workouts.plot <- all.workouts %>% gather(`Oct 27 2016`, ``, key = "Date", value = "Time") %>% arrange(Split)

# Convert split column from char to double, and sort
#all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
#all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot data
ggplot(data = Oct.27.2016, mapping = aes(x = Split, y = Time)) +
  geom_point() +
  geom_vline(xintercept = 1.5) +
  geom_vline(xintercept = 3.5) +
  geom_vline(xintercept = 4.5) +
  geom_vline(xintercept = 6.5) +
  geom_vline(xintercept = 7.5) 

