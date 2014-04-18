# LINEAR REGRESSION

# Current AUC = 0.719655/0.73187

# Your submission scored 0.73187, which is not an improvement of your best score. 
# Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

## Linear Regression (all variables)
model3 = 
  lm(
    Happy ~ . - UserID 
    - Q124742 - Q123621 - Q122120 - Q120650 - Q120012 - Q116881 - Q116448 
    - Q114961 - Q115195 - Q111848 - Q118232 - Q109367 - Q108950 - Q108754
    - Q114152 - Q120472 - Q114517 - Q108855 - Q98059 - Q106042 - Q101596
    - Q124122 - Q122770 - Q118117 - Q100680 - Q121699 - Q120379 - Q108617
    - Q116953 - Q117186 - Q113181 - Q111220 - Q108342 - Q113583 - Q105655
    - Q113584 - Q102089 - Q120978 - Q99480 - Q98578 - Q115611 - Q114386
    - Q116441 - Q116197 - Q115610 - Q108343 - Q112478 - Q115899 - Q106997
    - Q106993 - Q118233 - Q120014 - Q115390 - Q96024 - Q100010 - Q102687
    - Q100689, 
    data=trainTrain)
summary(model3)

# Make test set predictions
predictTest = predict(model3, newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
submissionModel = 
  lm(
    Happy ~ . - UserID 
    - Q124742 - Q123621 - Q122120 - Q120650 - Q120012 - Q116881 - Q116448 
    - Q114961 - Q115195 - Q111848 - Q118232 - Q109367 - Q108950 - Q108754
    - Q114152 - Q120472 - Q114517 - Q108855 - Q98059 - Q106042 - Q101596
    - Q124122 - Q122770 - Q118117 - Q100680 - Q121699 - Q120379 - Q108617
    - Q116953 - Q117186 - Q113181 - Q111220 - Q108342 - Q113583 - Q105655
    - Q113584 - Q102089 - Q120978 - Q99480 - Q98578 - Q115611 - Q114386
    - Q116441 - Q116197 - Q115610 - Q108343 - Q112478 - Q115899 - Q106997
    - Q106993 - Q118233 - Q120014 - Q115390 - Q96024 - Q100010 - Q102687
    - Q100689, 
    data=train)
testPred = predict(submissionModel, newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
submission = transform(submission, Probability1 = ifelse(Probability1 > 1.0, 1.0, Probability1))
submission = transform(submission, Probability1 = ifelse(Probability1 < 0.0, 0.0, Probability1))
write.csv(submission, "./reports/LinearRegression.csv", row.names=FALSE) 
