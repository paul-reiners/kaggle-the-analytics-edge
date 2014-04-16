# Preprocessing script.

# Convert Income to a numeric
incomeLevels = 
  c("", "under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")
allTrain$Income = factor(allTrain$Income,levels=incomeLevels,ordered=TRUE)
allTrain$Income = as.numeric(allTrain$Income)
test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)
test$Income = as.numeric(test$Income)

# Convert EducationLevel to a numeric
educationLevels = 
  c("", "Current K-12", "High School Diploma", "Current Undergraduate", 
    "Associate's Degree", "Bachelor's Degree", "Master's Degree", "Doctoral Degree")
allTrain$EducationLevel = 
  factor(allTrain$EducationLevel,levels=educationLevels,ordered=TRUE)
allTrain$EducationLevel = as.numeric(allTrain$EducationLevel)
test$EducationLevel = factor(test$EducationLevel,levels=educationLevels,ordered=TRUE)
test$EducationLevel = as.numeric(test$EducationLevel)

# Multiple imputation
simpleAllTrain = allTrain[c("YOB", "EducationLevel")]
set.seed(144)
imputedAllTrain = complete(mice(simpleAllTrain))
allTrain$YOB = imputedAllTrain$YOB

simpleTest = test[c("YOB", "EducationLevel")]
set.seed(144)
imputedTest = complete(mice(simpleTest))
test$YOB = imputedTest$YOB

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(allTrain$Happy, SplitRatio = 0.65)

# Split up the data using subset
train = subset(allTrain, split==TRUE)
trainTest = subset(allTrain, split==FALSE)
