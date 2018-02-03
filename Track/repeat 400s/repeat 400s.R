# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
jan.29.2017 <- read.csv("~/workouts/Track/repeat 400s/jan 29 2017.csv")
jan.30.2018 <- read.csv("~/workouts/Track/repeat 400s/jan 30 2018.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
jan.29.2017 <- mutate(jan.29.2017, Moving.Time = Time)
jan.30.2018 <- mutate(jan.30.2018, Moving.Time= Time)

# Delete rest splits and remove unnecessary columns
jan.29.2017 <- jan.29.2017[-c(2, 4, 6, 8, 10, 12, 13), ] %>% select(Split, Moving.Time)
jan.30.2018 <- jan.30.2018[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 25),  ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(jan.29.2017)[names(jan.29.2017) == "Moving.Time"] <- "Time"
names(jan.30.2018)[names(jan.30.2018) == "Moving.Time"] <- "Time"

# Rename splits to go count up from 1
jan.29.2017[1, 1] <- 1
jan.29.2017[2, 1] <- 2
jan.29.2017[3, 1] <- 3
jan.29.2017[4, 1] <- 4
jan.29.2017[5, 1] <- 5
jan.29.2017[6, 1] <- 6

jan.30.2018[1, 1] <- 1
jan.30.2018[2, 1] <- 2
jan.30.2018[3, 1] <- 3
jan.30.2018[4, 1] <- 4
jan.30.2018[5, 1] <- 5
jan.30.2018[6, 1] <- 6
jan.30.2018[7, 1] <- 7
jan.30.2018[8, 1] <- 8
jan.30.2018[9, 1] <- 9
jan.30.2018[10, 1] <- 10
jan.30.2018[11, 1] <- 11
jan.30.2018[12, 1] <- 12

# Reindex rows to correct numbering
rownames(jan.29.2017) <- 1:nrow(jan.29.2017)
rownames(jan.30.2018) <- 1:nrow(jan.30.2018)

# Join sets together
all.workouts <- full_join(jan.29.2017, jan.30.2018, by = "Split")
# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Jan 29 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Jan 30 2018"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Jan 29 2017`,
                                             `Jan 30 2018`,
                                             key = "Date", value = "Time") %>% 
  arrange(Split)

# Convert splits to doubles
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)

# Sort by split
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date, shape = Date)) +
  geom_path() +
  geom_point()
