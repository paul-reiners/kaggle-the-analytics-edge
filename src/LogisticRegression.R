# LOGISTIC REGRESSION

# Current AUC = 0.7225837/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Logistic Regression Model
trainTrain["Party5"] <- factor(trainTrain$Party == 'Republican')
trainTrain["EducationLevel4"] <- 
  factor(trainTrain$EducationLevel == "Associate's Degree")
trainTrain["Income5"] <- factor(trainTrain$Income == "$100,001 - $150,000")
trainTrain["Income6"] <- factor(trainTrain$Income == "over $150,000")

happyLog = 
  glm(
    Happy ~ Income5 + Income6 + EducationLevel4 
    + Party5 + Q119334 + Q118237 
    + Q117186 + Q117193 + Q113584 
    + Q107869 + Q102906 + Q102687 + Q101162 
    + Q99716 + Q98869 + Q98197, 
    data = trainTrain, family=binomial)
summary(happyLog)

# Predictions on the test set
trainTest["Party5"] <- factor(trainTest$Party == 'Republican')
trainTest["EducationLevel4"] <- 
  factor(trainTest$EducationLevel == "Associate's Degree")
trainTest["Income5"] <- factor(trainTest$Income == "$100,001 - $150,000")
trainTest["Income6"] <- factor(trainTest$Income == "over $150,000")

predictTest = predict(happyLog, type="response", newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
train["Party5"] <- factor(train$Party == 'Republican')
train["EducationLevel4"] <- factor(train$EducationLevel == "Associate's Degree")
train["Income5"] <- factor(train$Income == "$100,001 - $150,000")
train["Income6"] <- factor(train$Income == "over $150,000")

test["Party5"] <- factor(test$Party == 'Republican')
test["EducationLevel4"] <- factor(test$EducationLevel == "Associate's Degree")
test["Income5"] <- factor(test$Income == "$100,001 - $150,000")
test["Income6"] <- factor(test$Income == "over $150,000")

submissionHappyLog = 
  glm(
    Happy ~ Income5 + Income6 + EducationLevel4 
    + Party5 + Q119334 + Q118237 
    + Q117186 + Q117193 + Q113584 
    + Q107869 + Q102906 + Q102687 + Q101162 
    + Q99716 + Q98869 + Q98197, 
    data = train, family=binomial)
testPred = predict(submissionHappyLog, type="response", newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(
  submission, "./reports/LogisticRegression.csv", row.names=FALSE) 
