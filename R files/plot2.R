## Estimate how much memory the dataset will require in megabyte
esMemo <- (2075259*9*8)/1048576

## Read data into R
header <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
allData <- read.table("household_power_consumption.txt", skip = 1, stringsAsFactors=FALSE, sep = ";", header = FALSE)
colnames(allData) <- unlist(header)

## Subset data
data <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")
data$Global_active_power <- as.numeric(data$Global_active_power)

## Convert Date and Time varialbles to Date/Time classes
DateTime <- paste(data$Date, data$Time)
data$Date <- strptime(DateTime, "%e/%m/%Y %H:%M:%S")

## Plot graphic
png(filename = "plot2.png", width = 480, height = 480, bg = "transparent")
with(data, plot(Date, Global_active_power, type='l', ylab = "Global Active Power (kilowatts)",
     xlab = ""))
dev.off()

