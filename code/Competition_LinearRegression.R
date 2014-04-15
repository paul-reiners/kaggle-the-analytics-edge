# LINEAR REGRESSION

# 74  -5	 Paul Reiners	 0.69178	2	 Tue, 15 Apr 2014 18:31:26
# Your Best Entry
# You improved on your best score by 0.05038. 
# You just moved up 15 positions on the leaderboard.

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library(ROCR)

# Read in data
allTrain = read.csv("./data/train.csv")

# Load the library caTools
library(caTools)

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(allTrain$Happy, SplitRatio = 0.65)

# Split up the data using subset
train = subset(allTrain, split==TRUE)
trainTest = subset(allTrain, split==FALSE)

## Linear Regression (all variables)
model3 = lm(Happy ~ ., data=train)

# Make test set predictions
predictTest = predict(model3, newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
test = read.csv("./data/test.csv")
testPred = predict(model3, newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
submission[is.na(submission)] <- 0.5
submission = transform(submission, Probability1 = ifelse(Probability1 > 1.0, 1.0, Probability1))
submission = transform(submission, Probability1 = ifelse(Probability1 < 0.0, 0.0, Probability1))
write.csv(submission, "./submissions/LinearRegression.csv", row.names=FALSE) 
