# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
jan.24.2017 <- read.csv("~/workouts/Track/kickdown 800s/jan 24 2017.csv")
jan.23.2018 <- read.csv("~/workouts/Track/kickdown 800s/jan 23 2018.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
jan.24.2017 <- mutate(jan.24.2017, Moving.Time = Time)
jan.23.2018 <- mutate(jan.23.2018, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
jan.24.2017 <- jan.24.2017[-c(3, 6, 9, 12, 15, 16), ] %>% 
  select(Split, Moving.Time)
jan.23.2018 <- jan.23.2018[-c(3, 6, 9, 12, 15, 16), ] %>% 
  select(Split, Moving.Time)

# Rename Moving.Time to Time
names(jan.24.2017)[names(jan.24.2017) == "Moving.Time"] <- "Time"
names(jan.23.2018)[names(jan.23.2018) == "Moving.Time"] <- "Time"

# Renaming splits so as not to go by 2s
jan.24.2017[1, 1] <- 1
jan.24.2017[2, 1] <- 2
jan.24.2017[3, 1] <- 3
jan.24.2017[4, 1] <- 4
jan.24.2017[5, 1] <- 5
jan.24.2017[6, 1] <- 6
jan.24.2017[7, 1] <- 7
jan.24.2017[8, 1] <- 8
jan.24.2017[9, 1] <- 9
jan.24.2017[10, 1] <- 10

jan.23.2018[1, 1] <- 1
jan.23.2018[2, 1] <- 2
jan.23.2018[3, 1] <- 3
jan.23.2018[4, 1] <- 4
jan.23.2018[5, 1] <- 5
jan.23.2018[6, 1] <- 6
jan.23.2018[7, 1] <- 7
jan.23.2018[8, 1] <- 8
jan.23.2018[9, 1] <- 9
jan.23.2018[10, 1] <- 10

# Reindex rows to correct numbering
rownames(jan.24.2017) <- 1:nrow(jan.24.2017)
rownames(jan.23.2018) <- 1:nrow(jan.23.2018)

# Join data sets together
all.workouts <- full_join(jan.24.2017, jan.23.2018, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Jan 24 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Jan 23 2018"


# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Jan 24 2017`,
                                             `Jan 23 2018`,
                                             key = "Date",
                                             value = "Time") %>%
  arrange(Split)

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()
