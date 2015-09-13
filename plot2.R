#Assuming the working directory is set and contains the dataset text file

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
png(filename = "plot2.png",width = 480,height = 480,units = "px")

# Very important to note that the strptime returned the DateTime Value in POSIXIT
# In order to plot the graph using new DateTime Column which was added, the class needs to 
# be converted to POSIXCT
plot(odata1$Global_active_power~ as.POSIXct(odata1$DateTime),type="l",ylab ="Global Active Power (kilowatts)",xlab="")

#Save the plot as png
dev.copy(png)

#Remove subset data to free up the memory
rm(odata1)

#Release handle to the graphic device as we have used one command for png and one for plot function
dev.off ()
dev.off()

