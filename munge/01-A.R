# Preprocessing script.

## Clean up Gender
train$Gender[train$Gender == ""] <- NA
train$Gender = factor(train$Gender)

test$Gender[test$Gender == ""] <- NA
test$Gender = factor(test$Gender)

## Clean up Income
incomeLevels = 
  c("under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000", "")

train$Income = factor(train$Income,levels=incomeLevels,ordered=TRUE)
train$Income[train$Income == ""] <- NA
train$Income = factor(train$Income)

test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)
test$Income[test$Income == ""] <- NA
test$Income = factor(test$Income)

# Clean up HouseholdStatus
train$HouseholdStatus[train$HouseholdStatus == ""] <- NA
train$HouseholdStatus = factor(train$HouseholdStatus)

test$HouseholdStatus[test$HouseholdStatus == ""] <- NA
test$HouseholdStatus = factor(test$HouseholdStatus)

## Clean up EducationLevel.
educationLevels = 
  c("Current K-12", "High School Diploma", "Current Undergraduate", 
    "Associate's Degree", "Bachelor's Degree", "Master's Degree", 
    "Doctoral Degree", "")

train$EducationLevel = 
  factor(train$EducationLevel,levels=educationLevels,ordered=TRUE)
train$EducationLevel[train$EducationLevel == ""] <- NA
train$EducationLevel = factor(train$EducationLevel)

test$EducationLevel = 
  factor(test$EducationLevel, levels=educationLevels, ordered=TRUE)
test$EducationLevel[test$EducationLevel == ""] <- NA
test$EducationLevel = factor(test$EducationLevel)

# Clean up Party.
train$Party[train$Party == ""] <- NA
train$Party = factor(train$Party)

test$Party[test$Party == ""] <- NA
test$Party = factor(test$Party)

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
