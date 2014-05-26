m1 <- pollutantmean("./specdata", "sulfate", 1:32)
m2 <- pollutantmean("./specdata", "nitrate", 1:32)
m3 <- pollutantmean("./specdata", "sulfate", 1:332)
m4 <- pollutantmean("./specdata", "nitrate", 1:332)
m5 <- pollutantmean("./specdata", "sulfate", 1:1)
m6 <- pollutantmean("./specdata", "sulfate", 20:50)
m7 <- pollutantmean("./specdata", "bogus", 40:50)
m1 <- pollutantmean("./specdata", "sulfate", 1:1)

df1 <- complete("./specdata", 40:42)
df1 <- complete("./specdata", 1:1)

cvec1 <- corr("./specdata", 20)