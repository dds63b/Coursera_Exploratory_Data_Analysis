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


# Question 1
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
## Using the base plotting system, make a plot showing the total PM2.5 emission from all
## sources for each of the years 1999, 2002, 2005, and 2008.
Totals <- aggregate(Emissions ~ year, NEI, sum)
png('plot1.png')
barplot(height=Totals$Emissions, names.arg=Totals$year,
        xlab="Year", ylab="Emissions",
        main="Total Emissions per Year"
        )
dev.off()