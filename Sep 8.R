#installing tidyverse
library(tidyverse)

#load in our data
chocolate <- read.csv("data/raw/chocolate.csv")

glimpse(chocolate)

#select and filter
chocolate |>
  select(ref, company_manufacturer, company_location, rating, cocoa_percent)

#how would we filter company location for multiple countries?
chocolate |>
  filter(company_location %in% c("U.S.A.", "France", "Canada"))

# write code that only shows reviews that are greater than or equal to 3.5 AND
# only for 2021 AND the location is either U.S.A. OR Vietnam
chocolate |>
  filter(rating >= 3.5,
         review_date == 2021,
         company_location %in% c("U.S.A.", "Vietnam"))

# we can arrange, how would I show the 10 highest rated bars?
chocolate |>
  select(rating, country_of_bean_origin) |>
  arrange(desc(rating)) |>
  slice_head(n = 10)

#mutate, how would I just look at the mean cocoa_percent?
mean(chocolate$cocoa_percent)
glimpse(chocolate)

chocolate |>
  mutate(
    cocoa_num = as.numeric(cocoa_percent)
  ) |>
  select(cocoa_num)

chocolate |>
  select()

mean(chocolate$cocoa_num)


#grouped summaries and arranging
chocolate |>
  group_by(company_location) |>
  summarise(
    n = n(),
    avg_rating = mean(rating, na.rm = TRUE),
    avg_cocoa = mean(cocoa_num, na.rm = TRUE)
  ) |>
  slice_head(n=10)

#missingness
sum(is.na(chocolate$review_date))

#histogram
chocolate |>
  ggplot(aes(x=rating)) +
  geom_histogram()

#barplot
chocolate |>
  ggplot(aes(rating)) +
  geom_bar()

#boxplot
chocolate |> 
  filter()
