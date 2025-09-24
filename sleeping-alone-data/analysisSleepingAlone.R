library(readr)
library(ggplot2)
df <- read_csv("sleeping-alone-data.csv")
df<-df[-1,]
names(df)[3] <- "CurrStatus"            
names(df)[4] <- "HowLong"
names(df)[5] <- "HowOftSepBedAtHome"
names(df)[6] <- "WhereSleep"    
names(df)[8] <- "WhereSleepPartner"
names(df)[10]<-"WhySeparateBeds"
names(df)[21]<-"WhenFirstSepBeds"
names(df)[22]<-"SepBedsHelpKeepTogetherYN"
names(df)[23]<-"SleepBetterSeparateYN"    
names(df)[24]<-"SexBetterSeparateBedsYN"
colnames(df)
unique(df$HowLong)
barplot(table(na.omit(df$HowLong)))
df$rshiplength <- ifelse(df$HowLong %in% c("Less than 1 year", "1-5 years", "6-10 years"), "upto10",
                    ifelse(df$HowLong %in% c("11-15 years", "16-20 years"), "11to20", 
                          ifelse(df$HowLong == "More than 20 years", "21+", NA)))
barplot(table(na.omit(df$rshiplength)))
unique(na.omit(df$HowOftSepBedAtHome))
HowOftSepBedAtHomeTbl<-table(na.omit(df$HowOftSepBedAtHome))
barplot(HowOftSepBedAtHomeTbl)
sepBedRShipLengthTbl<-table(df$HowOftSepBedAtHome, df$rshiplength)

#create another dataframe from df containing only rshiplength and HowOftSepBedAtHome excluding all NAs
df2 <- df[!is.na(df$HowOftSepBedAtHome) & !is.na(df$rshiplength), c("rshiplength", "HowOftSepBedAtHome")]

ggplot(df2, aes(x = rshiplength, fill = HowOftSepBedAtHome)) +
  geom_bar(position = "fill") +
  ylab("Proportion") +
  scale_y_continuous(labels = scales::percent)

# Analysis of WhereSleep
# show the distribution of WhereSleep
unique(na.omit(df$WhereSleep))
WhereSleepTbl<-table(na.omit(df$WhereSleep))

