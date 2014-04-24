## RANDOM FOREST

# Current AUC = 0.7287012/0.72883

# Your submission scored 0.72883, which is not an improvement of your best score. 
# Keep trying!

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

NTREE = 2000

# Build random forest model
forest = 
  randomForest(
    as.factor(Happy) ~ . - UserID, data=trainTrain, nodesize=25, importance=TRUE, ntree=NTREE)

# Make predictions
PredictForest = predict(forest, newdata = trainTest,type="prob")[,2]

# Test set AUC 
auc1 <- 
  performance(prediction(PredictForest, as.factor(trainTest$Happy)),"auc")@y.values[[1]]
auc1

# Create model on all data.
submissionModel = 
  randomForest(as.factor(Happy) ~ . - UserID, data=train, nodesize=25, ntree=NTREE)
varImpPlot( submissionModel, n.var = 18, main = "Importance of variables" )

# Make submission
testPred = predict(submissionModel, newdata=test,type="prob")[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(submission, "./reports/RandomForest.csv", row.names=FALSE) 
