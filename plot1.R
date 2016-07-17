setwd("D:/R/Exploratory/w1")
rm(list=ls())

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

# Checking for NAs in the subsetted data
sum(is.na(subsdata))  #Seems there are no missing values in the subsetted data

#Plotting the desired graph
hist(subsdata$Global_active_power,col="red", main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.copy(png,file="plot1.png",width=480,height=480)
dev.off()
