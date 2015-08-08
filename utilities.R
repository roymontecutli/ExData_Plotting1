## Utility methods, shared across all the scripts. To allow run the scripts indendently, it
## will verify if the data folder has been already created, and the information downloaded 
## and decompressed; if not, it will do it.

## Constants declaration.
# URL where the data can be retrieved
urlData <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
# name of the test data file on the local system
workingDirectory <- "data"
zipFileName <- "downloadedData.zip"
fileDataName <- "household_power_consumption.txt"

outputDirectory <- "output"

# The size of the output images is taken from the examples provided
outputWidth <- 504
outputHeight <- 504

zipFile <- paste(workingDirectory, "/", zipFileName, sep = "")
fileData <- paste(workingDirectory, "/", fileDataName, sep = "")

# As the volume of data is large, a small range will be used, the following variables will 
# define the range of dates to be used.
startPeriod <- "2007-02-01"
endPeriod <- "2007-02-02"

# Creates the folder, with the name specified, if it doesn't already exist.
createFolder <- function(folderName = "data") {
      
      # Retrieves the information of the folder, if there is no information it is inferred
      # that it needs to be created.
      inputData <- file.info(folderName)
      if (is.na(inputData) == TRUE || (as.logical(inputData$isdir) == FALSE)) {
            dir.create(folderName)
            print(paste(folderName, "directory created ..."))
            if (exists("inputData")) {
                  rm(inputData)
            }
      }
}

# Downloads the data into the 'data' folder, if it is not already downloaded.
downloadData <- function(urlData) {
      
      createFolder(workingDirectory)
      
      # If the file has not been downloaded yet, it will be retrieved
      inputData <- file.info(zipFile)
      if (is.na(inputData) == TRUE || inputData$size <= 0) {
            print(paste("Downloading", urlData, "..."))
            download.file(url = urlData, destfile = zipFile, method="auto")
            print(paste("Decompressing", zipFile, "..."))
            unzip(zipfile = zipFile, exdir = workingDirectory)
            if (exists("inputData")) {
                  rm(inputData)
            }
      }
}

# As the amount of data will be large, it will be downloaded and filtered only once, 
# all the next invocations to create the different plots of the exercise will "reuse"
# the object already filtered.
retrieveData <- function(startPeriod, endPeriod) {
      
      # Prepares input 
      downloadData(urlData)

      # Prepares output 
      createFolder(outputDirectory)
      
      if (exists("inputData")) {
            print("Retrieving data already filtered ...")
            return (inputData)
      }

      data_raw <- read.csv(fileData, header=T, sep=';', na.strings="?", 
                           check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
      data_raw$Date <- as.Date(data_raw$Date, format="%d/%m/%Y")
      
      ## Subsetting the data
      inputData <- subset(data_raw, subset=(Date >= startPeriod & Date <= endPeriod))
      # to free memory, the original raw data is removed
      rm(data_raw)

      ## Converting dates
      datetime <- paste(as.Date(inputData$Date), inputData$Time)
      inputData$Datetime <- as.POSIXct(datetime)

      print(paste("Filter of data for range", startPeriod, " and ", endPeriod))
      return(inputData)
}