# Lab 2

# We'll start by working with the actual crashes and persons fully 
library(tidyverse)

crashes <- read_csv("data/raw/crashes.csv")
persons <- read_csv("data/raw/person.csv")

# 1: Make a table of person records for female pedestrians 
female_pedestrians <- persons |>
  filter(PERSON_TYPE == "Pedestrian",
         PERSON_SEX == "F")

## what does one row represent? 
# each row represnets a female pedestrian involved in a crash

# 2: Keep only the crashes that involved at least one female pedestrian. 
# Keep COLLISION_ID, BOROUGH, and the five vehicle type columns. 
# how can we select every variable that starts with "VEHICLE TYPE CODE"?
female_ped_crashes <- crashes |>
  semi_join(female_pedestrians, by = "COLLISION_ID") |>
  select(COLLISION_ID, BOROUGH, starts_with("VEHICLE TYPE CODE"))

# does one row still represent one crash? check it. 
nrow(female_ped_crashes)
n_distinct(female_ped_crashes$COLLISION_ID)
# both gave 4940 so yes

# why a filtering join instead of a mutating join? 
# only want to keep crashes that have a female pedestrian 

# 3: Right now the vehicle types are columns. We want one row per vehicle. 
# before writing your code, how many rows should we have? 
# 4940 crashes * 5 vehicle colums = 24700 rows
vehicle_rec <- female_ped_crashes |>
  pivot_longer(
    cols = starts_with("VEHICLE TYPE CODE"),
    names_to = "vehicle_number",
    values_to = "vehicle_type"
  )
nrow(vehicle_rec)
# yay!!! got the same number :) 

# 4: how many missing values are in the new dataframe? 
vehicle_rec |>
  count(is.na(vehicle_type))
# gave TRUE to 20203 values 

# why do we think that slots 3, 4, and 5 have so many more missing values? 
# whatever those vehicles aren't really involved in crashes 

# does every crash have a first vehicle recorded? 
female_ped_crashes |>
  count(is.na(`VEHICLE TYPE CODE 1`))
# no, gave TRUE to 601 values 

# are we safe to drop missing values?
# yes, bc the na values don't give us the type of vehicle to count

# 5: what kinds of vehicles are involved in crashes with a female pedestrian? 
vehicle_rec |> 
  count(vehicle_type, sort = TRUE) |> 
  print(n = 40)
# most common are sedan and station wagon
