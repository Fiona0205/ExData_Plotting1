## Estimate how much memory the dataset will require in megabyte
esMemo <- (2075259*9*8)/1048576
## Read data into R
header <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
allData <- read.table("household_power_consumption.txt", skip = 1, stringsAsFactors=FALSE, sep = ";", header = FALSE)
colnames(allData) <- unlist(header)

## Subset data
data <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

## Convert Date and Time varialbles to Date/Time classes
DateTime <- paste(data$Date, data$Time)
data$Date <- strptime(DateTime, "%e/%m/%Y %H:%M:%S")

## Plot graphics
png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")
with(data, plot(Date, Sub_metering_1, type='l', col = "black", ylab = "Energy sub metering", xlab = ""))
lines(data$Date, data$Sub_metering_2, col = "red")
lines(data$Date, data$Sub_metering_3, col = "blue")
legend("topright", col = c("black", "red", "blue"), lty = c(1, 1, 1), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
