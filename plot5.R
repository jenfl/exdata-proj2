#NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

vehicleSCC <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]
vehicleNEI <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "24510",]

emissions1999 <- sum(vehicleNEI[vehicleNEI$year == 1999,"Emissions"])
emissions2002 <- sum(vehicleNEI[vehicleNEI$year == 2002,"Emissions"])
emissions2005 <- sum(vehicleNEI[vehicleNEI$year == 2005,"Emissions"])
emissions2008 <- sum(vehicleNEI[vehicleNEI$year == 2008,"Emissions"])

x <- c(1999, 2002, 2005, 2008)
y <- c(emissions1999, emissions2002, emissions2005, emissions2008)

#png(filename="plot1.png", width=480, height=480)
par(cex.axis=.75, cex.lab=.75)
plot (x,y, pch=20, 
      xlab="Year of sample", 
      ylab="Total PM2.5 from vehicle-related sources in Baltimore City, MD",
      type="n")
lines(x, y, col="red")