# download the data
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "rawdata.zip")
unzip("rawdata.zip")

# read the data into dat and clean the data
library(dplyr)
dat<- read.table("household_power_consumption.txt",header = T, sep = ";",stringsAsFactors = F)
date<- as.Date(dat$Date,  "%d/%m/%Y")
gap<- as.numeric(dat$Global_active_power)
dat1<- mutate(dat, Date= date, Global_active_power = gap)
d1<- as.Date("1/2/2007",  "%d/%m/%Y")
d2<- as.Date("2/2/2007",  "%d/%m/%Y")
dat1<- subset(dat1, dat1$Date==d1|dat1$Date==d2)

# plot the histogram
hist(dat1$Global_active_power,main = "Global Active Power",
     xlab ="Global Active Power(kilowatts)", col = "red" )

# copy to png 
dev.copy(png, file = "plot1.png", height=600, width=800) 
dev.off()
