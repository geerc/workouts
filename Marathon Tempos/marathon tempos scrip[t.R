# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
Sep.22.2017 <- read.csv("~/GitHub/workouts/Marathon Tempos/Sep 22 2017.csv")
Sep.23.2016 <- read.csv("~/GitHub/workouts/Marathon Tempos/Sep 23 2016.csv")

# Delete rest splits and remove unnecessary columns
Sep.22.2017 <- Sep.22.2017[-c(1, 3, 4), ] %>% select(Split, Avg.Pace)
Sep.23.2016 <- Sep.23.2016[-c(1, 2, 8, 9, 10), ] %>% select(Split, Avg.Pace)
