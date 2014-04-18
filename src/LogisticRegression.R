# LOGISTIC REGRESSION

# Current AUC = 0.7235094/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Logistic Regression Model
trainTrain["Q98197No"] <- factor(trainTrain$Q98197 == 'No')
trainTrain["Q98869Yes"] <- factor(trainTrain$Q98869 == 'Yes')
trainTrain["Q99716Yes"] <- factor(trainTrain$Q99716 == 'Yes')
trainTrain["Q102687No"] <- factor(trainTrain$Q102687 == 'No')
trainTrain["Q102674No"] <- factor(trainTrain$Q102674 == 'No')
trainTrain["Q102906Yes"] <- factor(trainTrain$Q102906 == 'Yes')
trainTrain["Q106389No"] <- factor(trainTrain$Q106389 == 'No')
trainTrain["Q113584Technology"] <- factor(trainTrain$Q113584 == 'Technology')
trainTrain["Q107869No"] <- factor(trainTrain$Q107869 == 'No')
trainTrain["Q100562No"] <- factor(trainTrain$Q100562 == 'No')
trainTrain["Q117193StandardHours"] <- factor(trainTrain$Q117193 == 'Standard hours')
trainTrain["Q117186HotHeaded"] <- factor(trainTrain$Q117186 == 'Hot headed')
trainTrain["Q119334No"] <- factor(trainTrain$Q119334 == 'No')
trainTrain["Party5"] <- factor(trainTrain$Party == 'Republican')
trainTrain["EducationLevel4"] <- 
  factor(trainTrain$EducationLevel == "Associate's Degree")
trainTrain["Income4"] <- factor(trainTrain$Income == "$75,000 - $100,000")
trainTrain["Income5"] <- factor(trainTrain$Income == "$100,001 - $150,000")
trainTrain["Income6"] <- factor(trainTrain$Income == "over $150,000")
trainTrain["Q122769No"] <- factor(trainTrain$Q122769 == "No")

happyLog = 
  glm(
    Happy ~ Income4 + Income5 + Income6 + EducationLevel4 
    + Party5 + Q122769No + Q119334No + Q118237 
    + Q117186HotHeaded + Q117193StandardHours + Q115777 + Q113584Technology 
    + Q107869No + Q106389No + Q102906Yes + Q102674No + Q102687No + Q101162 
    + Q100562No + Q99716Yes + Q98869Yes + Q98197No, 
    data = trainTrain, family=binomial)
summary(happyLog)

# Predictions on the test set
trainTest["Q98197No"] <- factor(trainTest$Q98197 == 'No')
trainTest["Q98869Yes"] <- factor(trainTest$Q98869 == 'Yes')
trainTest["Q99716Yes"] <- factor(trainTest$Q99716 == 'Yes')
trainTest["Q102687No"] <- factor(trainTest$Q102687 == 'No')
trainTest["Q102674No"] <- factor(trainTest$Q102674 == 'No')
trainTest["Q102906Yes"] <- factor(trainTest$Q102906 == 'Yes')
trainTest["Q106389No"] <- factor(trainTest$Q106389 == 'No')
trainTest["Q113584Technology"] <- factor(trainTest$Q113584 == 'Technology')
trainTest["Q107869No"] <- factor(trainTest$Q107869 == 'No')
trainTest["Q100562No"] <- factor(trainTest$Q100562 == 'No')
trainTest["Q117193StandardHours"] <- factor(trainTest$Q117193 == 'Standard hours')
trainTest["Q117186HotHeaded"] <- factor(trainTest$Q117186 == 'Hot headed')
trainTest["Q119334No"] <- factor(trainTest$Q119334 == 'No')
trainTest["Party5"] <- factor(trainTest$Party == 'Republican')
trainTest["EducationLevel4"] <- 
  factor(trainTest$EducationLevel == "Associate's Degree")
trainTest["Income4"] <- factor(trainTest$Income == "$75,000 - $100,000")
trainTest["Income5"] <- factor(trainTest$Income == "$100,001 - $150,000")
trainTest["Income6"] <- factor(trainTest$Income == "over $150,000")
trainTest["Q122769No"] <- factor(trainTest$Q122769 == "No")

predictTest = predict(happyLog, type="response", newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(predictTest, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
submissionHappyLog = 
  glm(
    Happy ~ . - UserID 
    - Q124742 - Q96024 - Q98078 - Q98059 - Q98578 - Q99480 - Q99581 - Q100010 
    - Q100680 - Q100689 - Q101596 - Q101163 - Q102089 - Q102289 - Q103293 - Q104996, 
    data = train, family=binomial)
testPred = predict(submissionHappyLog, type="response", newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(
  submission, "./reports/LogisticRegression.csv", row.names=FALSE) 
