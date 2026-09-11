#Library
install.packages("tidyverse")
library(tidyverse)
#what is our wd? what is a wd in genral?
getwd()
#download the files from canvas. we need to moce them to our wd.
test <- read_csv("data/raw/API_SP.POP.TOTL_DS2_en_csv_v2_285942.csv",
                 skip=4)
glimpse(test)

test |> 
  select(-...71)
clean_test<- test |> 
  select(-...71)
glimpse(clean_test)
