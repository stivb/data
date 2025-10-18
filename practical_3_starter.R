library(readr)
library(readxl)
df <- read_excel("7COM1079_survey.xlsx", col_names = TRUE)
print(colnames(df))


colnames(df)[1] <- "id"
colnames(df)[2] <- "start_time"
colnames(df)[3] <- "end_time"
colnames(df)[4] <- "person"
colnames(df)[5] <- "name"
colnames(df)[6] <- "award"
colnames(df)[7] <- "continent"
colnames(df)[8] <- "gender"
colnames(df)[9] <- "height_cm"
colnames(df)[10] <- "minutes_exercise"
colnames(df)[11] <- "miles_from_campus"
colnames(df)[12] <- "spending_on_transport"
colnames(df)[13] <- "spending_on_rent"
colnames(df)[14] <- "time_to_campus"
colnames(df)[15] <- "spending_on_food"
colnames(df)[16] <- "hometown_population"
colnames(df)[17] <- "ptjobs"


# The as.numeric function in R is used to convert an object to a numeric (double) type.
# This is particularly useful when you have data stored as characters or factors and need to perform mathematical operations.
# For example, if you have a vector of numbers stored as strings, as.numeric will convert them to actual numeric values.
# Note: If the conversion is not possible (e.g., non-numeric characters), R will return NA for those elements.
# Usage example: as.numeric("123") returns 123 as a numeric value.
df$height_cm <- as.numeric(df$height_cm)
df$minutes_exercise <- as.numeric(df$minutes_exercise)
df$miles_from_campus <- as.numeric(df$miles_from_campus)
df$spending_on_transport <- as.numeric(df$spending_on_transport)
df$spending_on_rent <- as.numeric(df$spending_on_rent)
df$time_to_campus <- as.numeric(df$time_to_campus)
df$spending_on_food <- as.numeric(df$spending_on_food)
df$hometown_population <- as.numeric(df$hometown_population)

