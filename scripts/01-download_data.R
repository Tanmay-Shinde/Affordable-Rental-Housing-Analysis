#### Preamble ####
# Purpose: Downloads and saves the Affordable Housing Pipeline dataset using the OpenDataToronto API 
# Author: Tanmay Sachin Shinde
# Date: 25 September, 2024
# Contact: tanmay.shinde@mail.utoronto.ca
# Pre-requisites: Libraries required - opendatatoronto, readr, dplyr


#### Workspace setup ####
library(opendatatoronto)
library(readr)
library(dplyr)


# get package
package <- show_package("upcoming-and-recently-completed-affordable-housing-units")

# get all resources for this package
resources <- list_package_resources("upcoming-and-recently-completed-affordable-housing-units")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

#### Download data ####
data <- filter(datastore_resources, row_number()==4) %>% get_resource()


#### Save data ####
write_csv(data, "data/raw_data/raw_data.csv") 
