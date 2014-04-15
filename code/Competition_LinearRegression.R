# LINEAR REGRESSION

# Current AUC = 0.7206549

# 79  -2	 Paul Reiners	 0.69257	4	 Tue, 15 Apr 2014 19:30:02
# Your Best Entry
# You improved on your best score by 0.00079. 

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library(ROCR)

# Read in data
allTrain = read.csv("./data/train.csv")

# Order Income
incomes = 
  c("", "under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")
allTrain$Income = factor(allTrain$Income, levels=incomes, ordered=TRUE)

# Load the library caTools
library(caTools)

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(allTrain$Happy, SplitRatio = 0.65)

# Split up the data using subset
train = subset(allTrain, split==TRUE)
trainTest = subset(allTrain, split==FALSE)

## Linear Regression (all variables)
model3 = lm(Happy ~ . - UserID, data=train)
summary(model3)

# Make test set predictions
predictTest = predict(model3, newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
test = read.csv("./data/test.csv")

# Order Income
test$Income = factor(test$Income, levels=incomes, ordered=TRUE)

testPred = predict(model3, newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
submission[is.na(submission)] <- 0.5
submission = transform(submission, Probability1 = ifelse(Probability1 > 1.0, 1.0, Probability1))
submission = transform(submission, Probability1 = ifelse(Probability1 < 0.0, 0.0, Probability1))
write.csv(submission, "./submissions/LinearRegression.csv", row.names=FALSE) 
