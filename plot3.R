library(ggplot2)

#NEI <- readRDS("exdata_data_NEI_data/summarySCC_PM25.rds")

baltemissions <- NEI[NEI$fips == "24510",]

sourcetypes <- c("POINT", "NONPOINT", "ON-ROAD", "NON-ROAD")
years <- c(1999, 2002, 2005, 2008)

sourcecol <- c()
yearcol <- c()
emissioncol <- c()

for (i in sourcetypes) {
    for (j in years) {
        x = sum(baltemissions[baltemissions$type == i & baltemissions$year == j, "Emissions"])
        sourcecol <- c(sourcecol, i)
        yearcol <- c(yearcol, j)
        emissioncol <- c(emissioncol, x)
    }
}
baltsources = data.frame(sourcecol, yearcol, emissioncol)

#png(filename="plot3.png", width=480, height=480)
bp <- qplot(yearcol, emissioncol, data=baltsources, 
      colour=sourcecol, geom="line", 
      xlab="Year of sample", ylab="PM2.5 emissions in tons")
bp <- bp+theme(legend.title=element_blank())
bp