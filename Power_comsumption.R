#Homework for Exploratory Data Week 1

setwd("~/R/Coursera/Exploratory Data")
rawdata<-read.table("household_power_consumption.csv", header = TRUE, sep = ";", colClasses = c("character", "character", "factor", "factor", "factor", "factor","factor", "factor", "factor"))

#change date and time
library(lubridate)
rawdata$Date<-dmy(rawdata$Date)
rangedata<-rawdata[rawdata$Date %in% as.Date(c("2007-02-01", "2007-02-02")),]
rangedata$Global_active_power<-as.numeric(rangedata$Global_active_power)

#set up data to be graphed by day of the week and time.
date_time<-paste(rangedata$Date, " ", rangedata$Time)
t1 <- as.POSIXct(strptime(date_time, format="%H:%M:%S"))
day<-wday(rangedata$Date, label = TRUE)
day_time<-paste(day, " ", date_time)
rangedata1<-cbind(rangedata,date_time,day, day_time)

#Plot 1 Histogram

hist(rangedata$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power(Watts)")

#awnser2 !

loc<-c(rangedata1$date_time[1],rangedata1$date_time[(length(rangedata1$date_time)/2)],
       rangedata1$date_time[length(rangedata1$date_time)])
wkdays<-c("Thu", "Fri", "Sat")
with(rangedata1, plot(date_time, (Global_active_power/1000),type="b", xaxt = "n", ylab = "Global Active Power(kilowatts)"))
with(rangedata1, lines(date_time, (Global_active_power/1000)))
axis(1, at= loc, labels=wkdays)

#number 3
loc<-c(rangedata1$date_time[1],rangedata1$date_time[(length(rangedata1$date_time)/2)],
       rangedata1$date_time[length(rangedata1$date_time)])
wkdays<-c("Thu", "Fri", "Sat")
#reset ranges to numerics
rangedata1$Sub_metering_1 <-as.numeric(rangedata1$Sub_metering_1)
rangedata1$Sub_metering_2 <-as.numeric(rangedata1$Sub_metering_2)
rangedata1$Sub_metering_3 <-as.numeric(rangedata1$Sub_metering_3)
rangedata1$Voltage<-as.numeric(rangedata1$Voltage)
rangedata1$Global_reactive_power<-as.numeric(rangedata1$Global_reactive_power)
#set plot
with(rangedata1, plot(date_time, Sub_metering_1, type = "b", xaxt = "n", ylab = "Energy sub metering"))
with(rangedata1, lines(date_time, Sub_metering_1))
with(rangedata1, lines(date_time, ((Sub_metering_2/7)+1.7), col = "red"))
with(rangedata1, lines(date_time, Sub_metering_3, col = "blue"))
axis(1, at= loc, labels=wkdays)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c(1,3))


#Number 4
#plot 1
par(mfrow = c(2, 2), mar = c(5, 4, 2, 1))
with(rangedata1, plot(date_time, (Global_active_power/1000),type="b", xaxt = "n", ylab = "Global Active Power(kilowatts)"))
with(rangedata1, lines(date_time, (Global_active_power/1000)))
axis(1, at= loc, labels=wkdays)
#plot 2
with(rangedata1, plot(date_time, Voltage ,type="b", xaxt = "n", ylab = "Voltage", xlab = "datetime"))
with(rangedata1, lines(date_time, Voltage))
axis(1, at= loc, labels=wkdays)
#plot 3
with(rangedata1, plot(date_time, Sub_metering_1, type = "b", xaxt = "n", ylab = "Energy sub metering"))
with(rangedata1, lines(date_time, Sub_metering_1))
with(rangedata1, lines(date_time, ((Sub_metering_2/7)+1.7), col = "red"))
with(rangedata1, lines(date_time, Sub_metering_3, col = "blue"))
axis(1, at= loc, labels=wkdays)
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c(1,3))
#plot 4
with(rangedata1, plot(date_time, Global_reactive_power ,type="b", xaxt = "n", ylab = "Global_reactive_power", xlab = "datetime"))
with(rangedata1, lines(date_time, Global_reactive_power))
axis(1, at= loc, labels=wkdays)
