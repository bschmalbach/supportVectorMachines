library(e1071)


#iris data set

df <- iris

#randomly split data 70/30
split <- sample(c(TRUE, FALSE), nrow(df), replace=TRUE, prob=c(0.7, 0.3))
df_train <- df[split,]
df_test <- df[!split,]

#intial model

model <- svm(Species ~ ., data = df_train)
summary(model)

df_train$pred <- predict(model, df_train)
table(df_train$Species, df_train$pred) #accuracy = 97%

df_test$pred <- predict(model, df_test)
table(df_test$Species, df_test$pred) #accuracy = 96%


#############################################################################
#############################################################################

#loan data set

rm(list=ls())
df <- read.csv("loan_data.csv")
table(df$not.fully.paid)

#convert to factor
df$credit.policy <- as.factor(df$credit.policy)
df$inq.last.6mths <- as.factor(df$inq.last.6mths)
df$delinq.2yrs <- as.factor(df$delinq.2yrs)
df$pub.rec <- as.factor(df$pub.rec)
df$not.fully.paid <- as.factor(df$not.fully.paid)
  
set.seed(1)
split <- sample(c(TRUE, FALSE), nrow(df), replace=TRUE, prob=c(0.7, 0.3))
df_train <- df[split,]
df_test <- df[!split,]

model <- svm(not.fully.paid ~ ., data = df_train)
summary(model)

train_pred <- predict(model, df_train)
table(df_train$not.fully.paid, train_pred)
(5582+0)/sum(table(df_train$not.fully.paid, train_pred)) #accuracy = 84%

test_pred <- predict(model, df_test)
table(df_test$not.fully.paid, test_pred)
(2463+0)/sum(table(df_test$not.fully.paid, test_pred)) #accuracy = 84%

#accuracy is pretty bad, model misses all of those who do not pay it back fully



#optimize parameters

model <- svm(not.fully.paid ~ ., data = df_train, cost=5, gamma=0.5)
summary(model)

train_pred <- predict(model, df_train)
table(df_train$not.fully.paid, train_pred)
(5582+949)/sum(table(df_train$not.fully.paid, train_pred)) #accuracy = 98%

test_pred <- predict(model, df_test)
table(df_test$not.fully.paid, test_pred)
(2340+38)/sum(table(df_test$not.fully.paid, test_pred)) #accuracy = 81%

#model is much better in training, but not in testing


#use tuning function to get better kernel parameters

tuned <- tune(svm, train.x = not.fully.paid ~ ., data = df_train,
              kernel="radial", ranges=list(cost=c(0.1, 1, 10), gamma=c(0.1, 1, 10))) #cost=10 gamma=0.1

summary(tuned)


#small gamma helps

model <- svm(not.fully.paid ~ ., data = df_train, cost=10, gamma=0.1)
summary(model)

train_pred <- predict(model, df_train)
table(df_train$not.fully.paid, train_pred)
(5576+375)/sum(table(df_train$not.fully.paid, train_pred)) #accuracy = 90%

test_pred <- predict(model, df_test)
table(df_test$not.fully.paid, test_pred)
(2405+33)/sum(table(df_test$not.fully.paid, test_pred)) #accuracy = 84%

#slight improvement in test prediction with sizable decrease in training performance
#more tuning needed, but computer so slow



