# Importing Libraries
library(tidyverse)
library(dplyr)

# Import data sets
spire.2016<- read.csv("~/GitHub/workouts/800s/spire 2016.csv")
mount.union.2016 <- read.csv("~/GitHub/workouts/800s/Mount Union 2016 (1).csv")
tiffin.2016 <- read.csv("~/GitHub/workouts/800s/tiffin 2016.csv")

# Create shell of table
races.800s <- tibble(
  Meet = c(Spire, MountUnion1, Tiffin, Kenyon, Gator), 
  Time = c(00:02:10.88, 00:02:13.43, 00:02:06.87, 00:02:07.53, 00:02:04.76)
)