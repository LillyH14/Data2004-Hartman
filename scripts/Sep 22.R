# pacakges
library(tidyverse)

# let's start with the same persons_core and crashes_core 
crashes <- read_csv("data/raw/crashes.csv")
persons <- read_csv("data/raw/person.csv")

crashes_core <- crashes |> 
  select(
    COLLISION_ID,
    `CRASH DATE`,
    BOROUGH,
    `NUMBER OF PERSONS INJURED`,
    `NUMBER OF PERSONS KILLED`
  )

persons_core <- persons |> 
  select(
    UNIQUE_ID,
    COLLISION_ID,
    PERSON_TYPE,
    PERSON_INJURY,
    PERSON_AGE,
    PERSON_SEX
  )

glimpse(crashes_core)
glimpse(persons_core)


# let's do a brief review of our mutating joins :) 

## what are the primary keys? what about the foreign key? 
# primary keys, identify rows in data set
# foregin keys, link datasets together, will be primary key of at least one
# other dataset

## what are our mutating joins? what's the difference? 
# left_join (keeps all rows in left dataset, matches unmatched keys, unmatched 
# will have NA's for colums from right hand dataframe), right_join, inner_join, 
# full_join (keeps rows only where keys match in left and right database)



## let's check out the homework briefly. 

# Which crashes involved at least one bicyclist? I want one row per crash. 
# we'll start by making a table of just the bicyclist person records. how many are there?
bicyclists <- persons_core |>
  filter(PERSON_TYPE == "Bicyclists")

nrow(bicyclists)
n_distinct(bicyclists$COLLISION_ID)

crashes_bike <- crashes_core |>
  left_join(persons_core, join_by(COLLISION_ID))

crashes_bike <- crashes_bike |>
  filter(PERSON_TYPE == "Bicyclist")

glimpse(crashes_bike)


# does that number answer our question? why not? 
# not necessarliy, tandum bike posibility

# if it doesn't, which join should we reach for?

# use nrow() on the join and n_distinct() on that join's collision ID. Why are they different? 

# we can answer this by thinking about the grain.
# we're joining persons to the crashes grain, so what does one row represent? 

# is it every crash involving a bicyclist? let's check out the first 10 rows.  
crashes_bike |>
  slice_head(n=10)


# our mutating join adds columns so it has changed our grain, but we don't want it to right now. 

# so we'll need to use *filtering* joins
# we got exposed to one filtering join already: anti_join(). 
# which filtering join that will keep matches instead of non-matches?
bike_crashes <- crashes_core |>
  semi_join(bicyclists, join_by(COLLISION_ID))
nrow(bike_crashes)
n_distinct(bike_crashes$COLLISION_ID)

glimpse(bike_crashes)


# this doesn't add more columns, so we're not working with crash-bicyclists combination

# now do anti_join for crashes that do not involve a bicyclist. 
no_bike_crashes <- crashes_core |>
  anti_join(bicyclists, join_by(COLLISION_ID))
nrow(no_bike_crashes)
n_distinct(no_bike_crashes$COLLISION_ID)

glimpse(no_bike_crashes)

# what should the nrow() of each of your filtering joins dataframes be?
nrow(bike_crashes) + nrow(no_bike_crashes) == nrow(crashes_core)



# now it's y'all's turn: identify crashes that involve at least one pedestrian, 
# one row per crash. 
pedestrian <- persons_core |>
  filter(PERSON_TYPE == "Pedestrian")

nrow(pedestrian)
n_distinct(pedestrian$COLLISION_ID)

crashes_pedestrian <- crashes_core |>
  semi_join(pedestrian, join_by(COLLISION_ID))

glimpse(crashes_pedestrian)


## after that, narrow it down. crashes where at least one pedestrian was recorded as female. 
pedestrian_f <- pedestrian |>
  filter(PERSON_SEX == "Female")

pedestrian_crashes<- crashes_core |>
  semi_join(pedestrian, join_by(COLLISION_ID))

nrow(pedestrian_crashes)
n_distinct(pedestrian_crashes$COLLISION_ID)

glimpse(pedestrian_crashes)

# back together
# mutating adds colums, filtering changes rows by condition 
## where did you put the PERSON_SEX condition? why?