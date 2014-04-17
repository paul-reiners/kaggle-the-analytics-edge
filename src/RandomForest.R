## RANDOM FOREST

# Current AUC = 0.7380277/xxx

# 124  -8	 Paul Reiners	 0.72821	11	 Thu, 17 Apr 2014 00:05:50
# Your Best Entry
# You improved on your best score by 0.00660. 
# You just moved up 39 positions on the leaderboard.

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Convert outcome to factor
train$Happy = as.factor(train$Happy)
trainTest$Happy = as.factor(trainTest$Happy)

# Build random forest model
forest = randomForest(Happy ~ . - UserID, data=train, ntree=200, nodesize=25)

# Make predictions
PredictForest = predict(forest, newdata = trainTest,type="prob")[,2]

# Test set AUC 
auc1 <- performance(prediction(PredictForest,trainTest$Happy),"auc")@y.values[[1]]
auc1

# Make submission
testPred = predict(forest, newdata=test,type="prob")[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(submission, "./reports/RandomForest.csv", row.names=FALSE) 
