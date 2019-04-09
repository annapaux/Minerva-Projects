# JOB SKILL TRAINING LALONDE

library(Matching)
data(lalonde)
View(lalonde)

# A - MULTIVARIATE REGRESSION


# A1 - Multivariate Regression
reg.original <- lm(formula = re78 ~ treat + age + educ + black + hisp + married + nodegr + re74 + re75 + u74 + u75, data = lalonde)
summary(reg.original)

reg.use <- lm(formula = re78 ~ treat + age + educ + black + nodegr + re75, data = lalonde)
reg.use
summary(reg.use)

#Coefficients:
#  Estimate Std. Error t value Pr(>|t|)   
#(Intercept)  1.294e+03  3.176e+03   0.407  0.68397   
#treat        1.630e+03  6.341e+02   2.570  0.01049 * 
#age          5.047e+01  4.414e+01   1.143  0.25348   
#educ         3.764e+02  2.251e+02   1.672  0.09520 . 
#black       -2.180e+03  8.384e+02  -2.600  0.00963 **
#nodegr      -2.128e+02  9.912e+02  -0.215  0.83010   
#re75         1.420e-01  9.855e-02   1.440  0.15045   
#Residual standard error: 6500 on 438 degrees of freedom
#Multiple R-squared:  0.0523,	Adjusted R-squared:  0.03931 
#F-statistic: 4.028 on 6 and 438 DF,  p-value: 0.0006098

#Analysis: very low R-squared, little of the variance is explained, poor model performance
#F-statistic: 4>1, and p-value<0.05
#we can reject null hypothesis of no relationship, at least one of the variables affects re78


# A2 - Confidence Interval
CI <- function(estimate, std_error) {
  lb=estimate-std_error
  ub=estimate+std_error
  return(list(lb,ub))
}
CI(1629.9660134, 634)
# CI = (996, 2264)
#Analysis: the spread from the estimate is very large, 95% confident the real predictor is between 996 and 2264

# on subgroup: married
lm(formula = re78 ~ age + educ + black + nodegr + re75, lalonde, subset = married == 1)


# A3 - Interaction Terms
lm(formula = re78 ~ treat*black, lalonde)
#(Intercept)        treat        black  treat:black  
#  6691.2        802.8      -2583.5       1225.9  
#Analysis: pos interaction term indicates treatment has stronger effects
#          on black than non-black

lm(formula = re78 ~ black*nodegr, lalonde)
#(Intercept)         black        nodegr  black:nodegr  
#    7789.8       -1440.4       -1054.8        -703.6  
#Analysis: nonlinear relationship
#          being both black and having no degree decreases estimated re78 by another $703.6

lm(formula = re78 ~ black*educ, lalonde)
#(Intercept)        black         educ   black:educ  
#     3008.72     -2770.38       399.17        62.37
#Analysis: nonlinear relationship
#          being black only decreases the estimate, higher education increases the estimate
#          a positive interaction term means educ has stronger effects on black than not black

lm(formula = re78 ~ treat*nodegr, lalonde)
#(Intercept)         treat        nodegr  treat:nodegr  
#     4854.5        3192.0        -359.1       -2038.0  
#Analysis: nonlinear relationship
#          receiving treatment increases estimate, no degree decreases the estimate
#          no treat, degree: 4854
#          no treat, no degree: 4495 (=4854-359)
#          treat, degree: 8046 (=4854+3192)
#          treat, no degree: 5649 (=4854+3192-359-2038)
#          8046 > 5649 --> treatment effect is larger for those with degree


#A4 - Estimated Treatment Effects
tmt.effect <- mean(lalonde$re78[lalonde$treat == 1]) - mean(lalonde$re78[lalonde$treat == 0])
tmt.effect #1794.343

#begin: data prep#
elimin.cols <- which(  names(lalonde) == "hisp" | 
                         names(lalonde) == "married"|
                         names(lalonde) == "re74"|
                         names(lalonde) == "u74"|
                         names(lalonde) == "u75")
lalonde_nodegr <-  lalonde[which(lalonde$nodegr == 1),]
lalonde_nodegr <-  lalonde_nodegr[, -elimin.cols]
lalonde_degr <-  lalonde[which(lalonde$nodegr == 0),]
lalonde_degr <-  lalonde_degr[, -elimin.cols]
#end: data prep#

tmt.effect.nodegr <- mean(lalonde_nodegr$re78[lalonde_nodegr$treat == 1]) - mean(lalonde_nodegr$re78[lalonde.nodegr$treat == 0])
tmt.effect.degr <- mean(lalonde_degr$re78[lalonde_degr$treat == 1]) - mean(lalonde_degr$re78[lalonde_degr$treat == 0])

tmt.effect.nodegr #1154.048
tmt.effect.degr #3192.026

