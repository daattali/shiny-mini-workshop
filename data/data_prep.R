library(dplyr)

# Source: https://www.kaggle.com/karangadiya/fifa19
players <- read.csv("data/fifa2019_raw.csv", stringsAsFactors = FALSE)

# Make sure all Wage and Value currencies are in Euros
wage_currency <- unique(substring(players$Wage, 1, 1))
stopifnot(length(wage_currency) == 1)
stopifnot(wage_currency == "€")
value_currency <- unique(substring(players$Value, 1, 1))
stopifnot(length(value_currency) == 1)
stopifnot(value_currency == "€")

# Make sure all wages are in thousands (or 0) and values are in thousands or millions
wage_unit <- unique(substring(players$Wage, nchar(players$Wage)))
stopifnot(length(wage_unit) == 2)
stopifnot(all(wage_unit %in% c("0", "K")))
value_unit <- unique(substring(players$Value, nchar(players$Value)))
stopifnot(length(value_unit) == 3)
stopifnot(all(value_unit %in% c("0", "K", "M")))

# Convert all wages and values to absolute numbers
players <- players %>% mutate(
  Value_unit = substring(Value, nchar(Value)),
  Value = substring(Value, 2, nchar(Value) - 1) %>% as.numeric(),
  Value = case_when(
    Value_unit == "0" ~ 0,
    Value_unit == "K" ~ Value * 1000,
    Value_unit == "M" ~ Value * 1000000
  ),

  Wage_unit = substring(Wage, nchar(Wage)),
  Wage = substring(Wage, 2, nchar(Wage) - 1) %>% as.numeric(),
  Wage = case_when(
    Wage_unit == "0" ~ 0,
    Wage_unit == "K" ~ Wage * 1000,
    Wage_unit == "M" ~ Wage * 1000000
  )
)

# Rename columns, keep only a few columns and save
players <- players %>% select(id = ID, name = Name, age = Age,
                              rating = Overall, value = Value, wage = Wage,
                              nationality = Nationality, photo = Photo)
write.csv(players, "data/fifa2019.csv", row.names = FALSE)
