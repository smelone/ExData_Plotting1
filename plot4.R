# Coursera: Exploratory Data Analysis
# Course Project #1

# Set working directory and pull in data zip file
setwd("C:/Users/matr06497/Desktop/Coursera/Exploratory Data Analysis")
if (!file.exists("data.zip")) {
  download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                destfile="data.zip")
  unzip("data.zip")  
}

# Read in and clean data
data <- read.csv("household_power_consumption.txt", 
                 skip=66637,
                 nrows=2880,
                 na.strings = "?",
                 header=F,
                 sep=";")
names(data) <- names(read.csv("household_power_consumption.txt", nrows=1,sep=";"))
data$DateTime <- as.POSIXct(paste(data$Date, data$Time, sep=" "), 
                            format="%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, format="%d/%m/%y")
data$Time <- strptime(data$Time, format="%H:%M:%S")

par(mfrow=c(2,2))
with(data,{
  plot(data$DateTime, data$Global_active_power, 
       type="l", 
       ylab="Global Active Power",
       xlab= "")
  plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
  lines(data$DateTime, data$Sub_metering_2, type="l", col = "blue")
  lines(data$DateTime, data$Sub_metering_3, type="l", col = "red")
  legend('topright', legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c('black', 'red', 'blue'), bty='n') 
  
  plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})
dev.copy(png,file="plot4.png", width=480, height=480)
dev.off() 