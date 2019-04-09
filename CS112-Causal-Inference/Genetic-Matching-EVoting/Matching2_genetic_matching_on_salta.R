#GENETIC MATCHING
library(Matching) #Loading the matching library
library(rgenoud) #For genetic matching

load("datamatch.Rdata") #loading the numerically encoded data set

datamatch[datamatch == 99999] <- NA
datamatch <- na.omit(datamatch)

#Balancematrix
Z <- cbind(datamatch$age.group + I(datamatch$age.group^2) + I(datamatch$age.group^3) + 
             datamatch$age.group:datamatch$educ + datamatch$age.group:datamatch$tech + datamatch$educ + I(datamatch$educ^2) + 
             datamatch$tech + I(datamatch$tech^2) + datamatch$pol.info + datamatch$educ:datamatch$pol.info + 
             datamatch$age.group:datamatch$pol.info + datamatch$tech:datamatch$pol.info + datamatch$white.collar + 
             datamatch$not.full.time + datamatch$male)

#variables for genetic matching (Do I include propensity scores? / Check what variables they included. Using the same as the matchbalance variables?)
X2 <- cbind(datamatch$age.group, datamatch$educ, datamatch$tech, datamatch$pol.info, datamatch$white.collar, datamatch$not.full.time, datamatch$male)
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

balance_1 <- GenMatch(Tr=Tr,X=X2,BalanceMatrix=Z)

gen_matching_1 <- Match(Y=Y1,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_1)
gen_matching_2 <- Match(Y=Y2,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_2)
gen_matching_3 <- Match(Y=Y3,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_3)
gen_matching_4 <- Match(Y=Y4,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_4)
gen_matching_5 <- Match(Y=Y5,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_5)
gen_matching_6 <- Match(Y=Y6,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_6)
gen_matching_7 <- Match(Y=Y7,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_7)
gen_matching_8 <- Match(Y=Y8,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_8)
gen_matching_9 <- Match(Y=Y9,Tr=Tr,X=X2,Weight.matrix = balance_1,caliper=0.05)
summary(gen_matching_9)

#Checking the matchbalance
gen_matchbalance_1 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_1,nboot=500)

gen_matchbalance_2 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_2,nboot=500)

gen_matchbalance_3 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_3,nboot=500)

gen_matchbalance_4 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_4,nboot=500)

gen_matchbalance_5 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_5,nboot=500)

gen_matchbalance_6 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_6,nboot=500)

gen_matchbalance_7 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_7,nboot=500)

gen_matchbalance_8 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_8,nboot=500)

gen_matchbalance_9 <- MatchBalance(EV ~ age.group + I(age.group^2) + I(age.group^3) + 
                                 age.group:educ + age.group:tech + educ + I(educ^2) + 
                                 tech + I(tech^2) + pol.info + educ:pol.info + 
                                 age.group:pol.info + tech:pol.info + white.collar + 
                                 not.full.time + male, data=datamatch,
                               match.out=gen_matching_9,nboot=500)


effect_evoting_table_gen_matching <- matrix(c(gen_matching_6$est,gen_matching_6$se,gen_matching_6$est-gen_matching_6$se*1.96,gen_matching_6$est+gen_matching_6$se*1.96,
                                              gen_matching_1$est,gen_matching_1$se,gen_matching_1$est-gen_matching_1$se*1.96,gen_matching_1$est+gen_matching_1$se*1.96,
                                              gen_matching_3$est,gen_matching_3$se,gen_matching_3$est-gen_matching_3$se*1.96,gen_matching_3$est+gen_matching_3$se*1.96,
                                              gen_matching_5$est,gen_matching_5$se,gen_matching_5$est-gen_matching_5$se*1.96,gen_matching_5$est+gen_matching_5$se*1.96,
                                              gen_matching_9$est,gen_matching_9$se,gen_matching_9$est-gen_matching_9$se*1.96,gen_matching_9$est+gen_matching_9$se*1.96,
                                              gen_matching_2$est,gen_matching_2$se,gen_matching_2$est-gen_matching_2$se*1.96,gen_matching_2$est+gen_matching_2$se*1.96,
                                              gen_matching_7$est,gen_matching_7$se,gen_matching_7$est-gen_matching_7$se*1.96,gen_matching_7$est+gen_matching_7$se*1.96,
                                              gen_matching_4$est,gen_matching_4$se,gen_matching_4$est-gen_matching_4$se*1.96,gen_matching_4$est+gen_matching_4$se*1.96,
                                              gen_matching_8$est,gen_matching_8$se,gen_matching_8$est-gen_matching_8$se*1.96,gen_matching_8$est+gen_matching_8$se*1.96),
                                        ncol=4,byrow=TRUE)

colnames(effect_evoting_table_gen_matching) <- c("Mean","Standard Deviation","Conf.int 5%", "Conf.int 95%")
rownames(effect_evoting_table_gen_matching) <- c("Select candidates electronically","Evaluation voting experience",
                                             "Agree substitute TV by EV","Difficulty voting experience",
                                             "Elections in Salta are clean","Qualification of poll workers",
                                             "Sure vote was counted","Speed of voting process","Confident ballot secret")

effect_evoting_table_gen_matching <- as.table(effect_evoting_table_gen_matching)
effect_evoting_table_gen_matching



