#First, cleaning the workspace
rm(list=ls())

setwd("D:/R/Exploratory/w1")

# Downloading and extracting files
if (!file.exists("power.zip")){
    url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(url,"power.zip")
} 

if (!file.exists("household_power_consumption.txt")) { 
    unzip("power.zip") 
}

# Reading the file
data1 <- read.table("household_power_consumption.txt",header=T,sep=";",na.strings = "?")

#Subsetting the file by the Dates required
library(lubridate)
data1$Date <- dmy(data1$Date)
subsdata <- subset(data1,Date>="2007-02-01" & Date<="2007-02-02")
subsdata$DateTime <- ymd_hms(paste(subsdata$Date,subsdata$Time))

# Checking for NAs in the subsetted data
sum(is.na(subsdata))  #Seems there are no missing values in the subsetted data

#Plotting the desired graph
with(subsdata,plot(DateTime,Global_active_power,type="l",lwd=1,xaxt="n",xlab="",ylab="Global Active Power (kilowatts)"))
#I had to do next since by default the day names for the plot were in spanish, my native language
axis(side=1,at=c(subsdata$DateTime[1],subsdata$DateTime[1440],subsdata$DateTime[2880]),labels=c("Thu","Fri","Sat"))
dev.copy(png,file="plot2.png",width=480,height=480)
dev.off()
