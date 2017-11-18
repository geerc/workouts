# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
nov.1.2016 <- read.csv("~/workouts/200-400-600 ladder/Nov 1 2016.csv")
oct.31.2017 <- read.csv("~/workouts/200-400-600 ladder/oct 31 2017.csv")

nov.1.2016$Split <- as.double(nov.1.2016$Split)
oct.31.2017$Split <- as.double(oct.31.2017$Split)

# Copy Time data to Moving.Time, so we can delete rest splits
nov.1.2016 <- mutate(nov.1.2016, Moving.Time = Time)
oct.31.2017 <- mutate(oct.31.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
nov.1.2016 <- nov.1.2016[-c(2, 4, 6, 8, 10, 12, 14, 16, 18 , 20, 21), ] %>% select(Split, Moving.Time)
oct.31.2017 <- oct.31.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18 , 20, 21), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(nov.1.2016)[names(nov.1.2016) == "Moving.Time"] <- "Time"
names(oct.31.2017)[names(oct.31.2017) == "Moving.Time"] <- "Time"

# Renaming splits so as not go by 2s
nov.1.2016[2, 1] <- 2
nov.1.2016[3, 1] <- 3
nov.1.2016[4, 1] <- 4
nov.1.2016[5, 1] <- 5
nov.1.2016[6, 1] <- 6
nov.1.2016[7, 1] <- 7
nov.1.2016[8, 1] <- 8
nov.1.2016[9, 1] <- 9
nov.1.2016[10,1] <- 10
  
oct.31.2017[2, 1] <- 2
oct.31.2017[3, 1] <- 3
oct.31.2017[4, 1] <- 4
oct.31.2017[5, 1] <- 5
oct.31.2017[6, 1] <- 6
oct.31.2017[7, 1] <- 7
oct.31.2017[8, 1] <- 8
oct.31.2017[9, 1] <- 9
oct.31.2017[10,1] <- 10

# Reindex rows to correct numbering
rownames(nov.1.2016) <- 1:nrow(nov.1.2016)
rownames(oct.31.2017) <- 1:nrow(oct.31.2017)

# Join Data Sets together
all.workouts <- full_join(nov.1.2016, oct.31.2017, by = "Split")

# Rename the headers of the columns to each workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Nov 1 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Oct 31 2017"

# Makes a new data table, optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Nov 1 2016`, `Oct 31 2017`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Plot it (will have to be changed if/when more workouts are added)
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_point() +
  geom_path()
