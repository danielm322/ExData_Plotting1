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
png("plot3.png")
with(subsdata,plot(Sub_metering_1+Sub_metering_2+Sub_metering_3~DateTime,type="n",lwd=1,xaxt="n",xlab="",ylab="Energy sub metering"))
with(subsdata,lines(Sub_metering_1~DateTime,col="black"))
with(subsdata,lines(Sub_metering_2~DateTime,col="red"))
with(subsdata,lines(Sub_metering_3~DateTime,col="blue"))
legend("topright",pch="-",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lwd=2)
#I had to do next since by default the day names for the plot were in spanish, my native language
axis(side=1,at=c(subsdata$DateTime[1],subsdata$DateTime[1440],subsdata$DateTime[2880]),labels=c("Thu","Fri","Sat"))
dev.off()