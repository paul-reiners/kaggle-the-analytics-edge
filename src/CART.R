# CART

# Current AUC = 0.6445096/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Let's use all the variables

# Create a CART model
tree = rpart(Happy ~ . - UserID, data=train, method="class")
prp(tree)

# Make predictions
tree.pred = predict(tree, newdata=trainTest)
pred.prob = tree.pred[,2]

# Test set AUC 
ROCRpred = prediction(pred.prob, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
testPred = predict(tree, newdata=test)
testPred.prob = testPred[,2]
submission = data.frame(UserID = test$UserID, Probability1 = testPred.prob)
write.csv(submission, "./reports/CART.csv", row.names=FALSE) 
