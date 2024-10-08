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
library(sf)


# get package
package <- show_package("upcoming-and-recently-completed-affordable-housing-units")

# get all resources for this package
resources <- list_package_resources("upcoming-and-recently-completed-affordable-housing-units")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

#### Download data ####
data <- filter(datastore_resources, row_number()==4) %>% get_resource()

#### Downloading Ward Data ####

# get package
ward_package <- show_package("6678e1a6-d25f-4dff-b2b7-aa8f042bc2eb")

ward_resources <- list_package_resources("ward-profiles-25-ward-model")

ward_name_data <- filter(ward_resources, row_number()==3) %>% get_resource()

ward_data <- filter(ward_resources, row_number()==2) %>% get_resource()


#get wards geojson

# get package
geowards_package <- show_package("5e7a8234-f805-43ac-820f-03d7c360b588")

# get all resources for this package
geowards_resources <- list_package_resources("5e7a8234-f805-43ac-820f-03d7c360b588")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
geowards_datastore_resources <- filter(geowards_resources, tolower(format) %in% c('geojson'))

# load the first datastore resource as a sample
geowards_data <- filter(geowards_datastore_resources, row_number()==1) %>% get_resource()

st_write(geowards_data, "data/analysis_data/wards.geojson", driver = "GeoJSON")

#### Save data ####
write_csv(data, "data/raw_data/raw_data.csv") 
write_csv(ward_name_data, "data/raw_data/raw_ward_data.csv") 
