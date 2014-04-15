# Preprocessing script.

# Convert Income to a numeric
incomeLevels = 
  c("", "under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")
allTrain$Income = factor(allTrain$Income,levels=incomeLevels,ordered=TRUE)
allTrain$Income = as.numeric(allTrain$Income)
test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)
test$Income = as.numeric(test$Income)

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(allTrain$Happy, SplitRatio = 0.65)

# Split up the data using subset
train = subset(allTrain, split==TRUE)
trainTest = subset(allTrain, split==FALSE)
