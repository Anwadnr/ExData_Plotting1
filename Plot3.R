library(data.table)

setwd("C:/Users/awat490/Desktop/Coursera/exdata_data_household_power_consumption")

## Loading in data

file.url<-'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(file.url,destfile='source data/power_consumption.zip')
unzip('source data/power_consumption.zip',exdir='source data',overwrite=TRUE)

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

#### Plot 3

## Create Plot

with (Power_Consum, 
      {plot(Sub_metering_1~Date_Time, 
            type="l",
            ylab = "Energy sub metering", 
            xlab = "")
        lines(Sub_metering_2~Date_Time, col = 'Red')
        lines(Sub_metering_3~Date_Time, col = 'Blue')})

legend("topright",
       legend=c('Sub_metering_1','Sub_metering_2','Sub_metering_3'),
       col=c('black','red','blue'),lty='solid', cex = 0.75)

## Save file and close device

dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
