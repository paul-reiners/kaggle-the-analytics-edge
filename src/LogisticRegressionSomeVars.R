# LOGISTIC REGRESSION

# Current AUC = 0.7252423

# Your submission scored 0.66793, which is not an improvement of your best score. 
# Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Logistic Regression Model
happyLog = glm(Happy ~ Q122771 + Q121011 + Q120650 + Q120194 + Q120014 + Q119334 + Q119851 + Q117186 + Q111220 + Q102289 + Q102089 + Q101162 + Q99716, data = trainTest, family=binomial)
summary(happyLog)

# Predictions on the test set
predictTest = predict(happyLog, type="response", newdata=trainTest)

# Confusion matrix with threshold of 0.5
table(trainTest$Happy, predictTest > 0.5)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
testPred = predict(happyLog, type="response", newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
submission[is.na(submission)] <- 0.5
write.csv(submission, "./submissions/LogisticRegressionSomeVars.csv", row.names=FALSE) 
