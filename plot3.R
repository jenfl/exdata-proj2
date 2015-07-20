# Of the four types of sources (point, nonpoint, onroad, nonroad), 
# which of these four sources have seen decreases in emissions from
# 1998-2008 for Baltimore City?  Which have seen increases?

library(ggplot2)

# Read in data
NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

# Pull out just Baltimore City
baltemissions <- NEI[NEI$fips == "24510",]

sourcetypes <- c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD")
years <- c(1999, 2002, 2005, 2008)

sourcecol <- c()
yearcol <- c()
emissioncol <- c()

# For each source and each year....
for (i in sourcetypes) {
    for (j in years) {
        # Sum up the emissions
        x = sum(baltemissions[baltemissions$type == i & baltemissions$year == j, "Emissions"])
        # Add this data to vectors that will populate a data frame
        sourcecol <- c(sourcecol, i)
        yearcol <- c(yearcol, j)
        emissioncol <- c(emissioncol, x)
    }
}
# Create a data frame with the data we gathered
baltsources = data.frame(sourcecol, yearcol, emissioncol)

# Plot to a png file with a line plot
bp <- qplot(yearcol, emissioncol, data=baltsources, 
      colour=sourcecol, geom="line", 
      xlab="Year of sample", ylab="PM2.5 emissions, in tons")
bp <- bp+theme(legend.title=element_blank())+
    ggtitle("Baltimore City PM2.5 Levels Across Sources")
bp
ggsave(filename="plot3.png", width=3, height=2, units="in", dpi=100, scale=2)
