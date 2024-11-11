getwd()
setwd("/Users/sanatkumargupta/desktop")

library(data.table)
data <- read.csv("household_power_consumption.txt", sep=";", header=TRUE, na.strings="?")

# Create DateTime column by combining Date and Time, and convert to POSIXct
data$DateTime <- as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# Subset data for the dates 2007-02-01 and 2007-02-02
data <- subset(data, DateTime >= as.POSIXct("2007-02-01") & DateTime < as.POSIXct("2007-02-03"))


# Plot 2: Time Series of Global Active Power
png("plot2.png", width=480, height=480)
plot(data$DateTime, data$Global_active_power, type="l", xlab="", 
     ylab="Global Active Power (kilowatts)", main="Global Active Power Over Time")
dev.off()
