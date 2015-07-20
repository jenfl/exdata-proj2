# Compare emissions from motor vehicle sources in Baltimore City
# with emissions from motor vehicle sources in Los Angles County, CA.
# Which city has seen greater changes over time in motor vehicle 
# emissions?

library(ggplot2)
library(gridExtra)

# Read in our data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")
SCC <- readRDS("exdata_data_NEI_data/Source_Classification_Code.rds")

# Figure out the SCC codes for vehicle-related data
vehicleSCC <- SCC[grep("Vehicles", SCC$EI.Sector), "SCC"]
# Reduce a data frame to just Baltimore vehicles
baltVehEmissions <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "24510",]
# Another data frame to just LA vehicles
laVehEmissions <- NEI[NEI$SCC %in% vehicleSCC & NEI$fips == "06037",]

# Vectors for data
locationCol <- c()
yearCol <- c()
emissionCol <- c()
changeCol <- c()
sampleYears <- c(1999, 2002, 2005, 2008)

# Save 1999 values for each city
initBalt <- df[df$locationCol=="Baltimore" & df$yearCol == 1999,"emissionCol"]
initLA <- df[df$locationCol=="Los Angeles" & df$yearCol == 1999,"emissionCol"]

# For each year....
for (y in sampleYears) {
    # Sum up the Baltimore vehicle emissions for that year
    xB = sum(baltVehEmissions[baltVehEmissions$year == y, "Emissions"])
    # Populate our data vectors
    locationCol <- c(locationCol, "Baltimore")
    yearCol <- c(yearCol, y)
    emissionCol <- c(emissionCol, xB)
    changeCol <- c(changeCol, xB-initBalt)
    # Sum up the LA vehicle emissions for that year
    xL = sum(laVehEmissions[laVehEmissions$year == y, "Emissions"])
    # Populate our data vectore
    locationCol <- c(locationCol, "Los Angeles")
    yearCol <- c(yearCol, y)
    emissionCol <- c(emissionCol, xL)
    changeCol <- c(changeCol, xL-initLA)
}
# Fill a data frame with our emission sums
df <- data.frame(locationCol, yearCol, emissionCol, changeCol)

# First plot, actual values
actual <- qplot(yearCol, emissionCol, data=df, 
            colour=locationCol, geom="line", 
            xlab="Year of sample", ylab="PM2.5 emissions, in tons")
actual <- actual+theme(legend.title=element_blank()) +
    ggtitle("Actual value of emissions for each year")

# Second plot, show changes
changes <- qplot(yearCol, changeCol, data=df,
                 colour=locationCol, geom="line",
                 xlab="Year of sample", ylab="Change from 1999 PM2.5 emissions, in tons")
changes <- changes + theme(legend.title=element_blank()) + 
    ggtitle("Change in emissions from 1999 values at each location")

# Write out both plots
png(filename="plot6.png", width=960, height=480)
grid.arrange(actual, changes, ncol=2)
dev.off()