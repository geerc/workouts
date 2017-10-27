# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
oct.19.2017 <- read.csv("~/GitHub/workouts/1k-400-200/oct_19_2017.csv")
oct.20.2016 <- read.csv("~/GitHub/workouts/1k-400-200/oct_20_2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
oct.19.2017 <- mutate(oct.19.2017, Moving.Time = Time)
oct.20.2016 <- mutate(oct.20.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
oct.19.2017 <- oct.19.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22), ] %>% select(Split, Moving.Time)
oct.20.2016 <- oct.20.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(oct.19.2017)[names(oct.19.2017) == "Moving.Time"] <- "Time"
names(oct.20.2016)[names(oct.20.2016) == "Moving.Time"] <- "Time"

# Insert blank row for extra 200 during oct 19 workout
split <- data.frame(Split = "4", Time = NA)
oct.20.2016 <- rbind(oct.20.2016[1:3, ], split, oct.20.2016[-(1:3), ])

#Renaming splits so as not go by 2s
oct.19.2017[2, 1] <- 2
oct.19.2017[3, 1] <- 3
oct.19.2017[4, 1] <- 4
oct.19.2017[5, 1] <- 5
oct.19.2017[6, 1] <- 6
oct.19.2017[7, 1] <- 7
oct.19.2017[8, 1] <- 8
oct.19.2017[9, 1] <- 9
oct.19.2017[10,1] <- 10

oct.20.2016[2, 1] <- 2
oct.20.2016[3, 1] <- 3
oct.20.2016[4, 1] <- 4
oct.20.2016[5, 1] <- 5
oct.20.2016[6, 1] <- 6
oct.20.2016[7, 1] <- 7
oct.20.2016[8, 1] <- 8
oct.20.2016[9, 1] <- 9
oct.20.2016[10,1] <- 10

# Reindex the rows to correct numbering
rownames(oct.19.2017) <- 1:nrow(oct.19.2017)
rownames(oct.20.2016) <- 1:nrow(oct.20.2016)

# Join data sets together
all.workouts <- full_join(oct.20.2016, oct.19.2017, by = "Split")

# Rename the headers of each workout to the year from Time.x and Time.y
names(all.workouts)[names(all.workouts) == "Time.x"] <- "October 19 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "October 20 2017"

# Makes new data table, optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`October 19 2016`, `October 20 2017`, key = "Date", value = "Time") %>% arrange(Split)

# Puts split number 10 at bottom after number 9
all.workouts.plot <- all.workouts.plot[c(1,2,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,3,4),]

# Reindex rows again
rownames(all.workouts.plot) <- 1:nrow(all.workouts.plot)

# Set Split column to double
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Plot the data
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path()
