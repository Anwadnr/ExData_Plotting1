## Loading in data

library(data.table)
Power_Consum <- read.table("household_power_consumption.txt", 
           header = TRUE, 
           sep = ";", 
           na.strings = "?", 
           colClasses = c('character', 'character', 
           'numeric', 'numeric','numeric',
           'numeric','numeric','numeric','numeric'))

## Formating date

Power_Consum$Date <- as.Date(Power_Consum$Date, "%d/%m/%Y")

## subset 2007-02-01 and 2007-02-02

Power_Consum <- subset(Power_Consum, 
                Date >= as.Date("2007-2-1") & 
                 Date <= as.Date("2007-2-2"))

## Combine Date and Time

Date_Time <- paste(Power_Consum$Date, Power_Consum$Time)
Date_Time <- setNames(Date_Time, "Date_Time")
Power_Consum <- cbind(Date_Time, Power_Consum)

## restructure data table

Power_Consum <- subset(Power_Consum, select = -c(Date, Time))
Power_Consum$Date_Time <- as.POSIXct(Date_Time)

#### Plot 1

## Create Histogram

hist(Power_Consum$Global_active_power, breaks = 12, 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     col = "red")

## Save file and close device

dev.copy(png, "plot1.png", width = 480, height = 480)
dev.off()

#### Plot 2

## create Plot

plot(Power_Consum$Global_active_power~ Power_Consum$Date_Time, 
     type="l", 
     ylab="Global Active Power (kilowatts)", xlab = "")

## Save File and Close device

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#### Plot 3

## Create Plot

with (Power_Consum, 
     {plot(Sub_metering_1~Date_Time, 
      type="l",
      ylab = "Energy sub metering", 
      xlab = "")
       lines(Sub_metering_2~Date_Time, col = 'Red')
       lines(Sub_metering_3~Date_Time, col = 'Blue')})
       
       legend("topright", col = c("black", "red", "blue"), 
              lwd = c(1,1,1), 
              c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
       
## Save file and close device
       
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

#### Plot 4

## Create Plot

par(mfrow = c(2, 2))
with(Power_Consum, {
  plot(Global_active_power~Date_Time, type = "l",
       ylab = "Global Active Power", xlab= "")
  
  plot(Voltage~Date_Time, type = "l",
       ylab = "Voltage", xlab = "datetime")
  
  plot(Sub_metering_1~Date_Time, type = "l",
       ylab = "Energy sub metering", xlab= "")
       lines(Sub_metering_2~Date_Time,col='Red')
       lines(Sub_metering_3~Date_Time,col='Blue')
       legend("topright", col=c("black", "red", "blue"), 
         lty=1, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", 
                  "Sub_metering_3"))
  
  plot(Global_reactive_power~Date_Time, type="l", 
       ylab="Global_Reactive_Power", xlab="datetime")
})

## Save file and close device

dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()