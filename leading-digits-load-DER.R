# Analysis Tools: Leading-Digit Patterns from Smart Water Meters
# Loads data from meter files
# Script by Robert B. Sowby, rob.sowby@hansenallenluce.com
# CC BY-SA (link https://creativecommons.org/licenses/by-sa/2.0/)
# Packages: plyr, lubridate
#
# Ammended by David E. Rosenberg to load Logan Commercial-Industrial Data (Attallah 2019). Attaallah, N. A. M. (2018). "Demand Disaggregation for Non-Residential Water Users in the City of Logan, Utah, USA," Utah State University, Logan, Utah. https://digitalcommons.usu.edu/etd/7401.


# Note: This code was developed for a specific format of meter data. You may need to alter it for the format you are reading.

# Clear console
cat("\014")


if (!require(readxl)) { 
  install.packages("readxl", repos="http://cran.r-project.org") 
  library(readxl) 
}

if (!require(dplyr)) { 
  install.packages("dplyr",repos="http://cran.r-project.org") 
  library(dplyr) # 
}



start_time <- Sys.time()
print(paste("Process started at ", start_time))

# Load sample from file (specify path)
# path to Nour's data on my hard drive
sDataSets <- c("Dataset2.csv","Dataset3.csv")

fLoadPlotData <- function(sDataSet, sUser) {
  #function to read data from the specified csv file sDataSet.
  #sUser = string of user name
  #csv file in six columns: "Business"      "Date"          "Timestamp"     "Water.Use..G." "Time"          "MeterID"
  
  #read in data
  mydata_full <- read.csv(sDataSet)
  
  # Copy data
  mydata <- mydata_full
  
  mydatacols <- names(mydata)
  
  #Set column 4 name to read
  mydatacols[4] <- "read"
  names(mydata) <- mydatacols
  
  # Rename columns
  #names(mydata) <- c("entry", "meter", "time", "total", "read", "unit")
  
  print(paste("mydata is now",length(mydata$read),"records"))
  
  # Drop columns for entry, total, and unit
  mydata <- mydata[ -c(1, 3)]
  
  # Reduce to certain year only
  #mydata <- mydata[lubridate::year(mydata$time) == 2018, ]
  
  #Identify the hour
  mydata$hour <- lubridate::hour(lubridate::hms(mydata$Time))
  
  #Aggregate by hour
  mydatahourly <- mydata %>% group_by(Date,hour,MeterID) %>% summarize(MonthRead = sum(read), count = n() )
  
  
  print(paste("mydatahourly is now",length(mydatahourly$MonthRead),"records"))
  
  # Remove zeros or with not enough 5-second periods
  mydatahourly <- mydatahourly[(mydatahourly$MonthRead > 0) , ]
  
  print(paste("mydatahourly is now",length(mydatahourly$MonthRead),"records"))
  
  # Load meter numbers from separate file if needed
  #meter <- read.csv("____________________________")
  
  # Join meter to sample
  #mydata <- plyr::join(mydata, meter, by = "meter", type = "left", match = "all")
  
  # Remove coarse meters (interval other than 1 gallon)
  #mydata <- mydata[mydata$int == 1, ]
  #print(paste("mydata is now",length(mydata$read),"records"))
  
  # Remove interval resolution
  #mydata <- mydata[ -c(4)]
  
  # Extract first digit
  mydatahourly$fd <- as.numeric(substr(mydatahourly$MonthRead, 1, 1))
  
  sFDWrite = paste(sUser,sDataSet,"fd.csv",sep="-")
  
  # Write to CSV file
  write.csv(mydatahourly, file = sFDWrite)
  
  # Note the time period
  mydatahourly$DateProper <- as.Date(mydatahourly$Date)
  sTimeRange <- paste(min(mydatahourly$DateProper),"to",max(mydatahourly$DateProper))
  
  # Plot histogram
  hist(mydatahourly$fd, main=paste(sUser, sDataSet,"\n",sTimeRange),breaks=10, xlab ="First Non-Zero Digit")
  }

## Loop over the datasets

for (s in sDataSets) {
  print(s)
  fLoadPlotData(s,"Manufacturing 2")
}

