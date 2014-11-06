## Estimate how much memory the dataset will require in megabyte
esMemo <- (2075259*9*8)/1048576
## Read data into R
header <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
allData <- read.table("household_power_consumption.txt", skip = 1, stringsAsFactors=FALSE, sep = ";", header = FALSE)
colnames(allData) <- unlist(header)

## Subset data
data <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")
data <- transform(data, Global_active_power <- as.numeric(Global_active_power),
    Global_reactive_power <- as.numeric(Global_reactive_power),
    Voltage <- as.numeric(Voltage),
    Sub_metering_1 <- as.numeric(Sub_metering_1),
    Sub_metering_2 <- as.numeric(Sub_metering_2),
    Sub_metering_3 <- as.numeric(Sub_metering_3))

## Convert Date and Time varialbles to Date/Time classes
DateTime <- paste(data$Date, data$Time)
data$Date <- strptime(DateTime, "%e/%m/%Y %H:%M:%S")

## Plot graphics
png(filename = "plot4.png", width = 480, height = 480, bg = "transparent")
par(mfrow = c(2,2))
with(data, plot(Date, Global_active_power, type = "l", ylab = "Global Active Power", xlab = ""))
with(data, plot(Date, Voltage, type = "l", ylab = "Voltage", xlab = "datetime"))
with(data, plot(Date, Sub_metering_1, type='l', col = "black", ylab = "Energy sub metering", xlab = ""))
lines(data$Date, data$Sub_metering_2, col = "red")
lines(data$Date, data$Sub_metering_3, col = "blue")
legend("topright", bty = "n", col = c("black", "red", "blue"), lty = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(data, plot(Date, Global_reactive_power, type = "l", ylab = "Global_reactive_power", xlab = "datetime"))
dev.off()
