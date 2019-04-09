# B - RANDOM FOREST

library(randomForest)
library(arm)
library(Matching)
library(tree)


#B1 - Random Forest
forest <- randomForest(re78 ~ treat + age + educ + black + nodegr + re75, data=lalonde, importance=TRUE)
forest
#Number of trees: 500
#No. of variables tried at each split: 2
#Mean of squared residuals: 46736401
#% Var explained: -6.51
#Analysis: even as importance is set to TRUE, performance does not increase much
#          model performs worse than randomly guessing



#random forest for highschool grads (lalonde_degr, lalonde_nodegr)
forest_degr <- randomForest(re78 ~ treat + age + educ + black + nodegr + re75, data = lalonde_degr, importance = TRUE)
forest_degr
# %Var explained: -3.15

#random forest for non highschool grads
forest_nodegr <- randomForest(re78 ~ treat + age + educ + black + nodegr + re75, data = lalonde_nodegr, importance = TRUE)
forest_nodegr
# %Var explained: -6.71


#B2 - Counterfactuals
#predict counterfactuals by predicting the opposite of the observed
#to do this, assign the same individual the opposite treatment and predict response

#predict counterfactuals for highschool grads
View(lalonde_degr)
lalonde_degr$treat.inv <- ifelse(lalonde_degr$treat==1, 0, 1)
forest_degr_inv <- randomForest(re78 ~ treat.inv + age + educ + black + nodegr + re75, data = lalonde_degr, importance = TRUE)
lalonde_degr$pred.re78 <- predict(forest_degr_inv)

#predict counterfactuals for no highschool grads
View(lalonde_nodegr)
lalonde_nodegr$treat.inv <- ifelse(lalonde_nodegr$treat==1, 0, 1)
forest_nodegr_inv <- randomForest(re78 ~ treat.inv + age + educ + black + nodegr + re75, data = lalonde_nodegr, importance = TRUE)
lalonde_nodegr$pred.re78 <- predict(forest_nodegr_inv)


#B3 - Average Treatment Effect
#calculate average treatment effect of high school grads
# predicted Y(0), known Y(1)
effect1 <- mean(lalonde_degr$re78[ which(lalonde_degr$treat==1)]) - mean(lalonde_degr$pred.re78[ which(lalonde_degr$treat.inv == 0)])
effect1 #209
# known Y(0), predicted Y(1)
effect2 <- mean(lalonde_degr$pred.re78[ which(lalonde_degr$treat.inv==1)]) - mean(lalonde_degr$re78[ which(lalonde_degr$treat == 0)])
effect2 #649

tmt.effect.degr1 <- mean(effect1+effect2)
tmt.effect.degr1 #858

#calculate average treatment effect of no high school grads
# predicted Y(0), known Y(1)
effect3 <- mean(lalonde_nodegr$re78[ which(lalonde_nodegr$treat==1)]) - mean(lalonde_nodegr$pred.re78[ which(lalonde_nodegr$treat.inv == 0)])
effect3 #71
# known Y(0), predicted Y(1)
effect4 <- mean(lalonde_nodegr$pred.re78[ which(lalonde_nodegr$treat.inv==1)]) - mean(lalonde_nodegr$re78[ which(lalonde_nodegr$treat == 0)])
effect4 #137

tmt.effect.nodegr1 <- mean(effect3+effect4)
tmt.effect.nodegr1 #208

#Analysis: treatment effect on those with high school degree is larger


#B4 - Importance Measure
importance(forest, type=1)
varImpPlot(forest, type = 1)
#using %IncMSE is unbiased, as opposed to IncNodePurity
#Analysis: black is most important, as changing it randomply would
#         increase MSE by almost 10%, showing how much it influences the data
