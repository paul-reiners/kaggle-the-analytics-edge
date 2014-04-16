# LOGISTIC REGRESSION

# Current AUC = 0.8238145

# Your submission scored 0.66532, which is not an improvement of your best score. Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Logistic Regression Model
happyLog = glm(Happy ~ . - UserID, data = trainTest, family=binomial)
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
write.csv(submission, "./submissions/LogisticRegression.csv", row.names=FALSE) 
