# function complete
# function takes a directory where csv files are loaded.  only monitors(files) that match the ID 
# arg are loaded. function then looks for samples that have both sulfate and nitrate
# returns a data frame that has the ID and number of complete samples.
# Norm Zeck
complete <- function(directory, id = 1:332) {
  specFnames <- list.files(directory, full.names = TRUE)  # get a list of files in the directory
  
  specData.list <- lapply(specFnames[id], read.csv)  # read in data from files in id range
  nfiles <- length(id)   #generalize to any number of files per id arg
  numtrue <- rep(0, nfiles)  # initialize number of complete (non NA) readings
  idnum <- rep(0,nfiles)     # initialize ID array
  #loop to get number of complete readings and ID number
  for(i in 1:nfiles) {
    my2 <- do.call(rbind.data.frame, specData.list[i])  # get data into frame
    #vector where both readispngs are not NA=true
    tvec <- !is.na(my2["sulfate"]) & !is.na(my2["nitrate"])
    #True value is a 1, false 0, so sum will give us the number of trues
    numtrue[i] <- sum(tvec)
    #record ID
    idnum[i] <- my2[1,"ID"]  #get an ID
  }
  df <- data.frame(idnum[1:nfiles], numtrue[1:nfiles])   #make into a data frame
  # set names of data frame (could do this with var names)
  names(df)[1] <- "id"
  names(df)[2] <- "nobs"
  return(df)
}
