library(ggplot2)

#NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
#SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

vehicleSCC <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]
baltVehEmissions <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "24510",]
laVehEmissions <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "06037",]

locationCol <- c()
yearCol <- c()
emissionCol <- c()
sampleYears <- c(1999, 2002, 2005, 2008)

for (y in sampleYears) {
    xB = sum(baltVehEmissions[baltVehEmissions$year == y, "Emissions"])
    locationCol <- c(locationCol, "Baltimore")
    yearCol <- c(yearCol, y)
    emissionCol <- c(emissionCol, xB)
    xL = sum(laVehEmissions[laVehEmissions$year == y, "Emissions"])
    locationCol <- c(locationCol, "Los Angeles")
    yearCol <- c(yearCol, y)
    emissionCol <- c(emissionCol, xL)
}

df <- data.frame(locationCol, yearCol, emissionCol)

#png(filename="plot6.png", width=480, height=480)
bp <- qplot(yearCol, emissionCol, data=df, 
            colour=locationCol, geom="line", 
            xlab="Year of sample", ylab="PM2.5 emissions in tons")
bp <- bp+theme(legend.title=element_blank())
bp