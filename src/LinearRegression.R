# LINEAR REGRESSION

# Current AUC = 0.7224529/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

## Linear Regression (all variables)
model3 = lm(Happy ~ . - UserID, data=train)
summary(model3)

# Make test set predictions
predictTest = predict(model3, newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
testPred = predict(model3, newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
submission = transform(submission, Probability1 = ifelse(Probability1 > 1.0, 1.0, Probability1))
submission = transform(submission, Probability1 = ifelse(Probability1 < 0.0, 0.0, Probability1))
write.csv(submission, "./submissions/LinearRegression.csv", row.names=FALSE) 
