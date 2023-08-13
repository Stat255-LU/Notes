library(tidycensus)
View(pums_variables %>% filter(year==2021))
data <- get_pums(variables = c("AGEP","SEX", "SCHL", "NP", "ACR", "BDSP", "LAPTOP", "RNTP", "VALP", "CPLT" , 
                               "FINCP", "HHL", "HHLDRAGEP", "HHLDRRAC1P", "HHT", "HINCP", "MULTG", "WORKSTAT"), state = "WI", survey = "acs1", rep_weights = "person")
Vars <- load_variables(year=2021, dataset= "acs1")
View(Vars)

library(ggplot2)
data(movies)

install.packages("ggplot2movies")
library(ggplot2movies)
data(movies)
dim(movies)
View(movies)


library(NHANES)
library(dplyr)
data(NHANES)




## approx. 20 seconds computation time
library(simPop)
data(eusilcS)
inp <- specifyInput(data=eusilcS, hhid="db030", hhsize="hsize", strata="db040", weight="db090") ## in the following, nr_cpus are selected automatically
simPop <- simStructure(data=inp, method="direct", basicHHvars=c("age", "rb090"))
simPop <- simCategorical(simPop, additional=c("pl030", "pb220a"), method="multinom", nr_cpus=1) 
simPop
class(simPop)
regModel = ~rb090+hsize+pl030+pb220a
## multinomial model with random draws
eusilcM <- simContinuous(simPop, additional="netIncome",
                         regModel = regModel,
                         upper=200000, equidist=FALSE, nr_cpus=1)
class(eusilcM)

data(simPop)
Data <- simPop@pop@data


#### Generate based on NHANES data
data(NHANES)
inp <- specifyInput(data=NHANES, hhid="ID", hhsize="hsize", strata="db040", weight=1)## in the following, nr_cpus are selected automatically
simPop <- simStructure(data=inp, method="direct")
simPop <- simCategorical(simPop, additional=c("pl030", "pb220a"), method="multinom", nr_cpus=1) 
simPop
class(simPop)
regModel = ~rb090+hsize+pl030+pb220a
## multinomial model with random draws
eusilcM <- simContinuous(simPop, additional="netIncome",
                         regModel = regModel,
                         upper=200000, equidist=FALSE, nr_cpus=1)
class(eusilcM)

Data <- simPop@pop@data