# function pollutantmean
# this function loads pollution monitor sample files from the directory. only files with the ID 
# listed in the ID arg loaded.  The function then computes the mean for the sample pollutant arg
# only valid samples are computed, NA's are filtered out.
# Norm Zeck
pollutantmean <- function(directory = "specdata", pollutant, id = 1:332) {
  specFnames <- list.files(directory, full.names = TRUE)  # get a list of files in the directory
  #read in only csv files that are in the id vector - probably should check for csv only files
  specData <- do.call(rbind, lapply(specFnames[id], function(x) {
    tt <- read.csv(x)
  }))
  #compute mean for non NA readings for pollutant passed in as arg
  tvec <- !is.na(specData[pollutant])    # boolean vector na/valid
  polmean <- mean(specData[pollutant][tvec])  # subset only valid entries
  return(polmean)   #return mean
}