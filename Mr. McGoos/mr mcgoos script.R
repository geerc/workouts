# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
oct.24.2017 <- read.csv("~/GitHub/workouts/Mr. McGoos/Oct 24 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
oct.24.2017 <- mutate(oct.24.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
oct.24.2017 <- oct.24.2017[-c(1, 2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 26, 28, 30, 31, 32), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(oct.24.2017)[names(oct.24.2017) == "Moving.Time"] <- "Time"

#Renaming splits so as not go by 2s
oct.24.2017[1, 1] <- 1
oct.24.2017[2, 1] <- 2
oct.24.2017[3, 1] <- 3
oct.24.2017[4, 1] <- 4
oct.24.2017[5, 1] <- 5
oct.24.2017[6, 1] <- 6
oct.24.2017[7, 1] <- 7
oct.24.2017[8, 1] <- 8
oct.24.2017[9, 1] <- 9
oct.24.2017[10,1] <- 10
oct.24.2017[11,1] <- 11
oct.24.2017[12,1] <- 12
oct.24.2017[13,1] <- 13
oct.24.2017[14,1] <- 14

# Reindex the rows to correct numbering
rownames(oct.24.2017) <- 1:nrow(oct.24.2017)

# Join data sets together
# all.workouts <- full.join(oct.24.2017, , by = "Split")

# Rename the headers of each workout to the year from Time.x and Time.y
# names(all.workouts)[names(all.workouts) == "Time.x"] <- "Oct 24 2017"

# Makes new data table, optimized for plotting
# all.workouts.plot <- all.workouts %>% gather(`Oct 24 2017`, ``, key = "Date", value = "Time") %>% arrange(Split)

# Plot it (will change when more workouts are added)
ggplot(data = oct.24.2017, mapping = aes(x = Split, y = Time)) + 
  geom_point()