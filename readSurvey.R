library(readr)
library(readxl)
setwd(dirname(normalizePath(sys.frame(1)$ofile)))
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

print("Initial number of rows:")
print(nrow(df))

df <- subset(df, gender != "Prefer not to say")
print(paste("Number of rows after removing 'Prefer not to say':", nrow(df)))
df <- subset(df, minutes_exercise < 1500 )
print(paste("Number of rows after removing outliers in minutes_exercise:", nrow(df)))
df <- subset(df, miles_from_campus < 100 )
print(paste("Number of rows after removing outliers in miles_from_campus:", nrow(df)))
df <- subset(df, spending_on_transport < 800 )
print(paste("Number of rows after removing outliers in spending_on_transport:", nrow(df)))
df <- subset(df, spending_on_rent < 400 )
print(paste("Number of rows after removing outliers in spending_on_rent:", nrow(df)))
df <- subset(df, time_to_campus < 180 )
print(paste("Number of rows after removing outliers in time_to_campus:", nrow(df)))
df <- subset(df, spending_on_food < 500 )
print(paste("Number of rows after removing outliers in spending_on_food:", nrow(df)))
df <- subset(df, hometown_population < 30000000 )
print(paste("Number of rows after removing outliers in hometown_population:", nrow(df)))

avg_exercise_female <- mean(df$minutes_exercise[df$gender == "Woman"], na.rm = TRUE)
print(paste("Average minutes of exercise for females:", avg_exercise_female))

print("Number of rows after cleaning:")
print(nrow(df))


print("Minutes exercise summary:")
print(summary(df$minutes_exercise))
print("Miles from campus summary:")
print(summary(df$miles_from_campus))
print("Spending on transport summary:")
print(summary(df$spending_on_transport))
print("Spending on rent summary:")
print(summary(df$spending_on_rent))
print("Time to campus summary:")
print(summary(df$time_to_campus))
print("Spending on food summary:")
print(summary(df$spending_on_food))
print("Hometown population summary:")
print(summary(df$hometown_population))

numeric_columns <- c(
    "height_cm",
    "minutes_exercise",
    "miles_from_campus",
    "spending_on_transport",
    "spending_on_rent",
    "time_to_campus",
    "spending_on_food",
    "hometown_population"
)


hist(df$height_cm)

#exclude outliers
hist(df$minutes_exercise[df$minutes_exercise <= 1500], breaks = 10)
#exclude outliers
hist(df$miles_from_campus[df$miles_from_campus<100])
hist(df$height_cm[df$gender == "Woman"])



print("Table of Continents")
print(table(df$continent))
print("In percentage:")
print(prop.table(table(df$continent)) * 100)
print("Table of Gender")
print(table(df$gender))
print("In percentage:") 
print(prop.table(table(df$gender)) * 100)
print("Table of Awards")
print(table(df$award))
print("In percentage:")
print(prop.table(table(df$award)) * 100)
print("Table of PT Jobs")
print(table(df$ptjobs))
print("In percentage:") 
print(prop.table(table(df$ptjobs)) * 100)


print(prop.table(table(df$gender,df$ptjobs),margin=1)) 

png("hist.png")
hist(
    df$minutes_exercise[df$minutes_exercise <= 120],
    breaks = 20,
    main = 
        "Histogram of reported minutes exercise per week \n among students who exercised less than two hours on average",
    ylab = "Frequency",
    xlab = "Minutes exercise per week"
)
dev.off()

pie(
    table(df$award),
    main = "Distribution of Awards",
    col = rainbow(length(unique(df$award)))
)

pie(
    table(df$award),
    main = "Distribution of Awards",
    col = rainbow(length(unique(df$award))),
    labels = paste(names(table(df$award)), "\n", table(df$award)),
    init.angle = 90
)

pie(
    table(df$award),
    main = "Distribution of Awards",
    col = rainbow(length(unique(df$award))),
    labels = paste(
        names(table(df$award)),
        "\n",
        round(prop.table(table(df$award)) * 100, 1), "%",
        sep = ""
    ),
    init.angle = 90
)


award_gender_table <- table(df$award, df$gender)
barplot(
    award_gender_table,
    beside = TRUE,
    col = rainbow(nrow(award_gender_table)),
    legend = rownames(award_gender_table),
    main = "Barplot of Award by Gender",
    xlab = "Gender",
    ylab = "Count"
)


