# Load required library
library(readr)
setwd(dirname(normalizePath(sys.frame(1)$ofile)))

# Import biopics.csv with headers
biopics <- read_csv("biopics.csv")

# Get non-numeric columns
non_numeric_cols <- names(biopics)[
    !sapply(biopics, is.numeric) & sapply(biopics, function(x) length(unique(x)) < 30)
]

print("Non-numeric columns:")
print(non_numeric_cols)

results <- data.frame(
    colName = character(),
    colName2 = character(),
    colItem = character(),
    colItem2 = character(),
    colCount = integer(),
    stringsAsFactors = FALSE
)



for (col in non_numeric_cols) {
       tbl <- table(biopics[[col]])
    for (item in names(tbl)) {
        results <- rbind(
            results,
            data.frame(
                colName = col,
                colItem = item,
                colCount = tbl[[item]],
                colName2 = NA,
                colItem2 = NA,
                stringsAsFactors = FALSE
            )
        )
    }

    }

    print("Non numeric columns are:")
    print(non_numeric_cols)

tbl <- table(biopics$subject_sex, biopics$race_known)
print(tbl)
tb2 <- table(biopics$subject_sex, biopics$type_of_subject)
print(tb2)

# Add cross tabulation results from tbl (subject_sex vs race_known)
for (sex in rownames(tbl)) {
    for (race in colnames(tbl)) {
        results <- rbind(
            results,
            data.frame(
                colName = "subject_sex",
                colItem = sex,
                colCount = tbl[sex, race],
                colName2 = "race_known",
                colItem2 = race,
                stringsAsFactors = FALSE
            )
        )
    }
}

# Add cross tabulation results from tb2 (subject_sex vs type_of_subject)
for (sex in rownames(tb2)) {
    for (type in colnames(tb2)) {
        results <- rbind(
            results,
            data.frame(
                colName = "subject_sex",
                colItem = sex,
                colCount = tb2[sex, type],
                colName2 = "type_of_subject",
                colItem2 = type,
                stringsAsFactors = FALSE
            )
        )
    }
}

print("Results:")
print(results)


quiz_questions <- ""

for (i in seq_len(nrow(results))) {
    if (results$colCount[i] > 0) {
    if (is.na(results$colName2[i])) {
        quiz_questions <- paste0(quiz_questions, 
                                i, ". How many times does *", 
                                results$colItem[i], "* appear in the column *", 
                                results$colName[i], "*?\n= ", 
                                results$colCount[i], "\n")
    }
    else {
        quiz_questions <- paste0(quiz_questions, 
                                i, ". How many times does *", 
                                results$colItem2[i], "* appear in the column :*", 
                                results$colName2[i], 
                                "* when the value in *", results$colName[i], "* is *", results$colItem[i], "*?\n= ", 
                                results$colCount[i], "\n")
    }
}
}

print(quiz_questions)
writeLines(quiz_questions, "biopics.qti.txt")