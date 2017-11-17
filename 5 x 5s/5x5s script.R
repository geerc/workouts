# Importing Libraries
library(tidyverse)
library(dplyr)

# Load data sets
Oct.4.2016 <- read.csv("~/workouts/5 x 5s/Oct 4 2016.csv") # My labtop

# Delete rest splits and remove unnecessary columns
Oct.4.2016 <- Oct.4.2016[-c(2, 4, 6, 8, 10, 11), ] %>% select(Split, Distance)

#Renaming splits so as not go by 2s
Oct.4.2016[2, 1] <- 2
Oct.4.2016[3, 1] <- 3
Oct.4.2016[4, 1] <- 4
Oct.4.2016[5, 1] <- 5

# Reindex the rows to correct numbering
rownames(Oct.4.2016) <- 1:nrow(Oct.4.2016)

# Join data sets together
# all.workouts <- full_join(Oct.4.2016, , by = "Split")

# Rename column headers to date of workout
# names(all.workouts)[names(all.workouts) == "Time.x"] <- "Oct 4 2016"

# Make new table, optimized for plotting
# all.workouts.plot <- all.workouts.plot <- all.workouts %>% gather(`Oct 4 2016`, ``, , key = "Date", value = "Distance") %>% arrange(Split)

# Convert split column from character to doubles, and sort by split
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Adding date so that we can group the observations together for plotting
Oct.4.2016$Date <- "Oct 4 2016"

# Plot the data
ggplot(data = Oct.4.2016, mapping = aes(x = Split, y = Distance, group = Date, color = Date)) +
    geom_path() +
    geom_point()
    ylim(.75, 1)
