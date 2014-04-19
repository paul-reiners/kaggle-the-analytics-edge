# CART

# Current AUC = 0.6467291/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Create a CART model
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

tree =  rpart(Happy ~ Income4 + Income5 + Income6 + EducationLevel4 
              + Party5 + Q122769No + Q119334No + Q118237 
              + Q117186HotHeaded + Q117193StandardHours + Q115777 + Q113584Technology 
              + Q107869No + Q106389No + Q102906Yes + Q102674No + Q102687No + Q101162 
              + Q100562No + Q99716Yes + Q98869Yes + Q98197No, data=trainTrain, method="class")
prp(tree)

# Make predictions
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

tree.pred = predict(tree, newdata=trainTest)
pred.prob = tree.pred[,2]

# Test set AUC 
ROCRpred = prediction(pred.prob, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
train["Q98197No"] <- factor(train$Q98197 == 'No')
train["Q98869Yes"] <- factor(train$Q98869 == 'Yes')
train["Q99716Yes"] <- factor(train$Q99716 == 'Yes')
train["Q102687No"] <- factor(train$Q102687 == 'No')
train["Q102674No"] <- factor(train$Q102674 == 'No')
train["Q102906Yes"] <- factor(train$Q102906 == 'Yes')
train["Q106389No"] <- factor(train$Q106389 == 'No')
train["Q113584Technology"] <- factor(train$Q113584 == 'Technology')
train["Q107869No"] <- factor(train$Q107869 == 'No')
train["Q100562No"] <- factor(train$Q100562 == 'No')
train["Q117193StandardHours"] <- factor(train$Q117193 == 'Standard hours')
train["Q117186HotHeaded"] <- factor(train$Q117186 == 'Hot headed')
train["Q119334No"] <- factor(train$Q119334 == 'No')
train["Party5"] <- factor(train$Party == 'Republican')
train["EducationLevel4"] <- factor(train$EducationLevel == "Associate's Degree")
train["Income4"] <- factor(train$Income == "$75,000 - $100,000")
train["Income5"] <- factor(train$Income == "$100,001 - $150,000")
train["Income6"] <- factor(train$Income == "over $150,000")
train["Q122769No"] <- factor(train$Q122769 == "No")

submissionTree = 
  rpart(
    Happy ~ Income4 + Income5 + Income6 + EducationLevel4 
    + Party5 + Q122769No + Q119334No + Q118237 + Q117186HotHeaded 
    + Q117193StandardHours + Q115777 + Q113584Technology + Q107869No + Q106389No 
    + Q102906Yes + Q102674No + Q102687No + Q101162 + Q100562No + Q99716Yes 
    + Q98869Yes + Q98197No, data=train, method="class")
testPred = predict(submissionTree, newdata=test)
testPred.prob = testPred[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred.prob)
write.csv(submission, "./reports/CART.csv", row.names=FALSE) 
