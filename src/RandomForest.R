## RANDOM FOREST

# Current AUC = 0.7380277/xxx

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
plot(performance(prediction(PredictForest,trainTest$Happy),"tpr","fpr"),col = "red")

# Test set AUC 
auc1 <- performance(prediction(PredictForest,trainTest$Happy),"auc")@y.values[[1]]
auc1

# Make submission
testPred = predict(forest, newdata=test,type="prob")[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(submission, "./submissions/RandomForest.csv", row.names=FALSE) 
