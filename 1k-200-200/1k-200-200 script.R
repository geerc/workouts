# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
aug.30.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Aug 30 2016.csv")
sep.12.2017 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 12 2017.csv")
sep.13.2016 <- read.csv("~/GitHub/workouts/1k-200-200/Sep 13 2017.csv")

# Copy Time data to Moving.Time, so we can delete rest splits
aug.30.2016 <- mutate(aug.30.2017, Moving.Time = Time)
sep.12.2017 <- mutate(sep.12.2017, Moving.Time = Time)
sep.13.2016 <- mutate(sep.13.2016, Moving.Time = Time)

# Delete rest splits and remove unnecessary columns
aug.30.2016 <- aug.30.2017[-c()]
