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


# Question 5
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

## Get motor vehicle Baltimore emissions
Baltimore <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
BaltimoreAgg <- aggregate(Emissions ~ year, data=Baltimore, FUN=sum)

## Plot
library(ggplot2)
BaltV <- ggplot(BaltimoreAgg, aes(factor(year), Emissions)) +
        geom_bar(stat="identity") +
        labs(x="year", y="Emissions") +
        ggtitle("Motor Vehicle Emissions for Baltimore")
BaltV
dev.copy(png,"plot5.png")
dev.off()