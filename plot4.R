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

png("plot4.png", width=480, height=480)

## PLOT 4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(subsetdata, {
        plot(Global_active_power~datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        
        plot(Voltage~datetime, type="l", 
             ylab="Voltage (volt)", xlab="datetime")
             
        plot(Sub_metering_1~datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        lines(Sub_metering_2~datetime,col='Red')
        lines(Sub_metering_3~datetime,col='Blue')
        legend("topright", inset = .00, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col=c("black","red","blue")
               , lty= 1
               , lwd = 2
               , bty="n")
       
        plot(Global_reactive_power~datetime, type="l", 
             ylab="Global Rective Power (kilowatts)",xlab="datetime") 
})

dev.off()