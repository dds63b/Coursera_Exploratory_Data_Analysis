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

# Question 3
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad)
## variable, which of these four sources have seen decreases in emissions from 1999–2008
## for Baltimore City? Which have seen increases in emissions from 1999–2008?
## Use the ggplot2 plotting system to make a plot answer this question.

## Subset by Baltimore
baltimore <- NEI[NEI$fips=="24510",]
## Plot
library(ggplot2)
BaltimorePlot <- ggplot(baltimore,aes(factor(year),Emissions,fill=type)) +
        geom_bar(stat="identity") +
        facet_grid(.~type) +
        labs(x="year", y="Emissions") +
        labs(title=expression("Baltimore Emissions by Source Type"))
BaltimorePlot
dev.copy(png,"plot3.png")
dev.off()