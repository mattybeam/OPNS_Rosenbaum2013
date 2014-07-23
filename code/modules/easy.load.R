easy.load<-function(file.name){
  load(paste0(varSave, file.name))
  rm(file.name)
  get(ls()[1])
}

easy.save<-function(d, file.name) save(d, file=paste0(varSave, file.name))

