#### Preamble ####
# Purpose: Simulates sample data required for the study as shown in other/sketches/dataset.png
# Author: Tanmay Sachin Shinde
# Date: 26 September, 2024
# Contact: tanmay.shinde@mail.utoronto.ca


#### Workspace setup ####
library(tidyverse)
set.seed(304)

#### Simulate data ####
num_observations <- 75
status_categories <- c("Planning", "Under Construction", "Occupied")
status_col <- rep(status_categories, times=25)

wards <- rep(1:25, times=3)
wards_col <- sort(wards)

arh_col <- sample(1:3000, 75, replace=TRUE)

simulated_data <- data.frame(
  Ward = wards_col,
  Status = status_col,
  ARHApproved20117toPresent = arh_col
)

head(simulated_data)
