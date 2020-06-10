data <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Format column "Date" to Type Date d/m/Y
data$Date <- as.Date(data$Date, "%d/%m/%Y")

## Subset data set from Feb. 1, 2007 to Feb. 2, 2007
subsetdata <- subset(data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observations
subsetdata <- subsetdata[complete.cases(subsetdata),]

## Merge Date and Time column
datetime <- paste(subsetdata$Date, subsetdata$Time)

## Name the new vector
datetime <- setNames(datetime, "DateTime")

## Remove Date and Time column
subsetdata <- subsetdata[ ,!(names(subsetdata) %in% c("Date","Time"))]

## Add new "DateTime" column
subsetdata <- cbind(datetime, subsetdata)

## Format clumn datetime column
subsetdata$datetime <- as.POSIXct(datetime)

png("plot2.png", width=480, height=480)

## PLOT 2
plot(subsetdata$Global_active_power ~ subsetdata$datetime, type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()