## Data plot from the "Individual household electric power consumption Data Set",
# compiled by UC Irvine Machine Learning Repository (UC Irvine Machine Learning Repository)

# Due performance concerns, this series of exercises will download and decompress
# the input data only once, the first time that any of this scripts is run, it will
# load on memory the information from the date range, and that information will be 
# shared among the other scripts.

# If a different date range is required, clear all the variables and change the parameters
# on the utilities.R script.

# The plot shows the consumption of electric active power (in kilowatts) during
# Feb 1st and 2nd of 2007, by submetering indicator along the datetime.


source("utilities.R")

## Constants definition.
titleText <- "Global Active Power"
outputFile <- paste(outputDirectory, "/plot03_", titleText, ".png", sep = "")

## Retrieving the data (it may be the information already kept in memory)
inputData <- retrieveData(startPeriod, endPeriod)

## Generating the Plot
par(mfrow=c(1,1), mar=c(4,4,2,1), oma=c(0,0,2,0), bg="transparent")
with(inputData, {
      plot(Sub_metering_1~Datetime, type="l",
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file=outputFile, height=outputHeight, width=outputWidth)
dev.off()
