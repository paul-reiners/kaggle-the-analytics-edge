## CONDITIONAL RANDOM FOREST

# Current AUC = XXX/XXX

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

NTREE = 100

# Build random forest model
set.seed(415)
fit <- cforest(as.factor(Happy) ~ . - UserID,
               data = trainTrain, controls=cforest_unbiased(ntree=NTREE, mtry=3))

# Make predictions
Prediction <- predict(fit, trainTest, OOB=TRUE, type = "response")

# Test set AUC 
# TODO
# auc1 <- performance(prediction(Prediction,trainTest$Happy),"auc")@y.values[[1]]
# auc1

# Create model on all data.
submissionFit <- cforest(as.factor(Happy) ~ . - UserID,
               data = train, controls=cforest_unbiased(ntree=NTREE, mtry=3))

# Make submission
SubmissionPrediction <- predict(submissionFit, test, OOB=TRUE, type = "response")
submit <- data.frame(UserID = test$UserID, Probability1 = SubmissionPrediction)
write.csv(submit, file = "./reports/ConditionalRandomForest.csv", row.names = FALSE)
