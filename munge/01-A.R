# Preprocessing script.

## Convert Income to a numeric
incomeLevels = 
  c("", "under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")

allTrain$Income = factor(allTrain$Income,levels=incomeLevels,ordered=TRUE)
allTrain$Income = as.numeric(allTrain$Income)
allTrain$Income[allTrain$Income == 1] <- NA

test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)
test$Income = as.numeric(test$Income)
test$Income[test$Income == 1] <- NA

## Convert EducationLevel to a numeric
educationLevels = 
  c("", "Current K-12", "High School Diploma", "Current Undergraduate", 
    "Associate's Degree", "Bachelor's Degree", "Master's Degree", 
    "Doctoral Degree")

allTrain$EducationLevel = 
  factor(allTrain$EducationLevel,levels=educationLevels,ordered=TRUE)
allTrain$EducationLevel = as.numeric(allTrain$EducationLevel)
allTrain$EducationLevel[allTrain$EducationLevel == 1] <- NA

test$EducationLevel = factor(test$EducationLevel,levels=educationLevels,ordered=TRUE)
test$EducationLevel = as.numeric(test$EducationLevel)
test$EducationLevel[test$EducationLevel == 1] <- NA

## Convert Gender to a numeric
genderLevels = 
  c("", "Female", "Male")

allTrain$Gender = 
  factor(allTrain$Gender,levels=genderLevels,ordered=TRUE)
allTrain$Gender = as.numeric(allTrain$Gender)
allTrain$Gender[allTrain$Gender == 1] <- NA

test$Gender = factor(test$Gender,levels=genderLevels,ordered=TRUE)
test$Gender = as.numeric(test$Gender)
test$Gender[test$Gender == 1] <- NA

# Multiple imputation
imputationColumns = c("YOB", "EducationLevel", "Income", "Gender")

simpleAllTrain = allTrain[imputationColumns]
set.seed(144)
imputedAllTrain = complete(mice(simpleAllTrain))
allTrain$YOB = imputedAllTrain$YOB
allTrain$Income = imputedAllTrain$Income
allTrain$EducationLevel = imputedAllTrain$EducationLevel
allTrain$Gender = imputedAllTrain$Gender

simpleTest = test[imputationColumns]
set.seed(144)
imputedTest = complete(mice(simpleTest))
test$YOB = imputedTest$YOB
test$Income = imputedTest$Income
test$EducationLevel = imputedTest$EducationLevel
test$Gender = imputedTest$Gender

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(allTrain$Happy, SplitRatio = 0.65)

# Split up the data using subset
train = subset(allTrain, split==TRUE)
trainTest = subset(allTrain, split==FALSE)
