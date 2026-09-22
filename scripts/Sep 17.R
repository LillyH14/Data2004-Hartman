library(tidyverse)

crashes <- read_csv("data/raw/crashes.csv")
persons <- read_csv("data/raw/person.csv")

glimpse(crashes)
glimpse(persons)

# What does one row represent in each table?
# crashes = crashes that occur in NY city
# persons = recorded person involved with a crash in NY city

# What variable appears in both? Does it do the same job in both?

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

# question; how do person-level injury outcomes compare across boroughs?
# how should we figure out which one COLLISION_ID is?
crashes_core |>
  count(COLLISION_ID) |>
  filter(n>1)

persons_core |>
  count(UNIQUE_ID) |>
  filter(n>1)

persons_core |>
  count(COLLISION_ID) |>
  filter(n>1) |>
  arrange(desc(n))

# why does COLLISION_ID repeat in the person table?
# other forms of trasnportation; bus crash 

# do we have any missing keys? how do we figure that out?
crashes_core |>
  filter(is.na(COLLISION_ID))
persons_core |>
  filter(is.na(COLLISION_ID))
persons_core |>
  filter(is.na(UNIQUE_ID))

# cardinality, will be using one-to-many in this case
nrow(crashes_core)
nrow(persons_core)
n_distinct(persons_core$COLLISION_ID)

# 2 of those # are close but not =, what does the differance tell you before?
# couldn't see borad for anwser nor understood what was said outloud 

# joining sets; inner matches across both and left joins but not drop lack of matches
# keep the grain and population of the left hand join
crashes_inner <- crashes_core |>
  inner_join(persons_core, join_by(COLLISION_ID))

glimpse(crashes_inner)
# one row represnets one crash record with person-level crash information 

persons_inner <- persons_core |>
  inner_join(crashes_core, join_by(COLLISION_ID))

glimpse(persons_inner)
# one row represents one person record with crash-level information 

# now the other one. inner_join keeps rows that matched in BOTH tables.
# which one keeps every row of the LEFT table whether it matched or not.
crashes_left <- crashes_core |>
  left_join(persons_core, join_by(COLLISION_ID))

glimpse(crashes_left)

nrow(crashes_inner)
nrow(crashes_left)

# we know that there are some records that do not have person records involved
# self driving cars, etc

# when would you want inner_join vs left_join?
# depends on the comparison, and the question you are asking
# example of this being used... 
# We said this was one-to-many. We can say that in the code and make R check it

crashes_core |>  #crashes without people
  inner_join(persons_core, join_by(COLLISION_ID),
             relationship = "one-to-many")

crashes_core |> #people without crashes 
  inner_join(persons_core, join_by(COLLISION_ID),
             relationship = "one-to-one")




##### Your turn #####

# Build a person-level table that includes borough.

# Before you write anything (using persons):
## What should one row represent when you're done?
## Which table goes on the left?

# Then:
## Join them.
## Declare the cardinality with relationship = and see if R agrees.
## Use anti_join() to look at whatever didn't match.
## Count records by BOROUGH, PERSON_TYPE, and PERSON_INJURY.

# Some of those rows will have no borough. Before you filter them out:
# how many are there, and are they all missing for the same reason?




