# How have emissions from motor vehicle sources changed
# from 1998 to 2008 in Baltimore City?

# Read in our data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Figure out what SCC codes relate to vehicles
vehicleSCC <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]
# Reduce our data frame to just vehicle-related in Baltimore City
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "24510",]

# Sum up the emissions for each year from our reduced data frame
emissions1999 <- sum(vehicleNEI[vehicleNEI$year == 1999,"Emissions"])
emissions2002 <- sum(vehicleNEI[vehicleNEI$year == 2002,"Emissions"])
emissions2005 <- sum(vehicleNEI[vehicleNEI$year == 2005,"Emissions"])
emissions2008 <- sum(vehicleNEI[vehicleNEI$year == 2008,"Emissions"])

# Populate x and y values
x <- c(1999, 2002, 2005, 2008)
y <- c(emissions1999, emissions2002, emissions2005, emissions2008)

# Plot a red line plot to png
png(filename="plot5.png", width=480, height=480)
par(cex.axis=.75, cex.lab=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from vehicle-related sources",
      type="n")
title(main="PM2.5 Emissions from Motor Vehicles in Baltimore City, MD")
lines(x, y, col="red")
dev.off()