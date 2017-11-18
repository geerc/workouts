# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Sep.5.2017 <- read.csv("~/workouts/Broken Tempos/Sep 5 2017.csv")

# Delete rest splits and remove unnecessary columns
Sep.5.2017 <- Sep.5.2017[-c(1, 2, 3, 6, 8, 10, 12, 14, 17, 19, 21, 23, 25, 26, 27, 28), ] %>% select(Split, Avg.Pace)

# Renames splits to go in order

Sep.5.2017[1, 1] <- 1
Sep.5.2017[2, 1] <- 2
Sep.5.2017[3, 1] <- 3
Sep.5.2017[4, 1] <- 4
Sep.5.2017[5, 1] <- 5
Sep.5.2017[6, 1] <- 6
Sep.5.2017[7, 1] <- 7
Sep.5.2017[8, 1] <- 8
Sep.5.2017[9, 1] <- 9
Sep.5.2017[10,1] <- 10
Sep.5.2017[11,1] <- 11
Sep.5.2017[12,1] <- 12

# Reindex the rows to correct numbering
rownames(Sep.5.2017) <- 1:nrow(Sep.5.2017)

# Join all workouts together
# all.workouts <- full.join(Sep.5.2017, , by = "Split")

# New table for plotting
# all.workouts.plot <- Sep.5.2017 %>% gather(`Sep 5 2017`, key = "Date", value = "Time") %>% arrange(Split)

# Convert Split column from character to double
# all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
# all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot it
ggplot(data = Sep.5.2017, mapping = aes(x = Split, y = Avg.Pace)) + 
  geom_point()

