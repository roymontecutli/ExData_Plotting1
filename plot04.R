## Data plot from the "Individual household electric power consumption Data Set",
# compiled by UC Irvine Machine Learning Repository (UC Irvine Machine Learning Repository)

# Due performance concerns, this series of exercises will download and decompress
# the input data only once, the first time that any of this scripts is run, it will
# load on memory the information from the date range, and that information will be 
# shared among the other scripts.

# If a different date range is required, clear all the variables and change the parameters
# on the utilities.R script.

## Combined plots for consumption of electric active power (in kilowatts) during
# Feb 1st and 2nd of 2007:
# Upper left - plot of global active power in kilowatts
# Upper Right - plot of voltage in volts
# Lower left - plot of global active power in kilowatts, separated by sub metering
# Lower Right - plot of global rective power in kilowatts


source("utilities.R")

## Constants definition.
titleText <- "Global Active Power_Summary"
outputFile <- paste(outputDirectory, "/plot04_", titleText, ".png", sep = "")

## Retrieving the data (it may be the information already kept in memory)
inputData <- retrieveData(startPeriod, endPeriod)

## Generating the Plot
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0), bg="transparent")
with(inputData, {
      plot(Global_active_power~Datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      plot(Voltage~Datetime, type="l", 
           ylab="Voltage (volt)", xlab="")
      plot(Sub_metering_1~Datetime, type="l", 
           ylab="Global Active Power (kilowatts)", xlab="")
      lines(Sub_metering_2~Datetime,col='Red')
      lines(Sub_metering_3~Datetime,col='Blue')
      legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
             legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
      plot(Global_reactive_power~Datetime, type="l", 
           ylab="Global Rective Power (kilowatts)",xlab="")
})

## Saving to file
dev.copy(png, file=outputFile, height=outputHeight, width=outputWidth)
dev.off()
