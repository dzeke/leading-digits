# Analysis Tools: Leading-Digit Patterns from Smart Water Meters
# Evaluates conformance to Benford's Law, steep power law, and when 1 most frequent digit
# Script by Robert B. Sowby, rob.sowby@hansenallenluce.com
# CC BY-SA (link https://creativecommons.org/licenses/by-sa/2.0/)
# Packages: lubridate, BenfordTests

# Note: Order for fields in file to be read must be:
# METER, TIME, READ
# Other fields willbe added.

# Clear console
cat("\014")

# PART 1: LOAD DATA #####################################################################

# Save start time
start_time <- Sys.time()
mytime <- Sys.time()
print(paste("Process started at", mytime))

# File to read (input)
readfile <- "C:/Users/rsowby/Desktop/Current Files/Research/2020 Smart Meter Digits/Xylem data/v3-18.csv"
ksfile <- "C:/Users/rsowby/Desktop/Current Files/Research/2020 Smart Meter Digits/R/ks-crit-values.csv"
# File to write (ouput). Results will be APPENDED. Make sure file does not already exist.
writefile <- "C:/Users/rsowby/Desktop/Current Files/Research/2020 Smart Meter Digits/R/fulltest-L.csv"

# Load data saved previously into data frame df
print(paste("Loading data from ", readfile , "..."))
df_full <- read.csv(readfile)

# PART 2: PROCESS METER DATA ################################################################

# Copy data frame for processing (avoid re-reading file)
df <- df_full

# Save minimum value (used later in exponent calculation)
read_min <- min(df_full$read)

# Generate list and count of unique meters
meterlist <- unique(df_full$meter)
meter_count = length(meterlist)

# Loop through all meters
count <- 0

for(mymeter in meterlist) {
  # Clear console and print status
  cat("\014")
  print(paste("Process started at", start_time))
  print("Calculating power law exponents...")  
  print(paste("Meter", count, "of", meter_count, "(", round(100 * count / meter_count, 0), "% )"))
  
  # Start with full dataset each time
  df <- df_full 

  # Reduce df to current meter only
  df <- df[df$meter == mymeter, ]
  
  # Set up data frame with 4 columns and 1 row per unique meter x 12 months
  metermonth <- data.frame(matrix(ncol = 6, nrow = 12))
  # Rename columns
  names(metermonth) <- c("meter", "month", "ks", "m", "n", "mfd")
  
  # Calculate power law exponent for each meter-month
  for(mymonth in 1:12) { # Loop through all 12 months
    metermonth$meter[mymonth] <- mymeter
    metermonth$month[mymonth] <- mymonth
    n <- length(df$read[lubridate::month(df$time) == mymonth]) # Get sample size (number of hourly observations)
    metermonth$n[mymonth] <- n # Store sample size
    metermonth$ks[mymonth] <- BenfordTests::ks.benftest(df$read[lubridate::month(df$time) == mymonth],1,"simulate",100)[[1]]
    metermonth$m[mymonth] <- (n * 1 / sum(log(df$read[lubridate::month(df$time) == mymonth] / read_min))) # Store exponent
    metermonth$mfd[mymonth] <- sort(df$fd[lubridate::month(df$time) == mymonth])[1] # Month's most frequest digit
  }
  
  count <- count + 1
  
  # Append metermonth to specified CSV file
  write.table(metermonth, writefile, sep = ",", col.names = FALSE, append = TRUE)
}

# PART 3: SUMMARIZE LEADING DIGITS #######################################################

# Summarize findings
print("Preparing summary...")
# Read output into new dataframe df2
df2  <- read.csv(writefile)
# Name columns
names(df2) <- c("x", "meter", "month", "ks", "m", "n", "mfd")
# Remove blank months
df2 <- df2[df2$n != 0,]
# Count entries
mycount <- length(df2$n) 
# Normalize KS computed for number in sample
df2$ks <- df2$ks / (df2$n^0.5)
# Match KS critical values
dfks <- read.csv(ksfile)
names(dfks) <- c("n","crit")

#Loop through rows to populate KS critical values by lookup
for(myrow in 1:mycount) { # 
  myn <- df2$n[myrow]
  df2$kscrit[myrow] <- dfks$crit[myn]
}

# Report
print(paste("Number of meter-months:", mycount))
print(paste("Benford's law in", length(df2$ks[df2$ks <= df2$kscrit]), "of", mycount, "meter-months, or", 100 * length(df2$ks[df2$ks <= df2$kscrit]) / mycount, "percent"))
print(paste("Steep power law in", length(df2$m[df2$m > 0 ]), "of", mycount, "meter-months, or", 100 * length(df2$m[df2$m >= 0 ]) / mycount, "percent"))
print(paste("   Minimum power law exponent, m:", min(df2$m)))
print(paste("1 most frequent digit in", length(df2$mfd[df2$mfd == 1]), "of", mycount, "meter-months, or", 100 * length(df2$mfd[df2$mfd == 1]) / mycount, "percent"))

# Report process finished
end_time <- Sys.time()
print("Process complete.")
print(end_time - start_time)