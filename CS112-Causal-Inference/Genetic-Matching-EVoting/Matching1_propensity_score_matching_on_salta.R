#Propensity score matching
library(Matching) #Loading the matching library


load("datamatch.Rdata") #loading the numerically encoded data set

datamatch[datamatch == 99999] <- NA
datamatch <- na.omit(datamatch)

#Estimating the propensity score model #look into the choice of independent variables
glm1 <- glm(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
              age.group:educ + age.group:tech + educ + I(educ^2) + 
              tech + I(tech^2) + pol.info + educ:pol.info + 
              age.group:pol.info + tech:pol.info + white.collar + 
              not.full.time + male, data = datamatch)

summary(glm1)
#saves the data objects from our propensity model and data set
X1 <- glm1$fitted #propensity model for propensity score matching
#outcomes from survey
Y1<- datamatch$eval.voting #evaluation of voting experience
Y2<- datamatch$capable.auth #Qualification of poll workers
Y3<- datamatch$agree.evoting #Agree with the substitution of TV by EV
Y4<- datamatch$speed #Speed of voting process
Y5<- datamatch$easy.voting #Difficulty of voting experience
Y6<- datamatch$eselect.cand #Prefer to select candidates electronically
Y7<- datamatch$sure.counted #Sure vote was counted
Y8<- datamatch$conf.secret #Confident in ballot secrecy
Y9<- datamatch$how.clean #Cleanliness of the Salta elections
#Treatment assignment indicator
Tr <- datamatch$EV 

#Matching on all the different outcomes (what type do I do? nearest neightbor. One-on-one (this is default, M=1)? with or without replacement?)
matching_1 <- Match(Y=Y1,Tr=Tr, X=X1, caliper=0.05)
summary(matching_1)
matching_2 <- Match(Y=Y2,Tr=Tr, X=X1, caliper=0.05)
summary(matching_2)
matching_3 <- Match(Y=Y3,Tr=Tr, X=X1, caliper=0.05)
summary(matching_3)
matching_4 <- Match(Y=Y4,Tr=Tr, X=X1, caliper=0.05)
summary(matching_4)
matching_5 <- Match(Y=Y5,Tr=Tr, X=X1, caliper=0.05)
summary(matching_5)
matching_6 <- Match(Y=Y6,Tr=Tr, X=X1, caliper=0.05)
summary(matching_6)
matching_7 <- Match(Y=Y7,Tr=Tr, X=X1, caliper=0.05)
summary(matching_7)
matching_8 <- Match(Y=Y8,Tr=Tr, X=X1, caliper=0.05)
summary(matching_8)
matching_9 <- Match(Y=Y9,Tr=Tr, X=X1, caliper=0.05)
summary(matching_9)


#Checking the matchbalance
matchbalance_1 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_1,nboot=500)

matchbalance_2 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_2,nboot=500)

matchbalance_3 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_3,nboot=500)

matchbalance_4 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_4,nboot=500)

matchbalance_5 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_5,nboot=500)

matchbalance_6 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_6,nboot=500)

matchbalance_7 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_7,nboot=500)

matchbalance_8 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_8,nboot=500)

matchbalance_9 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=matching_9,nboot=500)

#Figure out how to put all the outcomes in a table, kind of like they did in the study. 
#replicate confintervals etc


#Table creation: Comparison to table A$, effect of E-voting from appendix 4.
names(matching_1) #checking where the different information in the summary is located

effect_evoting_table_matching <- matrix(c(matching_6$est,matching_6$se,matching_6$est-matching_6$se*1.96,matching_6$est+matching_6$se*1.96,
                                 matching_1$est,matching_1$se,matching_1$est-matching_1$se*1.96,matching_1$est+matching_1$se*1.96,
                                 matching_3$est,matching_3$se,matching_3$est-matching_3$se*1.96,matching_3$est+matching_3$se*1.96,
                                 matching_5$est,matching_5$se,matching_5$est-matching_5$se*1.96,matching_5$est+matching_5$se*1.96,
                                 matching_9$est,matching_9$se,matching_9$est-matching_9$se*1.96,matching_9$est+matching_9$se*1.96,
                                 matching_2$est,matching_2$se,matching_2$est-matching_2$se*1.96,matching_2$est+matching_2$se*1.96,
                                 matching_7$est,matching_7$se,matching_7$est-matching_7$se*1.96,matching_7$est+matching_7$se*1.96,
                                 matching_4$est,matching_4$se,matching_4$est-matching_4$se*1.96,matching_4$est+matching_4$se*1.96,
                                 matching_8$est,matching_8$se,matching_8$est-matching_8$se*1.96,matching_8$est+matching_8$se*1.96),
                               ncol=4,byrow=TRUE)

colnames(effect_evoting_table_matching) <- c("Mean","Standard Deviation","Conf.int 5%", "Conf.int 95%")
rownames(effect_evoting_table_matching) <- c("Select candidates electronically","Evaluation voting experience",
                                    "Agree substitute TV by EV","Difficulty voting experience",
                                    "Elections in Salta are clean","Qualification of poll workers",
                                    "Sure vote was counted","Speed of voting process","Confident ballot secret")

effect_evoting_table_matching <- as.table(effect_evoting_table_matching)
effect_evoting_table_matching
