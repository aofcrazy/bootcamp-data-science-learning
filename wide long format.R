## tidy data (wide to long format)

worldphone_wide <- read_csv("https://gist.githubusercontent.com/toyeiei/d9e267754d0b7a7045e182b3d0011636/raw/04cf2d5b211dc3df279b36d968fde11ed1c9bb67/worldphone.csv")


worldphone_wide %>%
    pivot_longer(N.Amer:Mid.Amer, 
                 names_to = "Region",
                 values_to = "Sales") %>%
    pivot_wider(names_from = "Region",
                values_from = "Sales")

worldphone_long <- worldphone_wide %>%
    pivot_longer(N.Amer:Mid.Amer, 
                 names_to = "Region",
                 values_to = "Sales")

## Export
write_csv(worldphone_long, "worldphone_long.csv")
