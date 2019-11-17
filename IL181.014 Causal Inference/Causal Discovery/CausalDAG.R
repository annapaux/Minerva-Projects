library("pcalg")
library("Rgraphviz")
library("readr")

df <- read_csv("FDA-Carpenter_clean.csv")

# create dag
# • Constraint-based assuming no hidden confounders, i.i.d.:
#   skeleton(), pc(), lingam()
# • Constraint-based, allowing hidden variables, i.i.d.:
#   fci(), rfci(), fciPlus()
# and more.

suffStat <- list(C = cor(df), n = nrow(df))
varNames <- names(df)
skel <- skeleton(suffStat, indepTest = gaussCItest,
                 labels = varNames, alpha = 0.01)

# alpha - 0.01
pc <- pc(suffStat, indepTest = gaussCItest,
         labels = varNames, alpha = 0.01)

plot(pc, labels=varNames, main="Inferred DAG for Carpenter")
# Error in plot.new() : figure margins too large
# > par("mar")
# [1] 5.1 4.1 4.1 2.1
# > par(mar=c(1,1,1,1))

summary(pc)

# alpha - 0.05
pc_1 <- pc(suffStat, indepTest = gaussCItest,
         labels = varNames, alpha = 0.5)
plot(pc_1, labels=varNames, main="Inferred DAG for Carpenter (alpha=0.5)")
