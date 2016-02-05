
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
#mydataplot2v2 <- subsetdata
#mydataplot2v2$datetime <- paste(subsetdata$Date,subsetdata$Time)
#mydataplot2v2$datetime <- dmy_hms(mydataplot2v2$datetime)

#PLOT1
par(mfrow=c(1,1))
png(file="plot1.png",width=480,height=480)
hist(mydataplot1$Global_active_power, main = "Global Active Power", breaks = 15, xlab = "Global Active Power (kilowatts)", col="red",xaxt="n")
axis(side = 1, at = c(0,1000,2000,3000), labels = c("0","2","4","6"))
dev.off()