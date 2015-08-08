## Data plot from the "Individual household electric power consumption Data Set",
# compiled by UC Irvine Machine Learning Repository (UC Irvine Machine Learning Repository)

# Due performance concerns, this series of exercises will download and decompress
# the input data only once, the first time that any of this scripts is run, it will
# load on memory the information from the date range, and that information will be 
# shared among the other scripts.

# If a different date range is required, clear all the variables and change the parameters
# on the utilities.R script.

# The plot shows the consumption of electric active power (in kilowatts) during
# Feb 1st and 2nd of 2007.


source("utilities.R")

## Constants definition.
titleText <- "Global Active Power"
outputFile <- paste(outputDirectory, "/plot02_", titleText, ".png", sep = "")

## Retrieving the data (it may be the information already kept in memory)
inputData <- retrieveData(startPeriod, endPeriod)

## Generating the Plot
par(mfrow=c(1,1), mar=c(4,4,2,1), oma=c(0,0,2,0), bg="transparent")
plot(inputData$Global_active_power~inputData$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

## Saving to file
dev.copy(png, file=outputFile, height=outputHeight, width=outputWidth)
dev.off()
