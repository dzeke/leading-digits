# Analysis Tools: Leading-Digit Patterns from Smart Water Meters
# Loads data from meter files
# Script by Robert B. Sowby, rob.sowby@hansenallenluce.com
# CC BY-SA (link https://creativecommons.org/licenses/by-sa/2.0/)
# Packages: plyr, lubridate

# Note: This code was developed for a specific format of meter data. You may need to alter it for the format you are reading.

# Clear console
cat("\014")

start_time <- Sys.time()
print(paste("Process started at ", start_time))

# Load sample from file (specify path)
mydata_full <- read.csv("C:/Users/rsowby/Desktop/Current Files/Research/2020 Smart Meter Digits/Xylem data/sample.csv")

# Copy data
mydata <- mydata_full

# Rename columns
names(mydata) <- c("entry", "meter", "time", "total", "read", "unit")

print(paste("mydata is now",length(mydata$read),"records"))

# Drop columns for entry, total, and unit
mydata <- mydata[ -c(1, 4, 6)]

# Reduce to certain year only
mydata <- mydata[lubridate::year(mydata$time) == 2018, ]
print(paste("mydata is now",length(mydata$read),"records"))

# Remove zeros
mydata <- mydata[mydata$read > 0, ]
print(paste("mydata is now",length(mydata$read),"records"))

# Load meter numbers from separate file if needed
meter <- read.csv("C:/Users/rsowby/Desktop/Current Files/Research/2020 Smart Meter Digits/Xylem data/meter.csv")

# Join meter to sample
mydata <- plyr::join(mydata, meter, by = "meter", type = "left", match = "all")

# Remove coarse meters (interval other than 1 gallon)
mydata <- mydata[mydata$int == 1, ]
print(paste("mydata is now",length(mydata$read),"records"))

# Remove interval resolution
mydata <- mydata[ -c(4)]

# Extract first digit
mydata$fd <- substr(mydata$read, 1, 1)

# Write to CSV file
write.csv(mydata, file = "C:/Users/rsowby/Desktop/Current Files/Research/2020 Smart Meter Digits/Xylem data/v3-18.csv")

end_time <- Sys.time()
print("Process complete.")
print(end_time - start_time)