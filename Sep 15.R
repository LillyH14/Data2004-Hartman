#installing tidyverse 
library(tidyverse)
library(readxl)

#load in our data
fishing <- read_excel("data/raw/commercial.xlsx", sheet = "Erie")
glimpse(fishing)

#(grain) what does one row repesent? 
# guesses; a geographical location, year-lake-species, something about fish 
# caught in the given region
# answer; a region-year-weight of fish caught, rounded lbs

# how would we look at our grain over time by region? 
# coloum is a variable, row is a observation, cell is a value
fishing |> 
  ggplot(aes(x= Year, y= `Grand Total` )) +
  geom_line()

# lets predict something
nrow(fishing)

# we're about to move 7 colums into one. How many rows should we have?
# nrow had 2562, predict for 11, pivot rows, 2562*11=17934

fishing_long <- fishing |>
  pivot_longer(
    names_to = "region",
    values_to = "values",
    cols = !c(Year, Lake, Species, Comments)
  )
# cols meaning, every colum except the ones listed

nrow(fishing_long)
nrow(fishing_long)/nrow(fishing)

# which one of these four pivots would you use? why not some of the others?
fishing_long |>
  distinct(region)

# are all seven of these the same kind of thing? what is the grain?
# no; some are US states, then the countries of Canada and US

# let's see what these 7 regions are. let's look at Lake Whitefish in 1885 then
# just look at the region and values.

fishing_long |>
  filter(Year == 1885, Species == "American Eel") |>
  select(region, values)

# so how many levels are stacked into this one column now? what happens if we
# just add the catch?

fishing_long |>
  filter(!region %in% c("U.S. Total", "Grand Total")) |>
  summarise(total = sum(values, na.rm = TRUE))

fishing_long |>
  filter(!region %in% c("U.S. Total", "Grand Total"),
         !is.na(values)) |>
  mutate(species = fct_lump_n(Species, 6)) |> 
  ggplot(aes(x = Year, y = values, color = species)) +
  geom_line()
  
# let's take it back the other way. what if we widened it by region?
fishing_long |>
  select(Year, Species, region, values) |>
  pivot_wider(names_from = region, values_from = values)




# now let's break. choose a differnet sheet in the link.
ontario <- read_excel("data/raw/ontario.xlsx")
glimpse(ontario)

# what is the grain?
# fish caught in the lake Ontario, the year and species of catch

# what is the total catch for the lake?
nrow(ontario)
# gave the anwser 2506
ontario |> 
  summarise(total = sum(`Grand Totals` , na.rm = TRUE))
# gave 381489

# what distinct region are you left with? 
