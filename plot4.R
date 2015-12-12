# download the data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "rawdata.zip")
unzip("rawdata.zip")

# read the data into dat and clean the data
library(dplyr)
library(lubridate)
dat<- read.table("household_power_consumption.txt",header = T, sep = ";",stringsAsFactors = F)
date<- as.Date(dat$Date,  "%d/%m/%Y")
gap<- as.numeric(dat$Global_active_power)
dat1<- mutate(dat, Date= date, Global_active_power = gap)
d1<- as.Date("1/2/2007",  "%d/%m/%Y")
d2<- as.Date("2/2/2007",  "%d/%m/%Y")
dat1<- subset(dat1, dat1$Date==d1|dat1$Date==d2)




# read the data into dat and clean the data

library(dplyr)
library(lubridate)
dat<- read.table("household_power_consumption.txt",header = T, sep = ";",stringsAsFactors = F)
date<- as.Date(dat$Date,  "%d/%m/%Y")
gap<- as.numeric(dat$Global_active_power)
dat1<- mutate(dat, Date= date, Global_active_power = gap)
d1<- as.Date("1/2/2007",  "%d/%m/%Y")
d2<- as.Date("2/2/2007",  "%d/%m/%Y")
dat1<- subset(dat1, dat1$Date==d1|dat1$Date==d2)
datetime<- dat1$Date + hms(dat1$Time)

# do the plotting
par(mfrow=c(2,2))
with(dat1,{
  plot( datetime, Global_active_power, type="l", xlab= "", ylab="Global Active Power(Kilowatts)")
  plot( datetime, Voltage, type="l", xlab= "datetime", ylab="Voltage")
  
  plot( datetime, Sub_metering_1,type="l", xlab= "", ylab="Energy sub metering")
  par(new=TRUE)
  plot( datetime, Sub_metering_2,type="l", xlab= "", ylab="Energy sub metering",
        col="red", axes = FALSE, ylim = c(0,40))
  par(new=TRUE)
  plot( datetime, Sub_metering_3,type="l", xlab= "", ylab="Energy sub metering",
        col="blue", axes = FALSE,ylim=c(0,40))
  plot( datetime, Global_reactive_power, type="l", xlab= "datetime")
})
dev.copy(png, file = "plot4.png", height=480, width=480) 
dev.off()
par(mfrow=c(1,1))