# Preprocessing script.

train = read.csv("./data/train.csv", na.strings = "")
test = read.csv("./data/test.csv", na.strings = "")

## Clean up YOB
train$YOB = destring(as.character(train$YOB))
train$YOB = as.numeric(train$YOB)
test$YOB = destring(as.character(test$YOB))
test$YOB = as.numeric(test$YOB)

## Clean up Income
incomeLevels = 
  c("under $25,000", "$25,001 - $50,000", "$50,000 - $74,999", 
    "$75,000 - $100,000", "$100,001 - $150,000", "over $150,000")

train$Income = factor(train$Income,levels=incomeLevels,ordered=TRUE)
test$Income = factor(test$Income,levels=incomeLevels,ordered=TRUE)

## Clean up EducationLevel.
educationLevels = 
  c("Current K-12", "High School Diploma", "Current Undergraduate", 
    "Associate's Degree", "Bachelor's Degree", "Master's Degree", 
    "Doctoral Degree")

train$EducationLevel = 
  factor(train$EducationLevel,levels=educationLevels,ordered=TRUE)
test$EducationLevel = 
  factor(test$EducationLevel, levels=educationLevels, ordered=TRUE)

# Multiple imputation
imputationColumns = 
  c("YOB", "Gender", "Income", "HouseholdStatus", "EducationLevel", "Party", "votes", "Q124742", "Q124122", "Q123464", "Q123621",        
    "Q122769", "Q122770", "Q122771", "Q122120",       
    "Q121699", "Q121700", "Q120978", "Q121011",       
    "Q120379", "Q120650", "Q120472", "Q120194",       
    "Q120012", "Q120014", "Q119334", "Q119851",       
    "Q119650", "Q118892", "Q118117", "Q118232",       
    "Q118233", "Q118237", "Q117186", "Q117193",       
    "Q116797", "Q116881", "Q116953", "Q116601",       
    "Q116441", "Q116448", "Q116197", "Q115602",       
    "Q115777", "Q115610", "Q115611", "Q115899",       
    "Q115390", "Q114961", "Q114748", "Q115195",       
    "Q114517", "Q114386", "Q113992", "Q114152",       
    "Q113583", "Q113584", "Q113181", "Q112478",       
    "Q112512", "Q112270", "Q111848", "Q111580",       
    "Q111220", "Q110740", "Q109367", "Q108950",       
    "Q109244", "Q108855", "Q108617", "Q108856",       
    "Q108754", "Q108342", "Q108343", "Q107869",       
    "Q107491", "Q106993", "Q106997", "Q106272",       
    "Q106388", "Q106389", "Q106042", "Q105840",       
    "Q105655", "Q104996", "Q103293", "Q102906",       
    "Q102674", "Q102687", "Q102289", "Q102089",       
    "Q101162", "Q101163", "Q101596", "Q100689",       
    "Q100680", "Q100562", "Q99982",  "Q100010",       
    "Q99716",  "Q99581",  "Q99480",  "Q98869",
    "Q98578",  "Q98059",  "Q98078",  "Q98197", 
    "Q96024")

all = rbind(train[-c(8)], test)
simple = all[imputationColumns]
set.seed(144)
imputed = complete(mice(simple))

for (column in imputationColumns) {
  train[, column] = imputed[1:nrow(train), column]
  test[, column] = imputed[(nrow(train) + 1):nrow(all), column]
}

# Randomly split the data into training and testing sets
set.seed(1000)
split = sample.split(train$Happy, SplitRatio = 0.65)

# Split up the data using subset
trainTrain = subset(train, split==TRUE)
trainTest = subset(train, split==FALSE)
