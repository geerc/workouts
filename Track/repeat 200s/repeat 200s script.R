# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
dec.9.2016 <- read.csv("~/GitHub/workouts/track/repeat 200s/dec 9 2016.csv")
dec.23.2016 <- read.csv("~/GitHub/workouts/track/repeat 200s/dec 23 2016.csv")
jan.5.2017 <- read.csv("~/GitHub/workouts/track/repeat 200s/jan 5 2017.csv")
mar.3.2017 <- read.csv("~/GitHub/workouts/track/repeat 200s/mar 3 2017.csv")
mar.21.2017 <- read.csv("~/GitHub/workouts/track/repeat 200s/mar 21 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
dec.9.2016 <- mutate(dec.9.2016, Moving.Time = Time)
dec.23.2016 <- mutate(dec.23.2016, Moving.Time = Time)
jan.5.2017 <- mutate(jan.5.2017, Moving.Time = Time)
mar.3.2017 <- mutate(mar.3.2017, Moving.Time = Time)
mar.21.2017 <- mutate(mar.21.2017, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
dec.9.2016 <- dec.9.2016[-c(1, 3, 5, 7, 9, 11, 13, 15, 17, 18), ] %>% select(Split, Moving.Time)
dec.23.2016 <- dec.23.2016[-c(2, 4, 6, 8, 10, 11), ] %>% select(Split, Moving.Time)
jan.5.2017 <- jan.5.2017[-c(2, 4, 6, 7, 9, 11, 13, 15, 17, 18), ] %>% select(Split, Moving.Time)
mar.21.2017 <- mar.21.2017[-c(2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22, 24, 25), ] %>% select(Split, Moving.Time)
mar.3.2017 <- mar.3.2017[-c(2, 4, 6, 8, 10, 12, 13, 15, 17, 19, 21, 23, 25, 26), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(dec.9.2016)[names(dec.9.2016) == "Moving.Time"] <- "Time"
names(dec.23.2016)[names(dec.23.2016) == "Moving.Time"] <- "Time"
names(jan.5.2017)[names(jan.5.2017) == "Moving.Time"] <- "Time"
names(mar.21.2017)[names(mar.21.2017) == "Moving.Time"] <- "Time"
names(mar.3.2017)[names(mar.3.2017) == "Moving.Time"] <- "Time"

# Convert split to int from char
dec.9.2016$Split <- as.double(dec.9.2016$Split)
dec.23.2016$Split <- as.double(dec.23.2016$Split)
jan.5.2017$Split <- as.double(jan.5.2017$Split)
mar.21.2017$Split <- as.double(mar.21.2017$Split)
mar.3.2017$Split <- as.double(mar.3.2017$Split)

# Put splits in order
dec.9.2016[1, 1] <- 1
dec.9.2016[2, 1] <- 2
dec.9.2016[3, 1] <- 3
dec.9.2016[4, 1] <- 4
dec.9.2016[5, 1] <- 5
dec.9.2016[6, 1] <- 6
dec.9.2016[7, 1] <- 7
dec.9.2016[8, 1] <- 8

dec.23.2016[1, 1] <- 1
dec.23.2016[2, 1] <- 2
dec.23.2016[3, 1] <- 3
dec.23.2016[4, 1] <- 4
dec.23.2016[5, 1] <- 5

jan.5.2017[1, 1] <- 1
jan.5.2017[2, 1] <- 2
jan.5.2017[3, 1] <- 3
jan.5.2017[4, 1] <- 4
jan.5.2017[5, 1] <- 5
jan.5.2017[6, 1] <- 6
jan.5.2017[7, 1] <- 7
jan.5.2017[8, 1] <- 8

mar.21.2017[1, 1] <- 1
mar.21.2017[2, 1] <- 2
mar.21.2017[3, 1] <- 3
mar.21.2017[4, 1] <- 4
mar.21.2017[5, 1] <- 5
mar.21.2017[6, 1] <- 6
mar.21.2017[7, 1] <- 7
mar.21.2017[8, 1] <- 8
mar.21.2017[9, 1] <- 9
mar.21.2017[10, 1] <- 10
mar.21.2017[11, 1] <- 11
mar.21.2017[12, 1] <- 12

mar.3.2017[1, 1] <- 1
mar.3.2017[2, 1] <- 2
mar.3.2017[3, 1] <- 3
mar.3.2017[4, 1] <- 4
mar.3.2017[5, 1] <- 5
mar.3.2017[6, 1] <- 6
mar.3.2017[7, 1] <- 7
mar.3.2017[8, 1] <- 8
mar.3.2017[9, 1] <- 9
mar.3.2017[10, 1] <- 10
mar.3.2017[11, 1] <- 11
mar.3.2017[12, 1] <- 12

# Reindex rows to correct numbering
rownames(dec.9.2016) <- 1:nrow(dec.9.2016)
rownames(dec.23.2016) <- 1:nrow(dec.23.2016)
rownames(jan.5.2017) <- 1:nrow(jan.5.2017)
rownames(mar.3.2017) <- 1:nrow(mar.3.2017)
rownames(mar.21.2017) <- 1:nrow(mar.21.2017)

# Join data sets together
all.workouts <- full_join(dec.9.2016, dec.23.2016, by = "Split") %>%
  full_join(jan.5.2017, by = "Split") %>%
  full_join(mar.3.2017, by = "Split") %>%
  full_join(mar.21.2017, by = "Split")

# Rename column headers to date of workout
names(all.workouts)[names(all.workouts) == "Time.x"] <- "Dec 9 2016"
names(all.workouts)[names(all.workouts) == "Time.y"] <- "Dec 23 2016"
names(all.workouts)[names(all.workouts) == "Time.x.x"] <- "Jan 5 2017"
names(all.workouts)[names(all.workouts) == "Time.y.y"] <- "Mar 3 2017"
names(all.workouts)[names(all.workouts) == "Time"] <- "Mar 21 2017"

# Make new data table optimized for plotting
all.workouts.plot <- all.workouts %>% gather(`Dec 9 2016`, `Dec 23 2016`, `Jan 5 2017`, `Mar 3 2017`, `Mar 21 2017`, key = "Date", value = "Time") %>% 
  arrange(Split)

# Plot
ggplot(data = all.workouts.plot, mapping = aes(x = Split, y = Time, group = Date, color = Date)) +
  geom_path() +
  geom_point()