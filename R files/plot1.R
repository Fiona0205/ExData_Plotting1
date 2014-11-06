## Estimate how much memory the dataset will require in megabyte
esMemo <- (2075259*9*8)/1048576

## Read data into R
header <- read.table('household_power_consumption.txt', nrows = 1, header = FALSE, sep =';', stringsAsFactors = FALSE)
allData <- read.table("household_power_consumption.txt", skip = 1, stringsAsFactors=FALSE, sep = ";", header = FALSE)
colnames(allData) <- unlist(header)

## Subset data
data <- subset(allData, Date == "1/2/2007" | Date == "2/2/2007")
data$Global_active_power <- as.numeric(data$Global_active_power)

## Plot graphic
png(filename = "plot1.png", width = 480, height = 480, bg = "transparent")
hist(data$Global_active_power, col = "red", xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()


