## CONDITIONAL RANDOM FOREST

# Current AUC = 0.7463873/XXX

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

NTREE = 2000

# Build random forest model
set.seed(415)
fit <- cforest(as.factor(Happy) ~ . - UserID,
               data = trainTrain, controls=cforest_unbiased(ntree=NTREE, mtry=3))

# Make predictions
probabilities <- unlist(treeresponse(fit, newdata=trainTest))
probabilities <- probabilities[seq(2, length(probabilities), 2)]

# Test set AUC 
auc1 <- 
  performance(prediction(probabilities, as.factor(trainTest$Happy)),"auc")@y.values[[1]]
auc1

# Create model on all data.
submissionFit <- cforest(as.factor(Happy) ~ . - UserID,
               data = train, controls=cforest_unbiased(ntree=NTREE, mtry=3))

# Make submission
probabilities <- unlist(treeresponse(submissionFit, newdata=test))
probabilities <- probabilities[seq(2, length(probabilities), 2)]
submit <- data.frame(UserID = test$UserID, Probability1 = probabilities)
write.csv(submit, file = "./reports/ConditionalRandomForest.csv", row.names = FALSE)
