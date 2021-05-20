## Data tranformation
library(tidyverse)
library(readxl)


# read data into R
student <- read_excel("scholarships.xlsx", 1)
address <- read_excel("scholarships.xlsx",2)
scholarships <- read_excel("scholarships.xlsx",3)

## VLOOKUP (Spreadsheet) == left_join (R)

## Mutating join (left, inner, right, full)
## data pipeline (tranformation)
student %>% 
    left_join(address, by = "id") %>%
    inner_join(scholarships, by = "id")

## Filtering JOin (ani_join & semi_join)
## anti join - select student dont qualify for scholarships
student %>%
    left_join(address, by = "id") %>%
    anti_join(scholarships, by = "id")

student %>%
    left_join(address, by = "id") %>%
    semi_join(scholarships, by = "id")


## Review dplyr
mtcars <- as_tibble(mtcars)

mtcars %>%
    select(milePerGallon = mpg, 
           horsePower = hp, wt, am) %>%
    filter(horsePower > 200) %>%
    mutate(milePerGallon = milePerGallon + 1,
           am = if_else(am == 0, "Auto", "Manual")) %>%
    arrange(am, desc(horsePower)) %>%
    summarise(avg_hp = mean(horsePower),
              sd_hp = sd(horsePower),
              n = n())

## Group By + Summarise
mtcars %>%
    mutate(am = if_else(am == 0, "Auto", "Manual")) %>%
    group_by(am) %>%
    summarise(avg_hp = mean(hp),
              sd_hp = sd(hp),
              n = n())

#join table
library(nycflights13)


result <- flights %>%
    filter(month == 9 & day == 9) %>%
    count(carrier) %>%
    arrange(desc(n)) %>%
    left_join(airlines, by = "carrier") %>%
    rename(carrier_name = name)


#write/ export csv file
write_csv(result, "learn-sql/nyc_summary.csv", )


# data wrangling 101 
mtcars

head(mtcars)
tail(mtcars)
summary(mtcars)

# dplyr
## select columns you want
mtcars %>%
    select(mpg, hp ,wt) %>%
    head(10)

mtcars %>%
    select(mpg, 3, 5, am)


mtcars %>%
    select( starts_with("a"))

mtcars %>%
    select(contains("w"))


# rename columns
m <- mtcars %>%
    select(milePerGallon = mpg,
           housePower = hp,
           weight = wt) %>%
    head(10)

# filter
mtcars %>%
    select(milePerGallon = mpg,
           horsePower = hp,
           weight = wt) %>%
    filter(horsePower < 100 & weight < 2) # AND



mtcars %>%
    select(milePerGallon = mpg,
           horsePower = hp,
           weight = wt) %>%
    filter(horsePower < 100 | weight < 2) # OR


mtcars %>%
    select(milePerGallon = mpg,
           horsePower = hp,
           weight = wt,
           transmission = am) %>%
    filter(transmission != 0)


# rownames to column
mtcars <- mtcars %>%
    rownames_to_column() %>%
    rename(model = rowname) %>%
    tibble()


# arrange (sort data)
mtcars %>%
    select(mpg, hp, wt) %>%
    arrange(hp) # asc

mtcars %>%
    select(mpg, hp, wt) %>%
    arrange(desc(hp)) # desc

# mutate create new column 
mtcars %>%
    select(mpg, hp, wt, am) %>%
    mutate(hp_edit = hp + 5,
           wt_double = wt * 2,
           am = if_else(am == 0, "Auto", "Manual")) %>%
    filter(am == "Auto")

# summarise data
mtcars %>%
    select(mpg, am) %>%
    mutate(am = if_else(am == 0, "Auto", "Manual")) %>%
    group_by(am) %>%
    summarise(avg_mpg = mean(mpg),
              sum_mpg = sum(mpg),
              sd_mpg = sd(mpg),
              min_mpg = min(mpg),
              max_mpg = max(mpg))


library(skimr)
mtcars <- mtcars %>%
    mutate(am = if_else(am == 0, "Auto", "Manual"))

View(mtcars)


mtcars %>%
    group_by(am) %>%
    skim()


mtcars %>%
    filter(hp < 150) %>%
    select(mpg, hp, wt, am) %>%
    group_by(am) %>%
    skim()






























