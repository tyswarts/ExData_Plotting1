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
#set up the labels
loc<-c(rangedata1$date_time[1],rangedata1$date_time[(length(rangedata1$date_time)/2)],
       rangedata1$date_time[length(rangedata1$date_time)])
wkdays<-c("Thu", "Fri", "Sat")
#plot
with(rangedata1, plot(date_time, (Global_active_power/1000),type="b", xaxt = "n", ylab = "Global Active Power(kilowatts)"))
with(rangedata1, lines(date_time, (Global_active_power/1000)))
axis(1, at= loc, labels=wkdays)