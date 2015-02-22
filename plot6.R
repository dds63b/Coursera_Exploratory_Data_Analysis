# Preparing environment
## Set working directory
setwd('./Coursera/Exploratory_Data_Analysis')

## Download file if it doesn't already exist
data <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip'
local.data <- 'ExDA_project2.zip'

if (! file.exists(local.data)) {
        download.file(data,
                      destfile = local.data, method = 'curl')
}

## Unzip local data
if (file.exists(local.data)) {
        unzip(local.data)
}
## Remove downloaded archive
file.remove(local.data)

## Reading data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


# Question 6
## Compare emissions from motor vehicle sources in Baltimore City with emissions from motor
## vehicle sources in Los Angeles County, California (fips == "06037").
## Which city has seen greater changes over time in motor vehicle emissions?

## Get motor vehicle Baltimore and LA emissions
Baltimore <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
Baltimore$Location <- "Baltimore"
LA <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
LA$Location <- "Los Angeles"

Baltimore_LA <- rbind(Baltimore,LA)

## Plot
library(ggplot2)
Baltimore_LA_Plot <- ggplot(Baltimore_LA,aes(factor(year),Emissions,fill=Location)) +
        geom_bar(stat="identity") +
        facet_grid(.~Location) +
        labs(x="year", y="Emissions") +
        ggtitle("Baltimore and LA Emissions")
Baltimore_LA_Plot
dev.copy(png,"plot6.png")
dev.off()