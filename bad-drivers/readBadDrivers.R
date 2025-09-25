library(readr)
setwd("C:\\Users\\comqsjb\\Desktop\\data\\bad-drivers")

# Read in the CSV file using the first row as column names
bad_drivers <- read_csv("bad-drivers.csv")
colnames(bad_drivers)[2] <- "nDeadDriversPerBillMiles"
colnames(bad_drivers)[3] <- "nDeadAlcohol"
colnames(bad_drivers)[4] <- "nDeadSpeeding"
colnames(bad_drivers)[5] <- "nDeadDistracted"
colnames(bad_drivers)[6] <- "nDeadFirstAccident"
colnames(bad_drivers)[7] <- "premiums"
colnames(bad_drivers)[8] <- "lossesPerDriver"


print(colnames(bad_drivers))

# Print the first few rows to verify
print(head(bad_drivers, 10))