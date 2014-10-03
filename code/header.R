varSave<-'../variables/'
ex.mods<-'modules/'
.libPaths('/Users/robertbray/Dropbox/code/R/library/')
library('dplyr')
library('plyr')
library('doParallel')
registerDoParallel(cores=20)
l_ply(dir(ex.mods), function(l) source(paste(ex.mods, l, sep="")))
