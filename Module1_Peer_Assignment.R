#1
#  Memory=2,075,259×9×8=149,419,872 bytes≈149.42 MB
getwd()
setwd("/Users/sanatkumargupta/desktop")
#2
# Load the necessary library
library(data.table)

# Read data and handle missing values
data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

# Create DateTime column by combining Date and Time, and convert to POSIXct
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Subset data for the dates 2007-02-01 and 2007-02-02
data <- subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))

# Plot 1: Histogram of Global Active Power
png("plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)")
dev.off()

# Plot 2: Time Series of Global Active Power
png("plot2.png", width=480, height=480)
plot(data$DateTime, data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)", main="Global Active Power Over Time")
dev.off()

# Plot 3: Energy Sub Metering
png("plot3.png", width=480, height=480)
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering",
     main="Energy Sub Metering Over Time", col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1)
dev.off()

# Plot 4: Multiple Time Series Plots
png("plot4.png", width=480, height=480)
par(mfrow=c(2, 2))  # 2x2 layout

# Top-left: Global Active Power
plot(data$DateTime, data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power")

# Top-right: Voltage
plot(data$DateTime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Bottom-left: Energy Sub Metering
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1, bty="n")

# Bottom-right: Global Reactive Power
plot(data$DateTime, data$Global_reactive_power, type="l", xlab="datetime", 
     ylab="Global Reactive Power")

dev.off()

