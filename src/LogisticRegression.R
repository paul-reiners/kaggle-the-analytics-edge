# LOGISTIC REGRESSION

# Current AUC = 0.7138925/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Logistic Regression Model
happyLog = 
  glm(
    Happy ~ . - UserID 
    - Q124742 - Q96024 - Q98078 - Q98059 - Q98578 - Q99480 - Q99581 - Q100010 
    - Q100680 - Q100689 - Q101596 - Q101163 - Q102089 - Q102289 - Q103293, 
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
    Happy ~ . - UserID 
    - Q124742 - Q96024 - Q98078 - Q98059 - Q98578 - Q99480 - Q99581 - Q100010 
    - Q100680 - Q100689 - Q101596 - Q101163 - Q102089 - Q102289 - Q103293, 
    data = train, family=binomial)
testPred = predict(submissionHappyLog, type="response", newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(
  submission, "./reports/LogisticRegression.csv", row.names=FALSE) 
