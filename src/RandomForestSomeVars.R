## RANDOM FOREST

# Current AUC = 0.745401/0.72505
# Your submission scored 0.72505, which is not an improvement of your best score. 
# Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Convert outcome to factor
trainTrain$Happy = as.factor(trainTrain$Happy)
trainTest$Happy = as.factor(trainTest$Happy)

NTREE = 2000

# Build random forest model
forest = 
  randomForest(
    Happy ~ YOB + Gender + HouseholdStatus + Q118237 + Q101162 + Q107869 + Q102289 
    + Q106997 + Q98869 + Q119334 + Q120014 + Q108855 + Q115610 + Q108343 + Q116953
    + Q121011 + Q117186 + Q108617 + Q108617, 
    data=trainTrain, nodesize=25, importance=TRUE, ntree=NTREE)

# Make predictions
PredictForest = predict(forest, newdata = trainTest,type="prob")[,2]

# Test set AUC 
auc1 <- performance(prediction(PredictForest,trainTest$Happy),"auc")@y.values[[1]]
auc1

# Create model on all data.
train$Happy = as.factor(train$Happy)
submissionModel = 
  randomForest(
    Happy ~ YOB + Gender + HouseholdStatus + Q118237 + Q101162 + Q107869 + Q102289 
    + Q106997 + Q98869 + Q119334 + Q120014 + Q108855 + Q115610 + Q108343 + Q116953
    + Q121011 + Q117186 + Q108617 + Q108617, data=train, nodesize=25, ntree=NTREE)

# Make submission
testPred = predict(submissionModel, newdata=test,type="prob")[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(submission, "./reports/RandomForestSomeVars.csv", row.names=FALSE) 
