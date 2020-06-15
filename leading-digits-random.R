# Experimentation with Leading (first non-zero) Digits on random data
# David Rosenberg
# david.rosenberg@usu.edu
# June 14, 2020

# Let's test the leading digits principle (numbers disproportionately have leading digits of 1) o some randomly generated data
#
# For more on leading digits and water use, see
# Sowby, R. B. (2018). "Conformance of Public Water Use Data to Benford's Law." Journal - AWWA, 110(12), E52-E59. https://awwa.onlinelibrary.wiley.com/doi/abs/10.1002/awwa.1161.


#### Uniform 0 - 10
dist <- "Uniform"
nSamples <- 10000
nLow <- 0  #lower bound
nUp <- 10 # upper bound
dist <- "Uniform (runif)"
sTitle = paste(dist,"between",nLow,"and",nUp)

dfRandom <- data.frame(Val = runif(nSamples,nLow,nUp))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10)


#### Uniform 0 - 250
nSamples <- 10000
nLow <- 0  #lower bound
nUp <- 250 # upper bound
dist <- "Uniform"
sTitle = paste(dist,"between",nLow,"and",nUp)

dfRandom <- data.frame(Val = runif(nSamples,nLow,nUp))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out leading zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10, xlab ="First Non-Zero Digit")


#### Uniform 0 - 450
nSamples <- 10000
nLow <- 0  #lower bound
nUp <- 450 # upper bound
dist <- "Uniform"
sTitle = paste(dist,"between",nLow,"and",nUp)

dfRandom <- data.frame(Val = runif(nSamples,nLow,nUp))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out leading zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10, xlab ="First Non-Zero Digit")

#### Uniform 650 - 1650
nSamples <- 10000
nLow <- 650  #lower bound
nUp <- 3650 # upper bound
dist <- "Uniform"
sTitle = paste(dist,"between",nLow,"and",nUp)

dfRandom <- data.frame(Val = runif(nSamples,nLow,nUp))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out leading zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10, xlab ="First Non-Zero Digit")



#### Uniform 0 - 10  sampling integers only with replacement
nSamples <- 10000
nLow <- 0  #lower bound
nUp <- 10 # upper bound
dist <- "Integer with Replacement (sample)"

sTitle = paste(dist,"between",nLow,"and",nUp)

dfRandom <- data.frame(Val = sample(nLow:nUp, nSamples,replace=T))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out leading zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10, xlab ="First Non-Zero Digit")



#### Normal Mean 600, st.dev 150
nSamples <- 10000
nMean <- 600  #lower bound
nStDev <- 150 # upper bound
dist <- "Normal (rnorm)"

sTitle = paste(dist,"with Mean",nMean,"and St. Dev.",nStDev)

dfRandom <- data.frame(Val = rnorm(nSamples,mean=nMean, sd = nStDev))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out leading zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10, xlab ="First Non-Zero Digit")


#### Normal Mean 600, st.dev 150
nSamples <- 10000
nMean <- 800  #lower bound
nStDev <- 150 # upper bound
dist <- "Normal (rnorm)"

sTitle = paste(dist,"with Mean",nMean,"and St. Dev.",nStDev)

dfRandom <- data.frame(Val = rnorm(nSamples,mean=nMean, sd = nStDev))

#Calculate the leading digit
dfRandom$Lead <- as.numeric(substr(dfRandom$Val, 1, 1))
#Strip out leading zeros
dfRandom <- dfRandom[dfRandom$Lead > 0,]

hist(dfRandom$Lead,main=sTitle, breaks=10, xlab ="First Non-Zero Digit")

