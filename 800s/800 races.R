# Importing Libraries
library(tidyverse)
library(dplyr)

# Create shell of table
races.800s <- tibble(
  Meet = c(Spire, MountUnion1, Tiffin, Kenyon, Gator), 
  Time = c(00:02:10.88, 00:02:13.43, 00:02:06.87, 00:02:07.53, 00:02:04.76)
)