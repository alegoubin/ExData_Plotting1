buildPlot4 <- function (wd,width,height) {
  
  # set working directory with source file and saved plots
  setwd(wd)
  
  ## Read source data
  fullData <- read.csv("household_power_consumption.txt", header = TRUE, sep = ";")
  
  ## Convert fields into correct format
  fullData$Date<-as.Date(fullData$Date,format="%d/%m/%Y")
  fullData$Time<-strptime(x = as.character(fullData$Time),format = "%H:%M:%S")
  fullData$Time<- format(fullData$Time, "%H:%M:%S")
  
  ##subset data
  fullData <- fullData[(fullData$Date=="2007-02-01") | (fullData$Date=="2007-02-02"),]
  
  ## Convert fields into correct format
  fullData$Global_active_power <- as.numeric(as.character(fullData$Global_active_power))
  fullData$Global_reactive_power<- as.numeric(as.character(fullData$Global_reactive_power))
  fullData$Voltage<- as.numeric(as.character(fullData$Voltage))  
  fullData$Global_intensity <- as.numeric(as.character(fullData$Global_intensity))
  fullData$Sub_metering_1 <- as.numeric(as.character(fullData$Sub_metering_1))    
  fullData$Sub_metering_2 <- as.numeric(as.character(fullData$Sub_metering_2))   
  fullData$Sub_metering_3 <- as.numeric(as.character(fullData$Sub_metering_3))    
  
  df <- fullData
  
  #sets a 2 * 2 grid
  par(mfrow = c(2,2))
  
  #1st plot
  with(df,plot(as.POSIXct(paste(Date,Time)),Global_active_power,type="l",ylab = "Global Active Power (kilowatts)",xlab=""))  
  
  #2nd plot
  with(df,plot(as.POSIXct(paste(Date,Time)),Voltage,type="l",ylab = "Voltage",xlab="datetime"))  
  
  #3rd plot
  with(df,plot(as.POSIXct(paste(Date,Time)),Sub_metering_1,type="l",ylab = "Energy sub metering",xlab=""))    
  with(df,lines(as.POSIXct(paste(Date,Time)),Sub_metering_2,col="red"))
  with(df,lines(as.POSIXct(paste(Date,Time)),Sub_metering_3,col="blue"))
  #legend without box + reduced size
  legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1),bty="n", cex=0.7)  
  
  #4th plot
  with(df,plot(as.POSIXct(paste(Date,Time)),Global_reactive_power,type="l",ylab = "Global_reactive_power",xlab="datetime"))  
  
  
  dev.copy(png, file="plot4.png", width=width, height=height)
  dev.off()
  cat("Plot4.png has been saved in", getwd())
  
}    






