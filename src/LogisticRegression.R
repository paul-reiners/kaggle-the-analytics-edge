# LOGISTIC REGRESSION

# Current AUC = 0.7225837/0.71611

# Your submission scored 0.71611, which is not an improvement of your best score. 
# Keep trying!

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
    Happy ~ Q1227702 + Q1217002 + Q1210112 + Q1200142 + Q1193342 + Q1182332
    + Q1182372 + Q1171932 + Q1164412 + Q1153902 + Q1147482 + Q1135832
    + Q1087542 + Q1083422 + Q1078692 + Q1029062 + Q1022892 + Q1011622, 
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
    Happy ~ Q1227702 + Q1217002 + Q1210112 + Q1200142 + Q1193342 + Q1182332
    + Q1182372 + Q1171932 + Q1164412 + Q1153902 + Q1147482 + Q1135832
    + Q1087542 + Q1083422 + Q1078692 + Q1029062 + Q1022892 + Q1011622, 
    data = train, family=binomial)
testPred = predict(submissionHappyLog, type="response", newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(
  submission, "./reports/LogisticRegression.csv", row.names=FALSE) 
