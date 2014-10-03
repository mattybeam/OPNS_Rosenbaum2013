#Coding assignment based on the counterfactual analysis of Rosenbaum (2013):
#Construct the findBestLocation() function, which identifies the optimal foreign-owned supplier locations, given the location of the domestic-owned suppliers. 
#Let the expected cost of a supplier satesfying an assembly plant be a linear function of the union rate and the distance between the supplier and assembly plant. beta gives these multiplicative constants.

source('header.R')
# makeData()
my.vars <- load.variables()
findBestLocation(
  numSites = 6,
  assemblers = my.vars$assemblers,
  competetors = my.vars$competetors,
  unionRate = my.vars$unionRate,
  beta = my.vars$costParam
) %>%   
  saveRDS('solution.rds')
  
  
