# function corr
# This function takes a directory that has csv files to read in, a threshold which is the
# used to control how many complete samples are required.  only montors that have a
# number of completes greater than the threshold will be used in the correlation calculation
# returns a vector of correlations
# Norm Zeck
#
corr <- function(directory, threshold = 0) {
  specFnames <- list.files(directory, full.names = TRUE)  # get a list of files in the directory
  
  specData.list <- lapply(specFnames, read.csv)  # read in data from files in id range
  nfiles <- length(specData.list)   #generalize to any number of files per id arg
  numtrue <- rep(0, nfiles)  # initialize number of complete (non NA) readings
  #idnum <- rep(0,nfiles)     # initialize ID array
  numabove <- 0              # number of monitors above threshold
  corvec <- rep(0,nfiles)    # init correlation vector - note will only return a subset
  #loop to get number of complete readings and ID number
  for(i in 1:nfiles) {
    my2 <- do.call(rbind.data.frame, specData.list[i])  # get data into frame
    #vector where both readispngs are not NA=true
    tvec <- !is.na(my2["sulfate"]) & !is.na(my2["nitrate"])
    #True value is a 1, false 0, so sum will give us the number of trues
    numtrue[i] <- sum(tvec)
    if(numtrue[i] > threshold) {
      numabove <- numabove + 1  #increment number above threshold
      #idnum[numabove] <- i      #save monitor index
      xcorr <- my2["sulfate"][tvec]  # subset completes
      ycorr <- my2["nitrate"][tvec]  # subset completes
      corvec[numabove] <- cor(xcorr, ycorr)
    }
  }
  # check results, return vector ID,number of complete or vector of length 0 if no completes
  # were found
  if(numabove > 0) {
    return(corvec[1:numabove])
  } else {
    x <- vector(mode="numeric", length=0)
    return (x)
  } 
}
