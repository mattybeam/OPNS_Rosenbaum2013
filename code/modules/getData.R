makeData<-function(){
  assembly.count<-12
  competetor.count<-4
  data.frame(
    x=runif(assembly.count),
    y=runif(assembly.count)
  ) %>%
    saveRDS(paste0(varSave, 'assembly.rds'))
  data.frame(
    x=runif(competetor.count),
    y=runif(competetor.count)
  ) %>%
    saveRDS(paste0(varSave, 'competetor.rds'))
  data.frame(
    distance=10,
    union=2
  ) %>%
    saveRDS(paste0(varSave, 'costParameters.rds'))
  saveRDS(function(x, y) (x-1/2)^2+(y/4)^2, paste0(varSave, 'unionizationRate.rds'))
}

load.variables<-function(){
  list(
    assemblers = readRDS(paste0(varSave, 'assembly.rds')), 
    competetors = readRDS(paste0(varSave, 'competetor.rds')),
    unionRate = readRDS(paste0(varSave, 'unionizationRate.rds')), 
    costParam = readRDS(paste0(varSave, 'costParameters.rds'))
  )  
}