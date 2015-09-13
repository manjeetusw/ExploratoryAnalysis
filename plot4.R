setwd("/home/msingh/Desktop/Exploratory Analysis/Week1")

# Read Data 
odata=read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = c("?"),stringsAsFactors=FALSE)

#Create a new field to hold values from Date and Time fields
odata$DateTime=strptime(paste(odata$Date,odata$Time),"%d/%m/%Y %H:%M:%S")

#Change the data type/class of the Date field
odata$Date=as.Date(odata$Date,format="%d/%m/%Y")

#Get subset of data
odata1=odata[odata$Date>='2007-02-01' & odata$Date<='2007-02-02' ,]

#We can now remove main dataset which is very costly to keep in memory
rm(odata)

#Pass the name of file and width and height
png(filename = "plot4.png")

#Set graphical parameters to encorporate 4 plots
par(mfrow=c(2,2),mar=c(4,4,2,1), oma=c(0,0,2,0))

#First plot the metering_3 in a color Blue
with(odata1, {plot(odata1$Global_active_power~ as.POSIXct(odata1$DateTime),type="l",ylab ="Global Active Power",xlab="")
              plot(odata1$Voltage~ as.POSIXct(odata1$DateTime),type="l",ylab ="Voltage",xlab="datetime")
              plot(c(DateTime),c(Sub_metering_1),type="l",ylab ="Energy sub metering",xlab="")})

# Execute following three lines of code for the 1st Plot in 2nd Row
  #One: Use line to plot metering2 in color Red
  lines(odata1$DateTime,odata1$Sub_metering_2,col="red")
  #Two: Use line to plot metering1 in color black
  lines(odata1$DateTime,odata1$Sub_metering_3,col="blue")
  #Three: create legend
  legend("topright",c(colnames(odata1)[7],colnames(odata1)[8],colnames(odata1)[9]),col=c("black","red","blue"),lty = c(1,1,1))

#plot 4th graph as 2nd plot on 2nd row
plot(odata1$Global_reactive_power~ as.POSIXct(odata1$DateTime),type="l",ylab="Global_reactive_power",xlab="datetime")


#Save the plot as png
dev.copy(png)

#Remove subset data to free up the memory
rm(odata1)


#Release handle to the graphic device as we have used one command for png and one for plot function
dev.off ()
dev.off()

