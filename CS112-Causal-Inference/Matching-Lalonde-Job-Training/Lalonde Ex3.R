# C - FISHER'S EXACT TEST


#C1 - Sharp Null Hypothesis
# treatment = 0, there is no treatment effect for treat or control group


#C2 - Test Statistic
#difference in means, means(treat)-means(control) for either degree group


#C3 - Observed Test Statistic
lalonde.fet <- lalonde[,c("treat", "re78")]
treat <- lalonde.fet[ which(lalonde.fet$treat==1), ]
control <- lalonde.fet[ which(lalonde.fet$treat==0), ]
observed.diff.means <- mean(treat$re78) - mean(control$re78)
observed.diff.means # = tmt.effect = 1794


#C4 - Missing Potential Outcomes
# fill in missing potential outcomes under sharp null (no effect) 
# -->  same values as observed potential outcomes
lalonde.fet$Y0 <- lalonde.fet$re78
lalonde.fet$Y1 <- lalonde.fet$re78

#C5 - Assignment Test Statistics
# for each possible assignment, calculate value of test statistic
# since the amount of combinations would exceed computing power, we approximate
# the Fisher's test by randomly assigning 0 and 1s, according to their propensities.
# (probabilites of occurring)

nrow(lalonde[ which(lalonde$treat==1), ]) #185
nrow(lalonde[ which(lalonde$treat==0), ]) #260

storage.vector <- NA
experiment <- function(vector.of.probabilities = NULL) {
  k = 0
  for (i in 1:length(vector.of.probabilities)) {
    if(
      sample(x = c(1,0), size = 1, prob = c(vector.of.probabilities[i], 
                                            1 - vector.of.probabilities[i])) == 1) {
      storage.vector[k] <- i
      k = k + 1
    }
  }
  return(list(treated.units = storage.vector, 
              control.units = (1:(length(vector.of.probabilities)))[-storage.vector]))
}

means <- function(x){
  results <- rep(0,x)
  for (i in 1:x){
    assig <- c(rep(1,185), rep(0,260))
    rand_assig <- sample(assig, 445, replace=FALSE)
    f_test <- experiment(rand_assig)
    results[i] <- mean(lalonde[f_test$treated.units,]$re78) - mean(lalonde[f_test$control.units,]$re78)
  }
  return(results)
}
diff_means <- means(10000)


#C6 - P-Value Calculation
# probability of being equal to or more extreme than the observation

p_value_function <- function(x) {
  count=0
  for (i in 1:x) {
    if(diff_means[i] > effect) {
      count=count + 1
    }
  }
  return(count/x)
}

# plot histogram
p_value <- p_value_function(length(diff_means))    #0.0022
p_value
hist(diff_means)
quantile(diff_means, prob=c(0.025, 0.975))    #-1295.545, 1250.011 
abline(v=p_value, lwd=2, col="green")
lower_bound <- quantile(diff_means, prob = c(0.025, 0.975))[1]
upper_bound <- quantile(diff_means, prob = c(0.025, 0.975))[2]

#plot density curve 
plot(density(diff_means))
abline(v = lower_bound, lwd = 2, col = "red")
abline(v = upper_bound, lwd = 2, col = "red")
abline(v = observed.diff.means, lwd = 2, col = "green") #1794
text(lower_bound, "lower_bound", col = "red") 
