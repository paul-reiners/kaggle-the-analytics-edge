# Preprocessing script.

## Convert Income to a numeric
incomeLevels = 
  c("", "under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")

train$Income = factor(train$Income,levels=incomeLevels,ordered=TRUE)
train$Income = as.numeric(train$Income)
train$Income[train$Income == 1] <- NA

test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)
test$Income = as.numeric(test$Income)
test$Income[test$Income == 1] <- NA

## Convert EducationLevel to a numeric
educationLevels = 
  c("", "Current K-12", "High School Diploma", "Current Undergraduate", 
    "Associate's Degree", "Bachelor's Degree", "Master's Degree", 
    "Doctoral Degree")

train$EducationLevel = 
  factor(train$EducationLevel,levels=educationLevels,ordered=TRUE)
train$EducationLevel = as.numeric(train$EducationLevel)
train$EducationLevel[train$EducationLevel == 1] <- NA

test$EducationLevel = factor(test$EducationLevel,levels=educationLevels,ordered=TRUE)
test$EducationLevel = as.numeric(test$EducationLevel)
test$EducationLevel[test$EducationLevel == 1] <- NA

## Convert Gender to a numeric
genderLevels = 
  c("", "Female", "Male")

train$Gender = 
  factor(train$Gender,levels=genderLevels,ordered=TRUE)
train$Gender = as.numeric(train$Gender)
train$Gender[train$Gender == 1] <- NA

test$Gender = factor(test$Gender,levels=genderLevels,ordered=TRUE)
test$Gender = as.numeric(test$Gender)
test$Gender[test$Gender == 1] <- NA

# Multiple imputation
imputationColumns = c("YOB", "EducationLevel", "Income", "Gender")

simpleAllTrain = train[imputationColumns]
set.seed(144)
imputedAllTrain = complete(mice(simpleAllTrain))
train$YOB = imputedAllTrain$YOB
train$Income = imputedAllTrain$Income
train$EducationLevel = imputedAllTrain$EducationLevel
train$Gender = imputedAllTrain$Gender

simpleTest = test[imputationColumns]
set.seed(144)
imputedTest = complete(mice(simpleTest))
test$YOB = imputedTest$YOB
test$Income = imputedTest$Income
test$EducationLevel = imputedTest$EducationLevel
test$Gender = imputedTest$Gender

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(train$Happy, SplitRatio = 0.65)

# Split up the data using subset
trainTrain = subset(train, split==TRUE)
trainTest = subset(train, split==FALSE)
