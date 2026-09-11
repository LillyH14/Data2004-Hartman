#installing tidyverse 
library(tidyverse)

#load in our data
data <- read_csv("data/raw/co-est2025-alldata.csv",
                 locale = locale(encoding = "Latin1"),
                 col_types = cols(.default = col_character())
                 )

glimpse(data)
names(data)

#what can we determine from this? what can we not?
# state/county, population changes/estimate, annual resident population, census
# beauro, match documentation for the data that you have. Not much else. 

#find the documentation and record 
# who produced this? the USA Census 
# what does the file contain & when? population data from 2020-2025

#build a diagnostic view
#find the documentation and look at the code above. what variables determine what 
#one row repersents? 
data_trimmed <- data |>
  select(SUMLEV,REGION,DIVISION,STATE,COUNTY,STNAME,CTYNAME,
         POPESTIMATE2024,POPESTIMATE2025,NPOPCHG2025)

#looking at your table
#does every row appear to represnt the same kind of geographic observation? 
#no, state-county
#which rows look differntly?
# row 

# SUMLEV colum 
data_trimmed|>
  slice_head(n=10)

#declare the grain 
# one row represents a geographic location, either a county or a state, aka a 
# mixed state-county grain. 

data_trimmed_numeric <- data_trimmed |>
  mutate(
    pop2025 = as.numeric(POPESTIMATE2025),
    pop2024 = as.numeric(POPESTIMATE2024),
    popchg2025 = as.numeric(NPOPCHG2025)
  )

data_trimmed_numeric |>
  filter(STNAME == "Kentucky") |>
  slice_head(n=10)

data_trimmed_numeric |> 
  filter(SUMLEV == "040") |>
  summarise(
    total_pop_2025 = sum(pop2025)
  )

# above anwsers question 1: US pop 2025


# now answering question 2: ky county pop change from 2024 to 2025








