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