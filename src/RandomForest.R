## RANDOM FOREST

# Current AUC = 0.7315179/xxx

# Your submission scored 0.74020, which is not an improvement of your best score. 
# Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Convert outcome to factor
trainTrain$Happy = as.factor(trainTrain$Happy)
trainTest$Happy = as.factor(trainTest$Happy)

# Build random forest model
forest = randomForest(Happy ~ . - UserID, data=trainTrain, nodesize=25)

# Make predictions
PredictForest = predict(forest, newdata = trainTest,type="prob")[,2]

# Test set AUC 
auc1 <- performance(prediction(PredictForest,trainTest$Happy),"auc")@y.values[[1]]
auc1

# Create model on all data.
train$Happy = as.factor(train$Happy)
submissionModel = randomForest(Happy ~ . - UserID, data=train, nodesize=25)

# Make submission
testPred = predict(submissionModel, newdata=test,type="prob")[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(submission, "./reports/RandomForest.csv", row.names=FALSE) 
