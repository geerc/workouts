# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Aug.25.2017 <- read.csv("~/workouts/Tempos/Aug 25 2017.csv") # Alden Computers
Oct.17.2017 <- read.csv("~/workouts/Tempos/Oct.17.2017.csv")
Sep.14.2017 <- read.csv("~/workouts/Tempos/Sep 14 2017.csv")
Oct.18.2016 <- read.csv("~/workouts/Tempos/Oct 17 2016.csv")
Sep.15.2016 <- read.csv("~/workouts/Tempos/Sep 15 2016.csv")

Aug.25.2017 <- read.csv("~/Github/workouts/Tempos/Aug 25 2017.csv") # My Laptop
Oct.17.2017 <- read.csv("~/Github/workouts/Tempos/Oct 17 2017.csv")
Sep.14.2017 <- read.csv("~/Github/workouts/Tempos/Sep 14 2017.csv")
Oct.18.2016 <- read.csv("~/Github/workouts/Tempos/Oct 18 2016.csv")
Sep.15.2016 <- read.csv("~/Github/workouts/Tempos/Sep 15 2016.csv")

# Delete rest splits and remove unnecessary columns
Aug.25.2017 <- Aug.25.2017[-c(1, 2, 7, 8, 9, 10, 11), ] %>% select(Split, Avg.Pace)
Oct.17.2017 <- Oct.17.2017[-c(1, 2, 3, 8, 9, 10, 11), ] %>% select(Split, Avg.Pace)
Oct.18.2016 <- Oct.18.2016[-c(1, 3, 4, 5), ] %>% select(Split, Avg.Pace)
Sep.14.2017 <- Sep.14.2017[-c(1, 2, 3, 8, 9, 10, 11), ] %>% select(Split, Avg.Pace)
Sep.15.2016 <- Sep.15.2016[-c(1, 2, 7, 8, 9), ] %>% select(Split, Avg.Pace)

#Renaming splits to start at 1
Aug.25.2017[1, 1] <- 1
Aug.25.2017[2, 1] <- 2
Aug.25.2017[3, 1] <- 3
Aug.25.2017[4, 1] <- 4

Oct.17.2017[1, 1] <- 1
Oct.17.2017[2, 1] <- 2
Oct.17.2017[3, 1] <- 3
Oct.17.2017[4, 1] <- 4

Oct.18.2016[1, 1] <- 1
Oct.18.2016[2, 1] <- 2
Oct.18.2016[3, 1] <- 3
Oct.18.2016[4, 1] <- 4

Sep.14.2017[1, 1] <- 1
Sep.14.2017[2, 1] <- 2
Sep.14.2017[3, 1] <- 3
Sep.14.2017[4, 1] <- 4

Sep.15.2016[1, 1] <- 1
Sep.15.2016[2, 1] <- 2
Sep.15.2016[3, 1] <- 3
Sep.15.2016[4, 1] <- 4

# Fill out Oct 18 2016 workout to be same pace for all "splits" (only took one split during the workout)
Oct.18.2016 <- fill(Oct.18.2016, Avg.Pace)

# Reindex the rows to correct numbering
rownames(Aug.25.2017) <- 1:nrow(Aug.25.2017)
rownames(Oct.17.2017) <- 1:nrow(Oct.17.2017)
rownames(Oct.18.2016) <- 1:nrow(Oct.18.2016)
rownames(Sep.14.2017) <- 1:nrow(Sep.14.2017)
rownames(Sep.15.2016) <- 1:nrow(Sep.15.2016)

# Join data sets together, remove unecessary ones after
first.join <- full_join(Aug.25.2017, Oct.17.2017, by = "Split")
second.join <- full_join(Oct.18.2016, Sep.14.2017, by = "Split")
first.second.join <- full_join(first.join, second.join, by = "Split")
all.workouts   <- full_join(first.second.join, Sep.15.2016, by = "Split")
rm(first.join, second.join, first.second.join)

# Rename columns to the date of the workout
names(all.workouts)[names(all.workouts) == "Avg.Pace.x.x"] <- "Aug 25 2017"
names(all.workouts)[names(all.workouts) == "Avg.Pace.y.x"] <- "Oct 17 2017"
names(all.workouts)[names(all.workouts) == "Avg.Pace.x.y"] <- "Oct 18 2016"
names(all.workouts)[names(all.workouts) == "Avg.Pace.y.y"] <- "Sep 14 2017"
names(all.workouts)[names(all.workouts) == "Avg.Pace"] <- "Sep 15 2016"

# Create new table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Aug 25 2017`, `Oct 17 2017`, `Oct 18 2016`, `Sep 14 2017`, `Sep 15 2016`, key = "Date", value = "Time") %>% arrange(Split)


# Plot the workouts
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()
