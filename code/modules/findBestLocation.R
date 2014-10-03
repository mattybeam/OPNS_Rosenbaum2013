findBestLocation<-function(numSites, assemblers, competetors, unionRate, beta){
  #Inputs:
  #numSites is a scaler giving the number of supplier locations to find
  #assemblers is a data.frame with x and y locations of the auto assemblers
  #competetors is a data.frame with x and y locations of the domestic-owned suppliers, our competition
  #unionRate is a function that takes x and y as arguments and outputs the fraction of workforce that works in a union
  #beta is a data.frame with two elements, ``distance" and ``union". These are the linear cost parameters that determine how expensive it is for a given supplier to satesfy a given assembly plant
  #Output: a list containing:
  #(1) the minimum value
  #(2) the convergence status of the optimizer
  #(3) a data.frame containing the cost minimizing x and y values for the supplier locations
    
  C.bar<-function(assembly.loc, supplier.loc){
    distance = sqrt(sum((assembly.loc-supplier.loc)^2))
    unions = unionRate(supplier.loc$x, supplier.loc$y)
    beta$distance*distance+beta$union*unions    
  }
  
  expected.Nr<-function(assembly.loc, supplier.locs){
    alply(supplier.locs, 1, function(s) -C.bar(assembly.loc, s)) %>%
      unlist() %>%
      exp() %>%
      sum() %>%
      log() %>%
      prod(-1)
  }
  
  #minimize the sum of the expected Nr
  to.minimize<-function(supplier.loc.list){
    supplier.locs = matrix(supplier.loc.list, nc=2) %>%
      as.data.frame() %>%
      select(x=V1, y=V2) %>%
      rbind(as.matrix(competetors))
    alply(assemblers, 1, function(s) expected.Nr(s, supplier.locs)) %>%
      unlist() %>%
      sum()
  }
  
  #Try at several starting values in parallel, choose the one with the smallest value
  num.tries = 60
  best.run = llply(seq(num.tries), function(l) optim(runif(2*numSites), to.minimize, control=list(maxit=10000)), .parallel=T) %>%
    ldply(function(l) data.frame(val=l$value, convergence=l$convergence, par=rbind(l$par))) %>%
    filter(rank(val, ties.method="first")==1) 
  
  list(
    value=best.run$val,
    convergence=best.run$convergence,
    supplier.locs=select(best.run, -c(val, convergence)) %>%
      matrix(nc=2) %>%
      as.data.frame() %>%
      select(x=V1, y=V2)
  )  
}