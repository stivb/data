library(readr)
setwd(dirname(normalizePath(sys.frame(1)$ofile)))

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
print(head(bad_drivers,10))

# Find the state with the lowest nDeadDriversPerBillMiles
min_state <- bad_drivers$State[which.min(bad_drivers$nDeadDriversPerBillMiles)]
cat("State with lowest nDeadDriversPerBillMiles:", min_state, "\n")

# Find the state with the highest nDeadDriversPerBillMiles
max_state <- bad_drivers$State[which.max(bad_drivers$nDeadDriversPerBillMiles)]
cat("State with highest nDeadDriversPerBillMiles:", max_state, "\n")

# Find the state with the lowest premiums
min_premium_state <- bad_drivers$State[which.min(bad_drivers$premiums)]
cat("State with lowest premiums:", min_premium_state, "\n")

# Find the state with the highest premiums
max_premium_state <- bad_drivers$State[which.max(bad_drivers$premiums)]
cat("State with highest premiums:", max_premium_state, "\n")
# Find the state with the lowest lossesPerDriver
min_losses_state <- bad_drivers$State[which.min(bad_drivers$lossesPerDriver)]
cat("State with lowest lossesPerDriver:", min_losses_state, "\n")           
# Find the state with the highest lossesPerDriver
max_losses_state <- bad_drivers$State[which.max(bad_drivers$lossesPerDriver)]
cat("State with highest lossesPerDriver:", max_losses_state, "\n")
# Draw a histogram of the nDeadDriversPerBillMiles column
hist(bad_drivers$nDeadDriversPerBillMiles,
    main = "Histogram of nDeadDriversPerBillMiles",
    xlab = "nDeadDriversPerBillMiles",
    col = "lightblue",
    border = "black")
