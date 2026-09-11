#Set Up for Review
library(tidyverse)
library(palmerpenguins)
penguins <- penguins
glimpse(penguins) 
#Starting questions...
# 1) 344 rows, 8 columns  2) different ways to distinguish penguins

#Setting up the select command asked for in review.
penguins_small <- penguins %>%
  select(species, island, sex, body_mass_g, flipper_length_mm)

#Completing the filter task from the review. 
#first filtering for Adelie penguins 
adelie_penguins <- filter(penguins, species == "Adelie")
glimpse(adelie_penguins)
#next filtering for body mass greater than 5000 grams
large_penguins <- filter(penguins, body_mass_g > 5000)
glimpse(large_penguins)
