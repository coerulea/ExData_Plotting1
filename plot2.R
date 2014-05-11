## Please use the below code if the datasize is not a concern
## Please download the zipfile and extract the folder into your working directory before running the below code
## if data size is a concern please use the next code snippet to read the data

## Reading the entire dataset
data <- read.table("~/exdata-data-household_power_consumption/household_power_consumption.txt", sep=";", header=TRUE, colClasses="character")

## Finding the location of the data subset that needs to be used- 
## specifically data referencing dates 2007-02-01 and 2007-02-02
loc <- grep("^[1-2]/2/2007", data$Date, value=FALSE)
length(loc)

subdata <- data[loc,]

## please use the below code snippet to read the data if your computer cannot process the entire data
## The code is put in comments - remove the 'hash' signs and use the code
## This code uses location information gained by processing the entire dataset
## temp <- tempfile()
## download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
## subdata <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", skip=66636, nrows=2880, header=TRUE, colClasses="character")
## namesdata <- read.table(unz(temp, "household_power_consumption.txt"), sep=";", nrows=1, colClasses="character")
## unlink(temp)
## names(subdata) <- namesdata

dim(subdata)

## Transforming the dataset variables - converting to 'date'
subdata$Date <- as.Date(subdata$Date, format="%d/%m/%Y")

## Converting to 'time' - adding an additional column with date and time as a single variable
subdata$DateTime <- do.call(paste, c(subdata[c("Date", "Time")], sep = " "))
subdata$DateTime <- strptime(subdata$DateTime, format="%Y-%m-%d %H:%M:%S")

## Converting the rest of the required variables to numeric
subdata$Global_active_power <- as.numeric(subdata$Global_active_power)
subdata$Global_reactive_power <- as.numeric(subdata$Global_reactive_power)
subdata$Sub_metering_1 <- as.numeric(subdata$Sub_metering_1)
subdata$Sub_metering_2 <- as.numeric(subdata$Sub_metering_2)
subdata$Sub_metering_3 <- as.numeric(subdata$Sub_metering_3)
subdata$Voltage <- as.numeric(subdata$Voltage)

## ----------------------

## The 2nd plot - the line plot of Global Aactive Power

png('plot2.png', width=480,height=480, bg="transparent")
plot(subdata$DateTime,subdata$Global_active_power, type="l", 
ylab="Global Active Power (kilowatts)", xlab="", bg="transparent")
dev.off()


