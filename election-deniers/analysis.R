setwd(".") # Ensure working directory is set to current folder
csv_files <- list.files(path = ".", pattern = "\\.csv$", full.names = TRUE)
print("CSV files in the current folder:")
print(csv_files)



df <- read.csv("fivethirtyeight_election_deniers.csv", header = FALSE, stringsAsFactors = FALSE)
colnames(df) <- as.character(unlist(df[1, ]))
df <- df[-1, ]

n <- nrow(df)


states <- unique(df$State)


offices <- unique(df$Office)


stances <- unique(df$Stance)

df$Stance <- as.factor(df$Stance)

stance_counts <- table(df$Stance)
print(stance_counts)

df$attitude <- NA
df$attitude[df$Stance %in% c("Accepted with reservations", "Fully accepted")] <- "Accept"
df$attitude[df$Stance %in% c("No comment", "Avoided answering")] <- "Mute"
df$attitude[df$Stance %in% c("Fully denied", "Raised questions")] <- "Denied"
df$attitude <- factor(df$attitude, levels = c("Accept", "Mute", "Denied"))

attitude_counts <- table(df$attitude)
print(attitude_counts)

pie(attitude_counts, labels = names(attitude_counts), main = "Attitude Distribution")

incumbency_counts <- table(df$Incumbent)
print(incumbency_counts)

incumbent_attitude_table <- table(df$Incumbent, df$attitude)
print(incumbent_attitude_table)