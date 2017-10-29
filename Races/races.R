# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets for workouts
oberlin.2017 <- read.csv("~/GitHub/workouts/races/oberlin 2017.csv")
paul.short.2017 <- read.csv("~/GitHub/workouts/races/paul short 2017.csv")
allegheny.classic.2017 <- read.csv("~/GitHub/workouts/races/allegheny classic 2017.csv")
rowan.2016 <- read.csv("~/GitHub/workouts/races/rowan 2016.csv")
paul.short.2016 <- read.csv("~/GitHub/workouts/races/paul short 2016.csv")
st.vincent.2016 <- read.csv("~/GitHub/workouts/races/st vincent 2016.csv")
conferences.2017 <- read.csv("~/GitHub/workouts/races/conferences 2017.csv")

# Copy Time data to Moving.Time so that unneeded splits can be deleted
oberlin.2017 <- mutate(oberlin.2017, Moving.Time = Time)
paul.short.2017 <- mutate(paul.short.2017, Moving.Time = Time)
allegheny.classic.2017 <- mutate(allegheny.classic.2017, Moving.Time = Time)
rowan.2016 <- mutate(rowan.2016, Moving.Time = Time)
paul.short.2016 <- mutate(paul.short.2016, Moving.Time = Time)
st.vincent.2016 <- mutate(st.vincent.2016, Moving.Time = Time)
conferences.2017 <- mutate(conferences.2017, Moving.Time = Time)

# Delete all splits, leaving just the final time
oberlin.2017 <- oberlin.2017[-c(1), ] %>% select(Split, Moving.Time)
paul.short.2017 <- paul.short.2017[-c(1, 2, 3, 4, 5), ] %>% select(Split, Moving.Time)
allegheny.classic.2017 <- allegheny.classic.2017[-c(1, 2, 3, 4), ] %>% select(Split, Moving.Time)
rowan.2016 <- rowan.2016[-c(1), ] %>% select(Split, Moving.Time)
paul.short.2016 <- paul.short.2016[-c(1), ] %>% select(Split, Moving.Time)
st.vincent.2016 <- st.vincent.2016[-c(1), ] %>% select(Split, Moving.Time)
conferences.2017 <- conferences.2017[-c(1), ] %>% select(Split, Moving.Time)

# Rename Moving.Time to Time
names(oberlin.2017)[names(oberlin.2017) == "Moving.Time"] <- "Time"
names(paul.short.2017)[names(paul.short.2017) == "Moving.Time"] <- "Time"
names(allegheny.classic.2017)[names(allegheny.classic.2017) == "Moving.Time"] <- "Time"
names(rowan.2016)[names(rowan.2016) == "Moving.Time"] <- "Time"
names(paul.short.2016)[names(paul.short.2016) == "Moving.Time"] <- "Time"
names(st.vincent.2016)[names(st.vincent.2016) == "Moving.Time"] <- "Time"
names(conferences.2017)[names(conferences.2017) == "Moving.Time"] <- "Time"
