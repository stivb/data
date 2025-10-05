library(readr)
setwd(dirname(normalizePath(sys.frame(1)$ofile)))
biopics <- read_csv("biopics.csv")
print(colnames(biopics))

print(head(biopics))

biopics$decade <- biopics$year_release - (biopics$year_release %% 10)

sex_counts <- table(biopics$subject_sex)
sex_percent <- prop.table(sex_counts) * 100
print(round(sex_percent, 2))
print(table(biopics$year_release))

print(table(biopics$decade))

sex_decade_table <- table(biopics$decade, biopics$subject_sex)
sex_decade_percent <- prop.table(sex_decade_table, margin = 1) * 100
print(round(sex_decade_percent, 2))

barplot(table(biopics$decade, biopics$subject_sex), beside=TRUE, legend=TRUE, 
col=c("blue", "pink"), xlab="Decade", ylab="Count")