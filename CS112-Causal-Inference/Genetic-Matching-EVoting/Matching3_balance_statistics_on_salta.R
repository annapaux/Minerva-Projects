#Table 2 - MatchBalance p-value comparison

#MatchIt p-values from Table 2 (page 128)

#Match p-values
matching <- Match(Tr=Tr, X=X1, caliper=0.05)
summary(matching)
matchbalance <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                               age.group:educ + age.group:tech + educ + I(educ^2) + 
                               tech + I(tech^2) + pol.info + educ:pol.info + 
                               age.group:pol.info + tech:pol.info + white.collar + 
                               not.full.time + male, data=datamatch,
                             match.out=matching,nboots=8000)

#GenMatch p-values
balance <- GenMatch(Tr=Tr,X=X2,BalanceMatrix=X2, pop.size = 500, caliper=0.05)
gen_matching <- Match(Tr=Tr,X=X2,Weight.matrix = balance,caliper=0.05)
summary(gen_matching)
gen_matchbalance <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                   age.group:educ + age.group:tech + educ + I(educ^2) + 
                                   tech + I(tech^2) + pol.info + educ:pol.info + 
                                   age.group:pol.info + tech:pol.info + white.collar + 
                                   not.full.time + male, data=datamatch,
                                 match.out=gen_matching,nboots=8000)

p_scores_for_matchbalance <- matrix(c(
  '0.55', '1.00', '0.53', '0.04', '1.00',
  '0.00', '0.72', '0.00', '0.06', '1.00',
  '0.29', '0.80', '0.60', '0.59', '1.00',
  '0.02', '0.80', '0.05', '0.29', '1.00',
  '0.87', '1.00', '0.75', '0.33', '1.00',
  '0.00', '0.59', '0.01', '0.05', '1.00',
  '0.00', '0.55', '0.00', '0.62', '1.00'),
  ncol=5, byrow=TRUE)

colnames(p_scores_for_matchbalance) <- c(
  "MatchIt BM", "MatchIt AM", "Gen/Match BM", "Match AM", "GenMatch AM")
rownames(p_scores_for_matchbalance) <- c(
  "Age group",
  "Education",
  "White collar",
  "Not full time worker",
  "Male",
  "Technology count",
  "Political information")

p_scores_for_matchbalance <- as.table(p_scores_for_matchbalance, justify = "centre")
p_scores_for_matchbalance

#NOTES: 
   #Kolmogorov-Smirnov -Bootstrap p-value for ordinal variables
   #T-test p-value for binary variables












## ADDITIONS FOR OUTCOME Y8: CONFIDENCE IN VOTING SECRECY

#EXTEND_1: Genetic matching for propensity score + covariates
#Balancematrix
X2_plus_pscores <- cbind(glm1$fitted, datamatch$age.group, datamatch$educ, 
                         datamatch$tech, datamatch$pol.info, datamatch$white.collar, 
                         datamatch$not.full.time, datamatch$male)
# balance_1 <- GenMatch(Tr=Tr,X=X2,BalanceMatrix=X2, pop.size = 500)

#Reminder:
# X2 <- cbind(datamatch$age.group, datamatch$educ, datamatch$tech, datamatch$pol.info, datamatch$white.collar, datamatch$not.full.time, datamatch$male)
# Tr <- datamatch$EV
# Y1 <- datamatch$eval.voting (etc.)
Gen_Advanced1 <- GenMatch(Tr = Tr, X=X2_plus_pscores, BalanceMatrix = X2, pop.size=500)
Match_Advanced1 <- Match(Y=Y8, Tr = Tr, X = X2_plus_pscores, Weight.matrix = Gen_Advanced)
summary(Match_Advanced1)
mb_adv_1 <- MatchBalance(EV ~ age.group + educ + tech + pol.info + white.collar + not.full.time + male, 
                         data=datamatch, match.out = Match_Advanced1, nboots=500)
#p-value: .426

#EXTEND_2: Changing M
# M = 2 means more data retained; std errors should be smaller, p-values also
#you would ordinarily get lower balance but also more likelihood that the 
#STANDARD ERRORS ASSOCIAED WITH THE TREATMENT EFFECT ARE SMALL AND GIVING YOU 
#STATISTICAL SIGNIFICANCE (because your effective sample size is larger).

Gen_Advanced2 <- GenMatch(Tr = Tr, X=X2_plus_pscores, BalanceMatrix = X2, pop.size=500, M = 2)
Match_Advanced2 <- Match(Y=Y8, Tr = Tr, X = X2_plus_pscores, Weight.matrix = Gen_Advanced2, M = 2)
summary(Match_Advanced2)
#standard error: 0.0354 (vs 0.0369 from match_Advanced1)
mb_adv_2 <- MatchBalance(EV ~ age.group + educ + tech + pol.info + white.collar + not.full.time + male, 
                         data=datamatch, match.out = Match_Advanced2, nboots=500)
#p-value: .404 


#EXTEND_3: exact matching for white.collar (because wealth influences most?)
# potentially come up with a better variable
exact.matching <- rep(0, 8)
exact.matching[6] <- 1 #white.collar is 6th item

Gen_Advanced3 <- GenMatch(Tr = Tr, X=X2_plus_pscores, BalanceMatrix = X2, pop.size=500, exact = exact.matching)
Match_Advanced3 <- Match(Y=Y8, Tr = Tr, X = X2_plus_pscores, Weight.matrix = Gen_Advanced3, exact = exact.matching)
summary(Match_Advanced3)
#0 dropped because of 'exact' or 'caliper' (??)
mb_adv_3 <- MatchBalance(EV ~ age.group + educ + tech + pol.info + white.collar + not.full.time + male, 
                         data=datamatch, match.out = Match_Advanced3, nboots=500)
#p-value: 0.62



#EXTEND_4: caliper matching for tech and white.collar
# potentially come up with a better variable
caliper.vector <- rep(0, 8)
caliper.vector[4] <- 0.01
caliper.vector[6] <- 0.01 #white.collar is 6th item

Gen_Advanced4 <- GenMatch(Tr = Tr, X=X2_plus_pscores, BalanceMatrix = X2, pop.size=500, caliper = caliper.vector)
Match_Advanced4 <- Match(Y=Y8, Tr = Tr, X = X2_plus_pscores, Weight.matrix = Gen_Advanced4, caliper = caliper.vector)
summary(Match_Advanced4)
#366 dropped because of 'exact' or 'caliper' (??)
mb_adv_4 <- MatchBalance(EV ~ age.group + educ + tech + pol.info + white.collar + not.full.time + male, 
                         data=datamatch, match.out = Match_Advanced4, nboots=500)
#p-value: 1