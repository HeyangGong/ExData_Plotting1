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



# get the data for the third plot
time<- hms(dat1$Time)
dat3<- mutate(dat1, Time = time)
dat3<- rename(dat3, date3= Date,time3= Time) %>%
  select(date3, time3,Sub_metering_1, Sub_metering_2, Sub_metering_3) 


# plot the global active power against time
attach(dat3)
plot( date3+time3, Sub_metering_1,type="l", xlab= "", ylab="Energy sub metering")
par(new=TRUE)
plot( date3+time3, Sub_metering_2,type="l", xlab= "", ylab="Energy sub metering",
      col="red", axes = FALSE, ylim = c(0,40))
par(new=TRUE)
plot( date3+time3, Sub_metering_3,type="l", xlab= "", ylab="Energy sub metering",
      col="blue", axes = FALSE,ylim=c(0,40))
legend("topright",lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
detach(dat3)
dev.copy(png, file = "plot3.png", height=600, width=800) 
dev.off()