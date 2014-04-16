# CART

# Current AUC = 0.6587967/xxx

setwd("~/Dropbox/education/EdX/MITx/15.071x/kaggle-the-analytics-edge")
library('ProjectTemplate')
load.project()

# Let's use all the variables

# Create a CART model
tree = rpart(Happy ~ . - UserID, data=train)
prp(tree)

# Make predictions
tree.pred = predict(tree, newdata=trainTest)

# Test set AUC 
ROCRpred = prediction(tree.pred, trainTest$Happy)
as.numeric(performance(ROCRpred, "auc")@y.values)

# Make submission
testPred = predict(tree, newdata=test)
submission = data.frame(UserID = test$UserID, Probability1 = testPred)
write.csv(submission, "./submissions/CART.csv", row.names=FALSE) 
