# Preprocessing script.

train = read.csv("./data/train.csv", na.strings = "")
for (i in 9:109) {
  train[, i] = as.numeric(train[, i]) - 1
  train[, i][is.na(train[, i])] = mean(train[, i], na.rm=TRUE)
}

test = read.csv("./data/test.csv", na.strings = "")
for (i in 8:108) {
  test[, i] = as.numeric(test[, i]) - 1
  test[, i][is.na(test[, i])] = mean(test[, i], na.rm=TRUE)
}

## Clean up YOB
train$YOB = destring(as.character(train$YOB))
test$YOB = destring(as.character(test$YOB))

## Clean up Income
incomeLevels = 
  c("under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")

train$Income = factor(train$Income,levels=incomeLevels,ordered=TRUE)
test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)

## Clean up EducationLevel.
educationLevels = 
  c("Current K-12", "High School Diploma", "Current Undergraduate", 
    "Associate's Degree", "Bachelor's Degree", "Master's Degree", 
    "Doctoral Degree")

train$EducationLevel = 
  factor(train$EducationLevel,levels=educationLevels,ordered=TRUE)
test$EducationLevel = 
  factor(test$EducationLevel, levels=educationLevels, ordered=TRUE)

# Multiple imputation
imputationColumns = 
  c("YOB", "Gender", "Income", "HouseholdStatus", "EducationLevel", "Party", "votes")

all = rbind(train[-c(8)], test)
simple = all[imputationColumns]
set.seed(144)
imputed = complete(mice(simple))

train$YOB = imputed[1:nrow(train),]$YOB
train$Gender = imputed[1:nrow(train),]$Gender
train$Income = imputed[1:nrow(train),]$Income
train$HouseholdStatus = imputed[1:nrow(train),]$HouseholdStatus
train$EducationLevel = imputed[1:nrow(train),]$EducationLevel
train$Party = imputed[1:nrow(train),]$Party

test$YOB = imputed[(nrow(train) + 1):nrow(all),]$YOB
test$Gender = imputed[(nrow(train) + 1):nrow(all),]$Gender
test$Income = imputed[(nrow(train) + 1):nrow(all),]$Income
test$HouseholdStatus = imputed[(nrow(train) + 1):nrow(all),]$HouseholdStatus
test$EducationLevel = imputed[(nrow(train) + 1):nrow(all),]$EducationLevel
test$Party = imputed[(nrow(train) + 1):nrow(all),]$Party

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(train$Happy, SplitRatio = 0.65)

# Split up the data using subset
trainTrain = subset(train, split==TRUE)
trainTest = subset(train, split==FALSE)
