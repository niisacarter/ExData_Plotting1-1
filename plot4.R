
# install packages
install.packages("dplyr")
install.packages("lubridate")
install.packages("chron")
install.packages("plotrix")

#loads library
library(dplyr)
library(lubridate)
library(chron)
library(plotrix)

#creates directory to store data
if(!file.exists("./data")){dir.create("./data")}

# downloades file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, dest="household_power_consumption.zip", mode="wb")

#unzips file
unzip("household_power_consumption.zip")

#reads file
readdata <- read.table("household_power_consumption.txt",header=TRUE, sep = ";")
#filters for just dates needed
subsetdata <- filter(readdata, Date == "1/2/2007" | Date == "2/2/2007")
#transformations of data columns
mydataplot1 <- transform(subsetdata, Global_active_power= as.numeric(Global_active_power))
mydataplot2v2 <- subsetdata
mydataplot2v2$datetime <- paste(subsetdata$Date,subsetdata$Time)
mydataplot2v2$datetime <- dmy_hms(mydataplot2v2$datetime)

#PLOT4
par(mfrow=c(2,2))
png(file="plot4.png",width=1480,height=1480)

plot(mydataplot2v2$datetime,mydataplot2v2$Global_active_power, yaxt="n",xlab="", ylab="Global Active Powers)", type="l")
axis(side=2, at=c(0,1000,2000,3000), labels = c("0","2","4","6"))

plot(mydataplot2v2$datetime,mydataplot2v2$Voltage, ylab="Voltage", xlab="datetime", yaxt="n",type="l")
axis(side=2, at=c(800,1200,1600,2000), labels=c("23.4","23.8","24.2","24.6"))

plot(mydataplot2v2$datetime,mydataplot2v2$Sub_metering_1, yaxt="n", ylab="Energy sub metering", xlab="", type="n")
lines(mydataplot2v2$datetime,mydataplot2v2$Sub_metering_1, type="l")
lines(mydataplot2v2$datetime,mydataplot2v2$Sub_metering_2, type="l", col="red")
lines(mydataplot2v2$datetime,mydataplot2v2$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col = c("black","red","blue"))

plot(mydataplot2v2$datetime,mydataplot2v2$Global_reactive_power, yaxt="n", xlab="datetime", ylab="Global_reactive_pwer", type="l")
axis(side=2,at=c(0,50,100,150,200),labels=c("0.1","0.2","0.3","0.4","0.5"))
dev.off()