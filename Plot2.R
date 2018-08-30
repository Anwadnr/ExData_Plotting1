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

#### Plot 2

## create Plot

plot(Power_Consum$Global_active_power~ Power_Consum$Date_Time, 
     type="l", 
     ylab="Global Active Power (kilowatts)", xlab = "")

## Save File and Close device

dev.copy(png,"plot2.png", width=480, height=480)
dev.off()