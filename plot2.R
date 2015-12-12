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



# get the data for the second picture
time<- hms(dat1$Time)
dat2<- mutate(dat1, Time = time)
dat2<- rename(dat2, date2= Date,time2= Time, gap2= Global_active_power) %>%
  select(date2, time2, gap2) 


# plot the global active power against time
attach(dat2)
plot( date2+time2, gap2, type="l", xlab= "", ylab="Global Active Power(Kilowatts)")
detach(dat2)

# copy to png 
dev.copy(png, file = "plot2.png", height=600, width=800) 
dev.off()

