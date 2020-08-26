# Support Vector Machines

In this exercise, the goal is to predict whether a debtor will fully pay back his/her loan, based on other variables such as purpose of the loan, interest rate, debt/income ratio, FICO score, among others.

After some adjustement of kernel parameters, the training model is very accurate but the test data set is harder to predict accurately.
The model is too conservative as flagging individuals as being at risk of not paying back the loan fully (the inverse error happens much more rarely).
Thus, bad model: We would rather erroneously flag someone as "might not pay back the loan" versus give a loan to someone and later be surprised that he/she won't pay it back.

*Train data set*
   
 | |0   |1  |
 |-|----|---|
 |0|5582|0  |
 |1|650 |427|
  
  *Test data set*
 | |0   |1 |
 |-|----|--|
 |0|2405|58|
 |1|423 |33|
  
