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

#Creating a new variable task from the review.
penguins_kg <- penguins %>%
  mutate(body_mass_kg = body_mass_g / 1000)
#viewing the new column just made
head(penguins_kg)

#Summaries 
# I cannot even begin to remember how to do this. 

#More Independent Review
# Question A
female_greatest_mass <- penguins %>%
  filter(sex == "female") %>%
  
# I know there should be more to the command above, but I literally cannot think
# of what the next bit is. 
# Question B
# I don't remember, but I do know somewhere in there I will have to include the
# "count = n()" part and then also obviously mean. 
# Question C
penguins %>%
  arrange()
# Once again I remember the start but not where to go from there. 

# Viz Review
# Question 1
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)
       geom_boxplot(alpha = 0.7) +
       labs(
         title = "Body Mass of Different Penguin Species",
         x = "Species"
         y = "Body Mass (g)"
       ) +
       theme_dark()
# I am getting an error for a symbol, but I have stared at this too long that I
# cannot figure out the inccorect symbol. 

#Question 2
# I don't remember how to do a scatterplot, but I bet it's not that differnt 
# from how I created this one. 
       
# Put it Together
# I didn't get enough information as I attempted to do this review, so I can not 
# give an even educated guess to answer the final question. Sorry!