award_gender_table <- table(df$gender, df$award)
barplot(
    award_gender_table,
    beside = TRUE,
    col = rainbow(nrow(award_gender_table)),
    legend = rownames(award_gender_table),
    main = "Barplot of Award by Gender",
    xlab = "Gender",
    ylab = "Count"
)

award_gender_table <- table(df$award, df$gender)
award_gender_prop <- prop.table(award_gender_table, margin = 2) * 100
barplot(
    award_gender_prop,
    beside = TRUE,
    col = rainbow(nrow(award_gender_prop)),
    legend = rownames(award_gender_prop),
    main = "Barplot of Award by Gender (Percentage)",
    xlab = "Gender",
    ylab = "Percentage"
)


award_gender_table <- table(df$gender, df$award)
award_gender_prop <- prop.table(award_gender_table, margin = 1) * 100
barplot(
    award_gender_prop,
    beside = TRUE,
    col = rainbow(nrow(award_gender_prop)),
    legend = rownames(award_gender_prop),
    main = "Barplot of Award by Gender (Percentage)",
    xlab = "Gender",
    ylab = "Percentage"
)



award_gender_table <- table(df$award, df$gender)  # build contingency table of award (rows) by gender (columns)
award_gender_prop <- prop.table(award_gender_table, margin = 2) * 100  # convert counts to column-wise percentages (per gender) and scale to percent

# Pie chart for each gender showing award distribution
par(mfrow = c(1, ncol(award_gender_prop)))  # set plotting layout to 1 row and one column per gender
for (i in 1:ncol(award_gender_prop)) {  # loop over each gender (each column) to draw a pie
    pie(  # draw a pie chart for gender i
        award_gender_prop[, i],  # slice sizes: percentages of each award for the current gender
        main = paste("Awards for", colnames(award_gender_prop)[i]),  # title showing the current gender name
        col = rainbow(nrow(award_gender_prop)),  # use a rainbow palette with one color per award category
        labels = paste(rownames(award_gender_prop), "\n", round(award_gender_prop[, i], 1), "%"),  # labels with award name and rounded percentage
        init.angle = 90  # rotate start angle to 90 degrees for consistent orientation
    )  # end pie call
}  # end for loop
par(mfrow = c(1, 1)) # reset layout
# Histogram of miles from campus (exclude extreme outliers > 100 miles)
png("hist_miles_from_campus.png")
hist(
    df$miles_from_campus[df$miles_from_campus < 100],
    breaks = 20,
    main = "Histogram of Miles from Campus ( < 100 miles )",
    xlab = "Miles from campus",
    ylab = "Frequency",
    col = "lightblue"
)
dev.off()


award_counts <- table(df$award)
cols <- rainbow(length(award_counts))
bp <- barplot(
    award_counts,
    names.arg = rep("", length(award_counts)), # no labels under bars
    col = cols,
    main = "Distribution of Awards",
    xlab = "Award",
    ylab = "Count",
    ylim = c(0, max(award_counts) * 1.15)
)

text(bp, award_counts, labels = award_counts, pos = 3, cex = 0.8)

legend(
    "topright",
    legend = names(award_counts),
    fill = cols,
    bty = "o",
    bg = "white",
    box.col = "black",
    cex = 0.9
)


award_counts <- table(df$award) cols <- rainbow(length(award_counts)) bp <- barplot( award_counts, names.arg = rep("", length(award_counts)), # no labels under bars col = cols, main = "Distribution of Awards", xlab = "Award", ylab = "Count", ylim = c(0, max(award_counts) * 1.15) ) 

text(bp, award_counts, labels = award_counts, pos = 3, cex = 0.8) 

legend( "topright", legend = names(award_counts), fill = cols, bty = "o", box.col = "black", cex = 0.9 ) 

award_tab <- table(df$award)
cols <- rainbow(length(award_tab))
bp <- barplot(
    award_tab,
    names.arg = rep("", length(award_tab)),
    col = cols,
    main = "Awards by number",
    xlab = "Award",
    ylab = "Count"
)
par(xpd = TRUE)                          # allow drawing into margin
text(bp, -max(award_tab) * 0.05,         # place labels slightly below axis
         labels = names(award_tab),
         srt = -45,                          # rotate 45 degrees downward
         adj = 1, cex = 0.8)
par(xpd = FALSE)
