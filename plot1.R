#Assuming the working directory is set and contains the dataset text file

# Read Data 
odata=read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = c("?"),stringsAsFactors=FALSE)

#Change the data type/class of the Date field so that it can be used for subsetting the data
odata$Date=as.Date(odata$Date,format="%d/%m/%Y")

#Get subset of data
odata1=odata[odata$Date>='2007-02-01' & odata$Date<='2007-02-02' ,]

#We can now remove main dataset which is very costly to keep in memory
rm(odata)

# Draw plot using hist function
hist(odata1$Global_active_power,col="red",xlab = "Global Active Power (kilowatts)")

#Save the plot as png
dev.copy(png,file="plot1.png")

#Remove subset data to free up the memory
rm(odata1)

#Release handle to the graphic device a
dev.off ()

