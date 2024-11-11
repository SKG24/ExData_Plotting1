getwd()
setwd("/Users/sanatkumargupta/desktop")

library(data.table)
data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

# Create DateTime column by combining Date and Time, and convert to POSIXct
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Subset data for the dates 2007-02-01 and 2007-02-02
data <- subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))


# Plot 3: Energy Sub Metering
png("plot3.png", width=480, height=480)
plot(data$DateTime, data$Sub_metering_1, type="l", xlab="", ylab="Energy Sub Metering",
     main="Energy Sub Metering Over Time", col="black")
lines(data$DateTime, data$Sub_metering_2, col="red")
lines(data$DateTime, data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lty=1)
dev.off()