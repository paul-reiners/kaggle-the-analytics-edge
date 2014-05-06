# LOGISTIC REGRESSION

# Current AUC = 0.7292337/0.72383

# Your submission scored 0.72383, which is not an improvement of your best score. 
# Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Logistic Regression Model
happyLog = 
  glm(
    Happy ~ Q118237 + Q101162 + Q107869 + HouseholdStatus + votes + YOB 
    + Party + Q119334 + Q98869 + Q102906 + Income + Q102289 + EducationLevel 
    + Q106997 + Q108855 + Q120014 + Q108342 + Q115610, 
    data = trainTrain, family=binomial)
summary(happyLog)

# Predictions on the test set
predictTest = predict(happyLog, type="response", newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
submissionHappyLog = 
  glm(
    Happy ~ Q118237 + Q101162 + Q107869 + HouseholdStatus + votes + YOB 
    + Party + Q119334 + Q98869 + Q102906 + Income + Q102289 + EducationLevel 
    + Q106997 + Q108855 + Q120014 + Q108342 + Q115610, 
    data = train, family=binomial)
testPred = predict(submissionHappyLog, type="response", newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(
  submission, "./reports/LogisticRegression.csv", row.names=FALSE) 
