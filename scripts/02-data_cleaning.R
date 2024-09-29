#### Preamble ####
# Purpose: Cleans and combines the raw housing and ward data to prepare the data for analysis
# Author: Tanmay Sachin Shinde
# Date: 26 September, 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# Pre-requisites: Libraries required - tidyverse

#### Workspace setup ####
library(tidyverse)

#### Clean data ####
raw_housing_data <- read_csv("data/raw_data/raw_housing_data.csv")
raw_ward_names_data <- read_csv("data/raw_data/raw_ward_data.csv")
raw_census_data <- read_csv("data/raw_data/raw_census_data.csv")
raw_ward_area_data <- read_csv("data/raw_data/raw_ward_areas.csv")

# Removing columns that are not required and filtering out irrelevant rows
cleaned_housing_data <- raw_housing_data %>% 
  rename(`ApprovedARH2020toPresent` = Affordable.Homes.Approved..2020...Present.,
         `ApprovedARH2017toPresent` = Total.ARH.Approved..2017...Present.) %>% 
  select(Ward, Status, -X_id, -ApprovedARH2020toPresent, ApprovedARH2017toPresent, 
         -geometry, -Project.ID, -Addresses, -Anchor.Address, 
         -Rent.Controlled.Market.Units.Approved, -RGI.Homes.Approved) %>%
  filter(Ward != 0) %>% arrange(Ward) %>%
  group_by(Ward, Status) %>% 
  summarize(ApprovedARH2017toPresent = sum(ApprovedARH2017toPresent))

# Removing the row where Ward = 0
cleaned_census_data <- raw_census_data %>% slice(-1)

# Transform housing data file to include ApprovedARH2017toPresent column in census_data
housing_data_for_census <- cleaned_housing_data %>% select(-Status) %>% 
  group_by(Ward) %>% 
  summarize(ApprovedARH2017toPresent = sum(ApprovedARH2017toPresent))

# adding missing ward 23 to match number of rows in both files
new_row <- data.frame(Ward = 23, ApprovedARH2017toPresent = 0)

housing_data_for_census <- bind_rows(housing_data_for_census, new_row) %>% arrange(Ward)

# add new column to census_data
cleaned_census_data$ApprovedARH2017toPresent <- housing_data_for_census$ApprovedARH2017toPresent

cleaned_ward_areas <- raw_ward_area_data %>%
  select(Ward, `Area (sq km)`) %>%
  slice(1:25)

# Check for null values
#sum(is.na(int_cleaned_data)) == 0


#### Save data ####
write_csv(cleaned_housing_data, "data/analysis_data/housing_analysis_data.csv")
write_csv(raw_ward_names_data, "data/analysis_data/ward_names.csv")
write_csv(cleaned_census_data, "data/analysis_data/ward_census_data.csv")
write_csv(cleaned_ward_areas, "data/analysis_data/ward_area_data.csv")
