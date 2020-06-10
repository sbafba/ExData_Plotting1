data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format column "Date" to Type Date d/m/Y
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subset data set from Feb. 1, 2007 to Feb. 2, 2007
subsetdata <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

png("plot1.png", width=480, height=480)

## PLOT 1
hist(subsetdata$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

dev.off()
