# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
aug.11.2017 <- read.csv("~/workouts/Cruise Miles/Aug 11 2017.csv")
aug.24.2016 <- read.csv("~/workouts/Cruise Miles/Aug 24 2016.csv")
aug.29.2017 <- read.csv("~/workouts/Cruise Miles/Aug 29 2017.csv")
oct.25.2016 <- read.csv("~/workouts/Cruise Miles/Oct 25 2016.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
aug.11.2017 <- mutate(aug.11.2017, Moving.Time = Time)
aug.24.2016 <- mutate(aug.24.2016, Moving.Time = Time)
aug.29.2017 <- mutate(aug.29.2017, Moving.Time = Time)
oct.25.2016 <- mutate(oct.25.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
aug.11.2017 <- aug.11.2017[-c(2, 4), ] %>% select(Split, Moving.Time)
aug.24.2016 <- aug.24.2016[-c(2, 4, 6, 8, 9), ] %>% select(Split, Moving.Time)
aug.29.2017 <- aug.29.2017[-c(2, 4, 6, 8, 9), ] %>% select(Split, Moving.Time)
oct.25.2016 <- oct.25.2016[-c(2, 4, 6, 8, 9), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(aug.11.2017)[names(aug.11.2017) == "Moving.Time"] <- "Time"
names(aug.24.2016)[names(aug.24.2016) == "Moving.Time"] <- "Time"
names(aug.29.2017)[names(aug.29.2017) == "Moving.Time"] <- "Time"
names(oct.25.2016)[names(oct.25.2016) == "Moving.Time"] <- "Time"

# Convert split to int from char
aug.11.2017$Split <- as.double(aug.11.2017$Split)
aug.24.2016$Split <- as.double(aug.24.2016$Split)
aug.29.2017$Split <- as.double(aug.29.2017$Split)
oct.25.2016$Split <- as.double(oct.25.2016$Split)

#Renaming splits so as not go by 2s
aug.11.2017[2,1] <- 2
aug.11.2017[2,2] <- NA

aug.24.2016[2,1] <- 2
aug.24.2016[3,1] <- 3
aug.24.2016[4,1] <- 4

aug.29.2017[2,1] <- 2
aug.29.2017[3,1] <- 3
aug.29.2017[4,1] <- 4

oct.25.2016[2,1] <- 2
oct.25.2016[3,1] <- 3
oct.25.2016[4,1] <- 4

# Reindex the rows to correct numbering
rownames(aug.11.2017) <- 1:nrow(aug.11.2017)
rownames(aug.24.2016) <- 1:nrow(aug.24.2016)
rownames(aug.29.2017) <- 1:nrow(aug.29.2017)
rownames(oct.25.2016) <- 1:nrow(oct.25.2016)


# Join wokrouts together
all.workouts <- full_join(aug.11.2017, aug.24.2016, by = "Split") %>%
  full_join(aug.29.2017, by = "Split") %>%
  full_join(oct.25.2016, by = "Split")

# Rename the headers of each workout to the year from Time.x and Time.y
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Aug 11 2017"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Aug 24 2016"
names(all.workouts)[names(all.workouts) == "Time.x.x"] <- "Aug 29 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y"] <- "Oct 25 2016"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Oct 25 2016`, `Aug 11 2017`, `Aug 29 2017`, `Aug 24 2016`, key = "Date", value = "Time") %>% arrange(Split)

# Convert split column from char to double, and sort
all.workouts.plot$Split <- as.double(all.workouts.plot$Split)
all.workouts.plot <- arrange(all.workouts.plot, Split)

#Plot it
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()
